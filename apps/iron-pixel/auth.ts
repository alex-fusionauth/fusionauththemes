/// <reference types="next-auth" />
import NextAuth from 'next-auth';
export const { handlers, auth, signIn, signOut } = NextAuth({
  debug: true,
  providers: [
    {
      id: 'fusionauth',
      name: 'FusionAuth',
      type: 'oidc',
      issuer: process.env.AUTH_FUSIONAUTH_ISSUER!,
      clientId: process.env.AUTH_FUSIONAUTH_CLIENT_ID!,
      clientSecret: process.env.AUTH_FUSIONAUTH_CLIENT_SECRET!,
      authorization: {
        params: {
          scope: 'offline_access email openid profile',
          tenantId: process.env.AUTH_FUSIONAUTH_TENANT_ID!,
        },
      },
      userinfo: `${process.env.AUTH_FUSIONAUTH_ISSUER}/oauth2/userinfo`,
      // This is due to a known processing issue
      // TODO: https://github.com/nextauthjs/next-auth/issues/8745#issuecomment-1907799026
      token: {
        url: `${process.env.AUTH_FUSIONAUTH_ISSUER}/oauth2/token`,
        conform: async (response: Response) => {
          if (response.status === 401) return response;

          const newHeaders = Array.from(response.headers.entries())
            .filter(([key]) => key.toLowerCase() !== 'www-authenticate')
            .reduce(
              (headers, [key, value]) => (headers.append(key, value), headers),
              new Headers()
            );

          return new Response(response.body, {
            status: response.status,
            statusText: response.statusText,
            headers: newHeaders,
          });
        },
      },
    },
  ],
  session: {
    strategy: 'jwt',
  },
  // Required to get the account object in the session and enable
  // the ability to call API's externally that rely on JWT tokens.
  callbacks: {
    async jwt(params) {
      const { token, user, account } = params;
      if (account) {
        // First-time login, save the `access_token`, its expiry and the `refresh_token`
        return {
          ...token,
          ...account,
        };
      } else if (
        token.expires_at &&
        Date.now() < (token.expires_at as number) * 1000
      ) {
        // Subsequent logins, but the `access_token` is still valid
        return token;
      } else {
        // Subsequent logins, but the `access_token` has expired, try to refresh it
        if (!token.refresh_token) throw new TypeError('Missing refresh_token');

        try {
          const refreshResponse = await fetch(
            `${process.env.AUTH_FUSIONAUTH_ISSUER}/oauth2/token`,
            {
              method: 'POST',
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: new URLSearchParams({
                client_id: process.env.AUTH_FUSIONAUTH_CLIENT_ID!,
                client_secret: process.env.AUTH_FUSIONAUTH_CLIENT_SECRET!,
                grant_type: 'refresh_token',
                refresh_token: token.refresh_token as string,
              }),
            }
          );

          if (!refreshResponse.ok) {
            throw new Error('Failed to refresh token');
          }

          const tokensOrError = await refreshResponse.json();

          if (!refreshResponse.ok) throw tokensOrError;

          const newTokens = tokensOrError as {
            access_token: string;
            expires_in: number;
            refresh_token?: string;
          };

          return {
            ...token,
            access_token: newTokens.access_token,
            expires_at: Math.floor(Date.now() / 1000 + newTokens.expires_in),
            // Some providers only issue refresh tokens once, so preserve if we did not get a new one
            refresh_token: newTokens.refresh_token
              ? newTokens.refresh_token
              : token.refresh_token,
          };
        } catch (error) {
          console.error('Error refreshing access_token', error);
          // If we fail to refresh the token, return an error so we can handle it on the page
          token.error = 'RefreshTokenError';
          return token;
        }
      }
    },
    async session(params) {
      const { session, token } = params;
      return { ...session, ...token };
    },
  },
});

declare module 'next-auth' {
  interface Session {
    access_token: string;
    expires_in: number;
    id_token?: string;
    expires_at: number;
    refresh_token?: string;
    refresh_token_id?: string;
    error?: 'RefreshTokenError';
    scope: string;
    token_type: string;
    userId: string;
    provider: string;
    type: string;
    providerAccountId: string;
  }
}

declare module 'next-auth' {
  interface JWT {
    access_token: string;
    expires_in: number;
    id_token?: string;
    expires_at: number;
    refresh_token?: string;
    refresh_token_id?: string;
    error?: 'RefreshTokenError';
    scope: string;
    token_type: string;
    userId: string;
    provider: string;
    type: string;
    providerAccountId: string;
  }
}
