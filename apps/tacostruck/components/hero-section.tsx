import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { auth, signIn } from '../auth';

export async function HeroSection() {
  const session = await auth();

  return (
    <div className="flex-1 flex items-center justify-center items-middle">
      <div className="container flex flex-col items-center justify-center space-y-8 py-24 text-center md:py-32">
        <h1 className="text-3xl font-bold tracking-tighter sm:text-5xl md:text-6xl">
          The future of money is here
        </h1>
        <p className="mx-auto max-w-[600px] md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
          Where Making Change is Our Only Business!
        </p>
        <div className="flex flex-col gap-4 sm:flex-row">
          {!session?.user && (
            <form
              className="flex gap-2"
              action={async () => {
                'use server';
                await signIn('fusionauth');
              }}
            >
              <Button size="lg" className="min-w-[200px]" type="submit">
                Get started
              </Button>
            </form>
          )}
          <Link href="/">
            <Button
              variant="outline"
              size="lg"
              className="min-w-[200px] bg-white/10 text-white hover:bg-white/20"
            >
              Learn more
            </Button>
          </Link>
        </div>
      </div>
    </div>
  );
}
