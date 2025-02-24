// biome-ignore lint/style/useNodejsImportProtocol: <explanation>
import * as readline from 'readline';
import chalk from 'chalk';
import * as dotenv from 'dotenv';
dotenv.config();
main();

async function main() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  function showMenu(options: string | string[], selectedIndex = 0) {
    console.clear();
    for (let i = 0; i < options.length; i++) {
      const prefix = i === selectedIndex ? '> ' : '  ';
      console.log(prefix + options[i]);
    }
  }

  function selectOption(options: string | string[]) {
    return new Promise((resolve) => {
      let selectedIndex = 0;
      showMenu(options, selectedIndex);

      process.stdin.on('keypress', (_, key) => {
        if (key.name === 'up') {
          selectedIndex = (selectedIndex - 1 + options.length) % options.length;
          showMenu(options, selectedIndex);
        } else if (key.name === 'down') {
          selectedIndex = (selectedIndex + 1) % options.length;
          showMenu(options, selectedIndex);
        } else if (key.name === 'return') {
          console.clear();
          resolve(options[selectedIndex]);
        }
      });

      process.stdin.setRawMode(true);
      process.stdin.resume();
    });
  }

  const question = (query: string): Promise<string> =>
    new Promise((resolve) => rl.question(query, resolve));

  // Get API configuration
  let name = await question(`App Name (.env: ${process.env.APP_NAME}): `);

  let apiKey = await question(
    'API key(this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works): '
  );
  let endpoint = await question('API endpoint (http://localhost:9011): ');
  let adminEmail = await question('Admin Email (admin@example.com): ');
  let adminPassword = await question('Admin Password (password): ');
  let redirectUri = await question(
    'Redirect URI (http://localhost:3001/api/auth/callback/fusionauth): '
  );

  name = name || process.env.APP_NAME || '';
  apiKey =
    apiKey ||
    process.env.API_KEY ||
    'this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works';
  endpoint = endpoint || 'http://localhost:9011';
  adminEmail = adminEmail || process.env.ADMIN_EMAIL || 'admin@example.com';
  adminPassword = adminPassword || process.env.ADMIN_PASSWORD || 'password';
  redirectUri = redirectUri || process.env.REDIRECT_URI || '';

  if (!name) {
    console.error(
      chalk.red(
        'APP_NAME is required, please set them in .env or pass in as parameters'
      )
    );
    process.exit(1);
  }
  const runner = new ApiRunner(
    {
      name,
      apiKey,
      endpoint,
      adminEmail,
      adminPassword,
      redirectUri,
    },
    {
      AUTH_FUSIONAUTH_CLIENT_ID: '',
      AUTH_FUSIONAUTH_CLIENT_SECRET: '',
      AUTH_FUSIONAUTH_TENANT_ID: '',
      AUTH_FUSIONAUTH_ISSUER: '',
      AUTH_SECRET: '',
    }
  );

  const options = ['Setup', 'Steam', 'Xbox'];
  const selected = await selectOption(options);
  if (selected === 'Steam') {
    console.log(chalk.blue('Setting up Steam IDP'));
    const clientId = await question('Client ID: ');
    const webAPIKey = await question('Web API Key: ');
    await runner.createIdpSteam(clientId, webAPIKey);
  } else if (selected === 'Xbox') {
    console.log(chalk.blue('Setting up Xbox IDP'));
    const clientId = await question('Client ID: ');
    const clientSecret = await question('Client Secret: ');
    await runner.createIdpXbox(clientId, clientSecret);
  } else {
    console.log(chalk.blue('Starting creation'));
    await runner.runAll();
    const env = runner.getEnv();
    console.log(
      chalk.bgYellow.black(
        'Put the below values into your Next.js local.env file:'
      )
    );
    console.log(
      chalk.bgBlack.white(`
AUTH_FUSIONAUTH_CLIENT_ID=${env.AUTH_FUSIONAUTH_CLIENT_ID}
AUTH_FUSIONAUTH_CLIENT_SECRET=${env.AUTH_FUSIONAUTH_CLIENT_SECRET}
AUTH_FUSIONAUTH_TENANT_ID=${env.AUTH_FUSIONAUTH_TENANT_ID}
AUTH_FUSIONAUTH_ISSUER=${env.AUTH_FUSIONAUTH_ISSUER}
AUTH_SECRET=${randomString()}
`)
    );

    const config = runner.getConfig();
    console.log(
      chalk.bgYellow.black(`Accessing FusionAuth at ${config.endpoint}`)
    );
    console.log(
      chalk.bgBlack.white(`
Admin Email: ${config.adminEmail}
Admin Password: ${config.adminPassword}
Redirect URI: ${config.redirectUri}
`)
    );

    const runDelete = await question('Delete Everything? (y/N) ');

    if (runDelete.toLowerCase().startsWith('y')) {
      await runner.deleteAll();
    }
  }
  rl.close();
}

