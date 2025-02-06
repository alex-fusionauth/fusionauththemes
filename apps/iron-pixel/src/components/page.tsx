import { Footer } from '@/components/footer';
import { GameCard } from '@/components/game-card';
import { Header } from '@/components/header';

export default function Page() {
  return (
    <div className="min-h-screen">
      <Header />

      {/* Hero Section */}
      <section className="relative h-[80vh] -mx-2 overflow-hidden mt-[98px]">
        <div className="absolute inset-0 bg-gradient-radial  opacity-40" />
        <img
          src="/images/GameImage_01.png"
          alt="Game screenshot"
          className="absolute inset-0 w-full h-full object-cover object-center"
        />
        <div className="relative z-10 container mx-auto px-4 h-full flex items-center flex-row-reverse">
          <div className="max-w-2xl bg-black p-8 rounded-2xl">
            <h1 className="text-5xl md:text-7xl font-bold mb-6 leading-tight">
              Create Worlds, <br />
              Forge Adventures
            </h1>
            <p className="text-xl mb-8 text-gray-300">
              Join Iron Pixel Studios in crafting the next generation of
              immersive gaming experiences.
            </p>
            <div className="flex gap-4">
              <button type="button" className="btn btn-primary">
                <a href="/login">Sign Up</a>
              </button>
            </div>
          </div>
        </div>
      </section>

      {/* Games Section */}
      <section className="py-20 bg-brand-dark">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-12 text-center">
            Featured Games
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <GameCard
              title="Mystic Valley"
              description="Explore a vibrant world full of mystery and adventure"
              imageUrl="/images/GameImage_01.png"
            />
            <GameCard
              title="Castle Siege"
              description="Epic medieval battles await in this strategic conquest"
              imageUrl="/images/GameImage_02.png"
            />
            <GameCard
              title="Merchant's Tale"
              description="Build your trading empire in a rich fantasy world"
              imageUrl="/images/GameImage_03.png"
            />
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-gradient-to-r from-brand-teal/20 to-brand-green/20">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-4xl font-bold mb-6">
            Ready to Begin Your Adventure?
          </h2>
          <p className="text-xl mb-8 text-gray-300">
            Join thousands of players in the Iron Pixel community
          </p>
          <button className="btn btn-primary" type="button">
            <a href="/login">Get Started</a>
          </button>
        </div>
      </section>

      <Footer />
    </div>
  );
}
