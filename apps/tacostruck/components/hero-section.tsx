import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { auth, signIn } from '../auth';

export async function HeroSection() {
  const session = await auth();

  return (
    <div className="flex-1 flex justify-center items-middle pt-8 md:pt-20">
      <div className="container flex flex-col items-center justify-center text-center">
        <h1 className="text-3xl font-bold tracking-tighter sm:text-5xl md:text-6xl">
          Find Your Next Taco Truck
        </h1>

        <div className="flex flex-col gap-4 sm:flex-row">
          {!session?.user && (
            <form
              className="flex gap-2"
              action={async () => {
                'use server';
                await signIn('fusionauth');
              }}
            >
              <Button size="lg" type="submit">
                Get started
              </Button>
            </form>
          )}
        </div>
        <div className="w-full h-full min-h-[800px] mt-8">
          <iframe
            title="Taco Trucks Map"
            src="https://www.google.com/maps/embed/v1/search?key=AIzaSyAyV0OsM6TfbYrdkP15QUlCGxT4tp6cUSM&q=taco+trucks"
            width="100%"
            height="100%"
            style={{ border: 0 }}
            allowFullScreen
            loading="lazy"
            className="w-full h-full min-h-[800px]"
          />
        </div>
      </div>
    </div>
  );
}