interface ApiConfig {
  apiKey: string;
  endpoint: string;
  adminEmail: string;
  adminPassword: string;
  redirectUri: string;
  adminUserId?: string;
  name?: string;
  tenantId?: string;
  signingKeyId?: string;
  appId?: string;
  themeId?: string;
}

interface Output {
  AUTH_FUSIONAUTH_CLIENT_ID: string;
  AUTH_FUSIONAUTH_CLIENT_SECRET: string;
  AUTH_FUSIONAUTH_TENANT_ID: string;
  AUTH_FUSIONAUTH_ISSUER: string;
  AUTH_SECRET: string;
}

/** Web compatible method to create a random string of a given length */
function randomString(size = 32) {
  const bytes = crypto.getRandomValues(new Uint8Array(size));
  // @ts-expect-error
  return Buffer.from(bytes, 'base64').toString('base64');
}
function getOrigin(url: string) {
  const { protocol, host } = new URL(url);
  return `${protocol}//${host}`;
}

class ApiRunner {
  constructor(
    private config: ApiConfig,
    private output: Output
  ) {
    this.output.AUTH_FUSIONAUTH_ISSUER = this.config.endpoint;
  }
  public getConfig(): ApiConfig {
    return this.config;
  }
  public getEnv(): Output {
    return this.output;
  }
  private async singleApi(
    apiPath: string,
    options?: RequestInit
    // biome-ignore lint/suspicious/noExplicitAny: <explanation>
  ): Promise<{ ok: boolean; data: any }> {
    try {
      console.log(chalk.blue(`Calling API: ${apiPath}`));
      const defaultOptions: RequestInit = {
        headers: {
          Authorization: `${this.config.apiKey}`,
          'Content-Type': 'application/json',
        },
      };

      if (!apiPath.startsWith('/api/tenant/')) {
        //@ts-ignore
        defaultOptions.headers!['X-FusionAuth-TenantId'] =
          `${this.config.tenantId}`;
      }

      const allOptions = {
        ...options,
        headers: {
          ...defaultOptions.headers,
          ...options?.headers,
        },
      };

      const response = await fetch(
        `${this.config.endpoint}${apiPath}`,
        allOptions
      );

      if (options?.method === 'DELETE') {
        return {
          ok: true,
          data: null,
        };
      }

      if (response.ok) {
        return {
          ok: true,
          data: await response.json(),
        };
      }
      return {
        ok: false,
        data: null,
      };
    } catch (error) {
      console.error(chalk.red(`Error calling ${apiPath}:`), error);
      throw error;
    }
  }

  async updateDefaultTenantIssuer() {
    console.log(chalk.blue('Updating default tenant issuer'));
    const resp = await this.singleApi(
      '/api/tenant/0385e66c-90b3-9fa4-5e2c-fdab50684195',
      {
        method: 'PATCH',
        body: JSON.stringify({
          tenant: {
            issuer: this.config.endpoint,
          },
        }),
      }
    );
    if (!resp?.data?.tenant?.id) {
      console.log(
        chalk.red(
          'Failed to patch default tenant issuer:',
          JSON.stringify(resp.data)
        )
      );
      return;
    }
    console.log(
      chalk.green(
        'Default tenant patched with issuer:',
        resp?.data?.tenant?.issuer
      )
    );
  }

