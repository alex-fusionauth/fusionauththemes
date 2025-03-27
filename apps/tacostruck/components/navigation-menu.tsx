import { CoinbaseLogo } from '@/components/coinbase-logo';
import { NavigationSheet } from '@/components/navigation-sheet';
import { Button } from '@/components/ui/button';
import Link from 'next/link';

const navigationLinks = [
  { href: '/', label: 'About' },
  { href: '/', label: 'Products' },
  { href: '/', label: 'Help' },
];
import { CoinbaseTitle } from '@/components/coinbase-title';
import { auth, signIn, signOut } from '../auth';

export async function NavigationMenu() {
  const session = await auth();

  return (
    <header className="sticky top-0 z-50 w-full border-b">
      <div className="container flex h-16 items-center justify-between">
        <div className="flex items-center gap-4 h-16 items-middle">
          <NavigationSheet />
          <Link href="/" className="flex items-center space-x-2">
            <CoinbaseLogo className="h-8 w-auto" />
            <CoinbaseTitle className="h-8 hidden md:block w-auto pt-1.5" />
          </Link>
        </div>
        <nav className="hidden items-center space-x-6 md:flex">
          {navigationLinks.map((link) => (
            <Link
              key={link.label}
              href={link.href}
              className="text-sm font-medium hover:underline"
            >
              {link.label}
            </Link>
          ))}
        </nav>
        <div className="flex items-center space-x-4">
          {!session?.user ? (
            <form
              className="flex gap-2"
              action={async () => {
                'use server';
                await signIn('fusionauth');
              }}
            >
              <Button variant="default">Sign in</Button>
            </form>
          ) : (
            <form
              action={async () => {
                'use server';
                await signOut({ redirectTo: '/api/logout' });
              }}
            >
              <Button variant="default" className="" type="submit">
                Sign Out
              </Button>
            </form>
          )}
        </div>
      </div>
    </header>
  );
}
