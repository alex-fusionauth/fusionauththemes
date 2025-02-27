import { auth } from '@/auth';
import { NextResponse } from 'next/server';

export default auth((req) => {
  if (process.env.SHOW_AUTH) {
    console.log('AUTH', req.auth);
  }

  if (!req.auth && req.nextUrl.pathname.startsWith('/protected')) {
    return NextResponse.redirect(new URL('/', req.nextUrl.origin));
  }
  if (req.auth && req.nextUrl.pathname === '/') {
    return NextResponse.redirect(new URL('/protected', req.nextUrl.origin));
  }
  return NextResponse.next();
});

// Optionally, don't invoke Middleware on some paths
export const config = {
  matcher: [
    '/((?!api|image-proxy|images|fonts|_next/static|_next/image|favicon.ico|sitemap.xml|robots.txt).*)',
  ],
};
