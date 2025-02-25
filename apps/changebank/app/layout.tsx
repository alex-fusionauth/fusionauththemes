import type React from 'react';
import '@/app/globals.css';
import { cn } from '@/lib/utils';
import { Inter } from 'next/font/google';

const inter = Inter({ subsets: ['latin'] });

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={cn(inter.className, 'min-h-screen bg-background')}>
        {children}
      </body>
    </html>
  );
}
