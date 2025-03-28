import { Button } from '@/components/ui/button';
import Image from 'next/image';
import Link from 'next/link';
import { auth, signIn, signOut } from '../auth';

export async function NavigationMenu() {
  const session = await auth();

  return (
    <header className="fixed top-0 w-full z-50 bg-black/80 backdrop-blur-sm">
      <div className="container mx-auto px-4">
        <div className="container relative flex h-16 items-center justify-between">
          <Link href="/" className="flex items-center space-x-2">
            <div className="relative w-8 h-8">
              <Image
                src="/images/LogoIcon_Gradient.svg"
                alt="Iron Pixel Studios Logo"
                fill
                className="object-contain"
              />
            </div>
            <span className="text-white font-bold">IRON PIXEL STUDIOS</span>
          </Link>

          <nav className="absolute left-1/2 transform -translate-x-1/2 hidden items-center space-x-6 md:flex">
            <Link href="/" className="text-gray-300 hover:text-white">
              Games
            </Link>
            <Link href="/" className="text-gray-300 hover:text-white">
              About
            </Link>
            <Link href="/" className="text-gray-300 hover:text-white">
              News
            </Link>
            <Link href="/" className="text-gray-300 hover:text-white">
              Support
            </Link>
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
                <Button className="bg-emerald-500 hover:bg-emerald-600">
                  Sign In
                </Button>
              </form>
            ) : (
              <form
                action={async () => {
                  'use server';
                  await signOut({ redirectTo: '/api/logout' });
                }}
              >
                <Button variant="default" className="text-white" type="submit">
                  Sign Out
                </Button>
              </form>
            )}
          </div>
        </div>
      </div>
    </header>
  );
}