  async tenantCreate() {
    console.log(chalk.blue('Checking if tenant exists'));
    const search = await this.singleApi('/api/tenant/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          name: `${this.config.name}-tenant`,
          numberOfResults: 1,
          orderBy: 'name',
          startRow: 0,
        },
      }),
    });
    if (search?.data?.tenants[0]?.id) {
      console.log(
        chalk.green(
          'Tenant exists, id:',
          JSON.stringify(search.data.tenants[0].id)
        )
      );

      this.config.tenantId = search.data.tenants[0]?.id;
      this.output.AUTH_FUSIONAUTH_TENANT_ID = search.data.tenants[0]?.id;
      return;
    }

    console.log(chalk.blue('Tenant not found, creating tenant'));
    const resp = await this.singleApi('/api/tenant', {
      method: 'POST',
      body: JSON.stringify({
        tenant: {
          name: `${this.config.name}-tenant`,
          issuer: this.config.endpoint,
        },
      }),
    });
    if (!resp?.data?.tenant?.id) {
      console.log(
        chalk.red('Failed to create tenant:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(chalk.green('Tenant created:', resp?.data?.tenant?.id));
    this.config.tenantId = resp?.data?.tenant?.id;
    this.output.AUTH_FUSIONAUTH_TENANT_ID = resp?.data?.tenant?.id;
  }

  async createSigningKey() {
    console.log(chalk.blue('Checking if key exists'));
    const search = await this.singleApi('/api/key/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          name: `${this.config.name}-signing-key`,
          numberOfResults: 1,
          orderBy: 'name',
          startRow: 0,
        },
      }),
    });
    if (search?.data?.keys[0]?.id) {
      console.log(
        chalk.green('Key exists, id:', JSON.stringify(search.data.keys[0].id))
      );
      this.config.signingKeyId = search?.data?.keys[0]?.id;
      return;
    }

    console.log(chalk.blue('Key not found, Creating key'));
    const resp = await this.singleApi('/api/key/generate', {
      method: 'POST',
      body: JSON.stringify({
        key: {
          algorithm: 'RS256',
          name: `${this.config.name}-signing-key`,
          length: 2048,
        },
      }),
    });
    if (!resp?.data?.key?.id) {
      console.log(
        chalk.red('Failed to create key:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(chalk.green('Key created:', resp?.data?.key?.id));
    this.config.signingKeyId = resp?.data?.key?.id;
  }

  async addKeyToTenant() {
    console.log(chalk.blue('Adding key to tenant'));
    const resp = await this.singleApi(`/api/tenant/${this.config.tenantId}`, {
      method: 'PATCH',
      body: JSON.stringify({
        tenant: {
          jwtConfiguration: {
            accessTokenKeyId: this.config.signingKeyId,
            idTokenKeyId: this.config.signingKeyId,
          },
        },
      }),
    });
    if (!resp?.data?.tenant?.id) {
      console.log(
        chalk.red('Failed to patch tenant:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(
      chalk.green('Tenant patched:', resp?.data?.tenant?.jwtConfiguration)
    );
  }

  async createApp() {
    console.log(chalk.blue('Checking if app exists'));
    const search = await this.singleApi('/api/application/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          name: `${this.config.name}-app`,
        },
      }),
    });
    if (search?.data?.applications[0]?.id) {
      console.log(
        chalk.green(
          'App exists, id:',
          JSON.stringify(search.data.applications[0].id)
        )
      );
      this.config.appId = search?.data?.applications[0]?.id;
      this.output.AUTH_FUSIONAUTH_CLIENT_ID =
        search?.data?.applications[0]?.oauthConfiguration?.clientId;
      this.output.AUTH_FUSIONAUTH_CLIENT_SECRET =
        search?.data?.applications[0]?.oauthConfiguration?.clientSecret;
      return;
    }
    console.log(chalk.blue('App not found, creating app'));
    const resp = await this.singleApi('/api/application', {
      method: 'POST',
      headers: {
        'X-FusionAuth-TenantId': this.config.tenantId!,
      },
      body: JSON.stringify({
        application: {
          name: `${this.config.name}-app`,
          oauthConfiguration: {
            authorizedRedirectURLs: [`${this.config.redirectUri}`],
            authorizedOriginURLs: [getOrigin(this.config.redirectUri)],
            logoutURL: getOrigin(this.config.redirectUri),
            enabledGrants: ['authorization_code', 'refresh_token'],
            debug: true,
            generateRefreshTokens: true,
            requireRegistration: true,
          },
          jwtConfiguration: {
            enabled: true,
            accessTokenKeyId: this.config.signingKeyId,
            idTokenKeyId: this.config.signingKeyId,
          },
          registrationConfiguration: {
            enabled: true,
          },
          roles: [
            {
              name: 'admin',
            },
          ],
        },
      }),
    });
    if (!resp?.data?.application?.id) {
      console.log(
        chalk.red('Failed to create app:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(chalk.green('App created:', resp?.data?.application?.id));
    this.config.appId = resp?.data?.application?.id;
    this.output.AUTH_FUSIONAUTH_CLIENT_ID =
      resp?.data?.application?.oauthConfiguration?.clientId;
    this.output.AUTH_FUSIONAUTH_CLIENT_SECRET =
      resp?.data?.application?.oauthConfiguration?.clientSecret;
  }

  async createAdminUser() {
    console.log(chalk.blue('Checking if admin user exists'));
    const search = await this.singleApi('/api/user/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          queryString: this.config.adminEmail,
        },
      }),
    });
    if (search.data?.users[0]?.id) {
      console.log(
        chalk.green(
          'Admin user exists, id:',
          JSON.stringify(search.data.users[0].id)
        )
      );
      this.config.adminUserId = search?.data?.users[0]?.id;
      return;
    }

    console.log(chalk.blue('Admin User not found, creating admin user.'));
    const resp = await this.singleApi('/api/user/registration', {
      method: 'POST',
      body: JSON.stringify({
        user: {
          email: this.config.adminEmail,
          password: this.config.adminPassword,
        },
        registration: {
          applicationId: this.config.appId,
          roles: ['admin'],
        },
      }),
    });
    if (!resp?.data?.user?.id) {
      console.log(
        chalk.red('Failed to create admin user:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(chalk.green('Admin user created:', resp?.data?.user?.id));
    this.config.adminUserId = resp?.data?.user?.id;
  }

  async copyDefaultTheme() {
    console.log(chalk.blue('Checking if theme exists'));
    const search = await this.singleApi('/api/theme/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          name: `${this.config.name}-theme`,
        },
      }),
    });
    if (search?.data?.themes[0]?.id) {
      console.log(
        chalk.green(
          'Theme exists, id:',
          JSON.stringify(search.data.themes[0].id)
        )
      );
      this.config.themeId = search?.data?.themes[0]?.id;
      return;
    }
    console.log(chalk.blue('Theme not found, copying default theme'));
    const resp = await this.singleApi('/api/theme', {
      method: 'POST',
      body: JSON.stringify({
        sourceThemeId: '75a068fd-e94b-451a-9aeb-3ddb9a3b5987',
        theme: {
          name: `${this.config.name}-theme`,
        },
      }),
    });
    if (!resp?.data?.theme?.id) {
      console.log(
        chalk.red('Failed to create theme:', JSON.stringify(resp.data))
      );
    }
    console.log(chalk.green('Theme created:', resp?.data?.theme?.id));
    this.config.themeId = resp?.data?.theme?.id;
  }

  async addThemeToTenant() {
    console.log(chalk.blue('Adding theme to tenant'));
    const resp = await this.singleApi(`/api/tenant/${this.config.tenantId}`, {
      method: 'PATCH',
      body: JSON.stringify({
        tenant: {
          themeId: this.config.themeId,
        },
      }),
    });
    if (!resp?.data?.tenant?.id) {
      console.log(
        chalk.red(
          'Failed to patch tenant with theme:',
          JSON.stringify(resp.data)
        )
      );
      return;
    }
    console.log(
      chalk.green('Tenant patched with theme:', resp?.data?.tenant?.themeId)
    );
  }

  // Delete the things, note deleting a tenant deletes all apps and users.

  async tenantDelete() {
    console.log(chalk.blue('Deleting tenant'));
    const del = await this.singleApi(`/api/tenant/${this.config.tenantId}`, {
      method: 'DELETE',
      body: JSON.stringify({
        async: false,
      }),
    });
    if (del.ok) {
      console.log(chalk.green('Tenant deleted'));
    } else {
      console.log(chalk.red('Failed to delete tenant'));
    }
  }

  async themeDelete() {
    console.log(chalk.blue('Deleting theme'));
    const del = await this.singleApi(`/api/theme/${this.config.themeId}`, {
      method: 'DELETE',
    });
    if (del.ok) {
      console.log(chalk.green('Theme deleted'));
    } else {
      console.log(chalk.red('Failed to delete theme'));
    }
  }

  async signingKeyDelete() {
    console.log(chalk.blue('Deleting signing key'));
    const del = await this.singleApi(`/api/key/${this.config.signingKeyId}`, {
      method: 'DELETE',
    });
    if (del.ok) {
      console.log(chalk.green('Key deleted'));
    } else {
      console.log(chalk.red('Failed to delete signing key'));
    }
  }

  async adminUserDelete() {
    console.log(chalk.blue('Deleting admin user'));
    const del = await this.singleApi(`/api/user/${this.config.adminUserId}`, {
      method: 'DELETE',
    });
    if (del.ok) {
      console.log(chalk.green('Admin user deleted'));
    } else {
      console.log(chalk.red('Failed to delete admin user'));
    }
  }

  async createIdpSteam(client_id: string, webAPIKey: string) {
    // Make sure app exists
    if (!this.config.appId) {
      await this.createApp();
    }

    let idpId: string | undefined;
    console.log(chalk.blue('Checking if IdP Steam exists'));
    const search = await this.singleApi('/api/identity-provider/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          type: 'Steam',
        },
      }),
    });
    if (search.data?.identityProviders[0]?.id) {
      console.log(
        chalk.blue(
          'Steam IDP exists, patching:',
          JSON.stringify(search.data.identityProviders[0].id)
        )
      );
      idpId = search.data.identityProviders[0].id;

      const resp = await this.singleApi(`/api/identity-provider/${idpId}`, {
        method: 'PATCH',
        body: JSON.stringify({
          identityProvider: {
            ...search.data.identityProviders[0],
            client_id,
            webAPIKey,
          },
        }),
      });
      if (!resp?.data?.identityProvider?.id) {
        console.log(
          chalk.red('Failed to patch Steam IDP:', JSON.stringify(resp.data))
        );
        return;
      }
      console.log(
        chalk.green('Steam IDP patched:', resp?.data?.identityProvider?.id)
      );

      return;
    }

    console.log(chalk.blue('Steam IDP not found, creating IDP.'));
    const resp = await this.singleApi('/api/identity-provider', {
      method: 'POST',
      body: JSON.stringify({
        identityProvider: {
          applicationConfiguration: {
            //@ts-ignore
            [this.config.appId]: {
              enabled: true,
            },
          },
          client_id,
          webAPIKey,
          debug: true,
          enabled: true,
          linkingStrategy: 'CreatePendingLink',
          scope: '',
          type: 'Steam',
        },
      }),
    });
    if (!resp?.data?.identityProvider?.id) {
      console.log(
        chalk.red('Failed to create Steam IDP:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(
      chalk.green('Steam IDP created:', resp?.data?.identityProvider?.id)
    );
  }

  async createIdpXbox(client_id: string, client_secret: string) {
    // Make sure app exists
    if (!this.config.appId) {
      await this.createApp();
    }

    let idpId: string | undefined;
    console.log(chalk.blue('Checking if IdP Xbox exists'));
    const search = await this.singleApi('/api/identity-provider/search', {
      method: 'POST',
      body: JSON.stringify({
        search: {
          type: 'Xbox',
        },
      }),
    });
    if (search.data?.identityProviders[0]?.id) {
      console.log(
        chalk.blue(
          'Xbox IDP exists, patching:',
          JSON.stringify(search.data.identityProviders[0].id)
        )
      );
      idpId = search.data.identityProviders[0].id;

      const resp = await this.singleApi(`/api/identity-provider/${idpId}`, {
        method: 'PATCH',
        body: JSON.stringify({
          identityProvider: {
            ...search.data.identityProviders[0],
            client_id,
            client_secret,
          },
        }),
      });
      if (!resp?.data?.identityProvider?.id) {
        console.log(
          chalk.red('Failed to patch Xbox IDP:', JSON.stringify(resp.data))
        );
        return;
      }
      console.log(
        chalk.green('Xbox IDP patched:', resp?.data?.identityProvider?.id)
      );

      return;
    }

    console.log(chalk.blue('Xbox IDP not found, creating IDP.'));
    const resp = await this.singleApi('/api/identity-provider', {
      method: 'POST',
      body: JSON.stringify({
        identityProvider: {
          applicationConfiguration: {
            //@ts-ignore
            [this.config.appId]: {
              enabled: true,
            },
          },
          client_id,
          client_secret,
          debug: true,
          enabled: true,
          linkingStrategy: 'CreatePendingLink',
          scope: 'Xboxlive.signin Xboxlive.offline_access',
          type: 'Xbox',
        },
      }),
    });
    if (!resp?.data?.identityProvider?.id) {
      console.log(
        chalk.red('Failed to create Xbox IDP:', JSON.stringify(resp.data))
      );
      return;
    }
    console.log(
      chalk.green('Xbox IDP created:', resp?.data?.identityProvider?.id)
    );
  }

  async createRegistrationForm() {
    console.log(chalk.blue('Checking if Registration Form exists'));
    const search = await this.singleApi('/api/form', {
      method: 'GET',
    });
    const form = search.data?.forms.filter(
      (f: { name: string; id: string }) =>
        f.name === `${this.config.name}-registration-form`
    );
    if (form?.id) {
      console.log(
        chalk.blue(
          'Registration Form exists, update manually if needed.',
          JSON.stringify(form.id)
        )
      );
      await this.updateAppWithForm(form.id);
      return;
    }

    console.log(chalk.blue('Registration Form not found, creating form.'));
    const resp = await this.singleApi('/api/form', {
      method: 'POST',
      body: JSON.stringify({
        form: {
          name: `${this.config.name}-registration-form`,
        },
      }),
    });
    if (!resp?.data?.form?.id) {
      console.log(
        chalk.red(
          'Failed to create Registration Form:',
          JSON.stringify(resp.data)
        )
      );
      return;
    }
    console.log(
      chalk.green('Registration Form created:', resp?.data?.form?.id)
    );
    await this.updateAppWithForm(resp?.data?.form?.id);
  }

  async updateAppWithForm(formId: string) {
    console.log(
      chalk.blue('Updating app', this.config.appId, 'with form', formId)
    );
    const resp = await this.singleApi(`/api/application/${this.config.appId}`, {
      method: 'PATCH',
      body: JSON.stringify({
        application: {
          registrationConfiguration: {
            formId,
          },
        },
      }),
    });
    if (!resp?.data?.application?.id) {
      console.log(chalk.red('Failed to patch app:', JSON.stringify(resp.data)));
      return;
    }
    console.log(
      chalk.green(
        'App patched with form:',
        resp?.data?.application?.registrationConfiguration?.formId
      )
    );
  }

  async runAll() {
    await this.updateDefaultTenantIssuer(); //TODO: This feels like a bug.
    await this.tenantCreate();
    await this.createSigningKey();
    await this.addKeyToTenant();
    await this.createApp();
    await this.createAdminUser();
    await this.copyDefaultTheme();
    await this.addThemeToTenant();
    await this.createRegistrationForm();
  }

  async deleteAll() {
    await this.tenantDelete();
    await this.signingKeyDelete();
    await this.adminUserDelete();
  }
}
