import * as readline from 'readline';
import chalk from 'chalk';

interface ApiConfig {
  key: string;
  endpoint: string;
  tenantId?: string;
}

class ApiRunner {
  constructor(private config: ApiConfig) {
    if (!this.config.key) {
      this.config.key =
        'this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works';
    }

    if (!this.config.endpoint) {
      this.config.endpoint = 'http://localhost:9011';
    }
    this.config.tenantId = '';
  }

  private async tenantCreate() {
    const name = 'iron-pixel';
    const resp = await this.runSingleApi('/api/tenant', {
      method: 'POST',
      body: JSON.stringify({
        tenant: {
          name,
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
  }

  // Create Key to match Auth.js HMAC 256
  // await this.runSingleApi('/api/key/generate/#{asymmetricKeyId}', {
  //   method: 'POST',
  //   body: JSON.stringify({
  //     key: {
  //       algorithm: 'RS256',
  //       name: 'For exampleapp',
  //       length: 2048,
  //     },
  //   }),
  // });

  private async runSingleApi(
    apiPath: string,
    options?: RequestInit
  ): Promise<{ ok: boolean; data: any }> {
    try {
      console.log(chalk.blue(`Calling API: ${apiPath}`));
      const defaultOptions: RequestInit = {
        headers: {
          Authorization: `${this.config.key}`,
          'Content-Type': 'application/json',
        },
      };

      const allOptions = { ...defaultOptions, ...options };

      const response = await fetch(
        `${this.config.endpoint}${apiPath}`,
        allOptions
      );

      if (response.ok) {
        return {
          ok: true,
          data: await response.json(),
        };
      }
      return {
        ok: false,
        data: await response.json(),
      };
    } catch (error) {
      console.error(chalk.red(`Error calling ${apiPath}:`), error);
      throw error;
    }
  }

  public async runAll() {
    console.log(chalk.green('Starting setup'));
    const tenant = await this.tenantCreate();
  }
}

async function main() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  const question = (query: string): Promise<string> =>
    new Promise((resolve) => rl.question(query, resolve));

  // Get API configuration
  const apiKey = await question(
    'Enter API key(this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works): '
  );
  const endpoint = await question(
    'Enter API endpoint (http://localhost:9011): '
  );

  const runner = new ApiRunner({ key: apiKey, endpoint });

  await runner.runAll();

  rl.close();
}

main().catch(console.error);
