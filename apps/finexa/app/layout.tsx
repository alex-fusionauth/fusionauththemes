import type React from 'react';
import '@/app/globals.css';
import { Footer } from '@/components/footer';
import { HeroSection } from '@/components/hero-section';
import { NavigationMenu } from '@/components/navigation-menu';
import { cn } from '@/lib/utils';
import { Inter } from 'next/font/google';
import Image from 'next/image';

const inter = Inter({ subsets: ['latin'] });

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={cn(inter.className, 'min-h-screen bg-background')}>
        <div className="relative flex min-h-screen flex-col">
          <NavigationMenu />
          {children}
          <Footer />
        </div>
      </body>
    </html>
  );
}
