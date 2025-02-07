import { FeaturedGames } from '@/components/featured-games';
import { Footer } from '@/components/footer';
import { NavigationMenu } from '@/components/navigation-menu';
import { Button } from '@/components/ui/button';
import Image from 'next/image';

export default function Home() {
  return (
    <>
      {/* Hero Section */}
      <section className="relative h-[80vh] overflow-hidden">
        <Image
          src="/images/GameImage_01.png"
          alt="Hero background"
          fill
          className="object-cover"
          priority
        />
        <div className="absolute inset-0 bg-gradient-to-r from-black/60 to-transparent">
          <div className="container mx-auto px-4 py-20 h-full flex items-center">
            <div className="max-w-2xl space-y-6">
              <h1 className="text-5xl font-bold text-white tracking-tight lg:text-6xl">
                Create Worlds,
                <br />
                Forge Adventures
              </h1>
              <p className="text-lg text-gray-200">
                Join Iron Pixel Studios in crafting the next generation of
                immersive gaming experiences.
              </p>
              <Button size="lg" className="bg-emerald-500 hover:bg-emerald-600">
                Sign Up
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Featured Games Section */}
      <section className="py-20 bg-[#0a0b0f]">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold text-white mb-12">
            Featured Games
          </h2>
          <FeaturedGames />
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold text-white mb-6">
            Ready to Begin Your Adventure?
          </h2>
          <p className="text-gray-400 mb-8">
            Join thousands of players in the Iron Pixel community
          </p>
          <Button size="lg" className="bg-emerald-500 hover:bg-emerald-600">
            Get Started
          </Button>
        </div>
      </section>

      <Footer />
    </>
  );
}
