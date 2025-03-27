import { type NextRequest, NextResponse } from 'next/server';

export async function GET(req: NextRequest) {
  return NextResponse.redirect(
    `${process.env.AUTH_FUSIONAUTH_ISSUER}/oauth2/logout?client_id=${process.env.AUTH_FUSIONAUTH_CLIENT_ID}`
  );
}
