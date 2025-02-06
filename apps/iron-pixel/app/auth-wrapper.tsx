'use client';
import {
  FusionAuthProvider,
  FusionAuthProviderConfig,
} from '@fusionauth/react-sdk';

if (
  !process.env.NEXT_PUBLIC_FUSIONAUTH_CLIENT_ID ||
  !process.env.NEXT_PUBLIC_FUSIONAUTH_ISSUER
) {
  throw new Error('Missing Params');
}

const config: FusionAuthProviderConfig = {
  clientId: process.env.NEXT_PUBLIC_FUSIONAUTH_CLIENT_ID,
  redirectUri: '/',
  serverUrl: process.env.NEXT_PUBLIC_FUSIONAUTH_ISSUER,
  shouldAutoFetchUserInfo: true,
  shouldAutoRefresh: true,
  onRedirect: (state?: string) => {},
};
export function AuthWrapper({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return <FusionAuthProvider {...config}>{children}</FusionAuthProvider>;
}
