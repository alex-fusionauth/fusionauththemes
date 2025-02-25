import { Footer } from '@/components/footer';
import { HeroSection } from '@/components/hero-section';
import { NavigationMenu } from '@/components/navigation-menu';
import Image from 'next/image';

export default function HomePage() {
  return (
    <div className="relative flex min-h-screen flex-col">
      <div className="absolute inset-0 -z-10">
        <Image
          src="https://res.cloudinary.com/djox1exln/image/upload/v1740475248/ChangeBank_Background_yyfp1w.png"
          alt="Background pattern"
          fill
          priority
          className="object-cover object-center"
        />
      </div>
      <NavigationMenu />
      <HeroSection />
      <Footer />
    </div>
  );
}
