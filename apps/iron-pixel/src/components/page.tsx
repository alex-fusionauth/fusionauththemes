import { Footer } from '@/components/footer';
import { GameCard } from '@/components/game-card';
import { Header } from '@/components/header';
// import { Button } from '@/components/ui/button';

export default function Page() {
  return (
    <div className="min-h-screen bg-brand-darker text-white">
      <Header />

      {/* Hero Section */}
      <section className="relative h-[80vh] overflow-hidden">
        <div className="absolute inset-0 bg-gradient-radial  opacity-40" />
        <img
          src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-oCJeHWGe0amS9idMTX53QLOSMIcqeV.png"
          alt="Game screenshot"
          className="absolute inset-0 w-full h-full object-cover object-center"
        />
        <div className="relative z-10 container mx-auto px-4 h-full flex items-center">
          <div className="max-w-2xl">
            <h1 className="text-5xl md:text-7xl font-bold mb-6 leading-tight">
              Create Worlds, <br />
              Forge Adventures
            </h1>
            <p className="text-xl mb-8 text-gray-300">
              Join Iron Pixel Studios in crafting the next generation of
              immersive gaming experiences.
            </p>
            <div className="flex gap-4">
              {/* <Button
                size="lg"
                className="bg-brand-teal hover:bg-brand-teal/90 text-brand-darker"
                asChild
              >
                <a href="/login">Play Now</a>
              </Button>
              <Button
                size="lg"
                variant="outline"
                className="border-brand-teal text-brand-teal hover:bg-brand-teal/10"
                asChild
              >
                <a href="/login">Sign Up</a>
              </Button> */}
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
              imageUrl="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-oCJeHWGe0amS9idMTX53QLOSMIcqeV.png"
            />
            <GameCard
              title="Castle Siege"
              description="Epic medieval battles await in this strategic conquest"
              imageUrl="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-oCJeHWGe0amS9idMTX53QLOSMIcqeV.png"
            />
            <GameCard
              title="Merchant's Tale"
              description="Build your trading empire in a rich fantasy world"
              imageUrl="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-oCJeHWGe0amS9idMTX53QLOSMIcqeV.png"
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
          <Button
            size="lg"
            className="bg-brand-teal hover:bg-brand-teal/90 text-brand-darker"
            asChild
          >
            <a href="/login">Get Started</a>
          </Button>
        </div>
      </section>

      <Footer />
    </div>
  );
}
