import { Card, CardContent } from '@/app/components/card';
import Image from 'next/image';
import Link from 'next/link';

const sites = [
  {
    id: 1,
    title: 'Iron Pixel',
    image: '/images/iron-pixel/login.png',
    link: process.env.NEXT_PUBLIC_IRON_PIXEL_URL || 'http://localhost:3001',
    thumbnails: [
      '/images/iron-pixel/GameImage_01.png?height=200&width=300',
      '/images/iron-pixel/GameImage_02.png?height=200&width=300',
      '/images/iron-pixel/GameImage_03.png?height=200&width=300',
    ],
  },
  {
    id: 2,
    title: 'Changebank',
    image: '/placeholder.svg?height=400&width=600',
    link: process.env.NEXT_PUBLIC_CHANGEBANK_URL || 'http://localhost:3002',
    thumbnails: [
      '/placeholder.svg?height=200&width=300',
      '/placeholder.svg?height=200&width=300',
      '/placeholder.svg?height=200&width=300',
    ],
  },
];

export default function HomePage() {
  return (
    <main className="flex flex-1 flex-col justify-center text-center">
      <div className="container mx-auto px-4 py-12">
        <h1 className="text-5xl font-bold text-white mb-4 text-center bg-clip-text text-transparent bg-gradient-to-r from-emerald-400 to-cyan-400">
          Featured Themes
        </h1>
        <p className="text-lg text-center text-gray-300 mb-12">
          Explore our collection of fully themed sites and logins.
        </p>
        <div className="grid gap-8 items-center justify-center">
          {sites.map((site) => (
            <Card
              key={site.id}
              className="overflow-hidden bg-black backdrop-blur-sm border-0 shadow-[0_0_15px_rgba(0,255,200,0.1)] md:max-w-xl lg:max-w-3xl"
            >
              <CardContent className="p-0">
                <Link
                  href={site.link}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <div className="relative group">
                    <Image
                      src={site.image || '/placeholder.svg'}
                      alt={site.title}
                      width={600}
                      height={400}
                      className="w-full object-cover "
                    />
                    <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                      <span className="text-white text-lg font-bold">
                        Launch Site
                      </span>
                    </div>
                  </div>
                </Link>
                <div className="p-4">
                  <h2 className="text-xl font-bold text-white mb-4">
                    {site.title}
                  </h2>
                  <div className="grid grid-cols-3 gap-2">
                    {site.thumbnails.map((thumbnail, index) => (
                      <Link
                        // biome-ignore lint/suspicious/noArrayIndexKey: <explanation>
                        key={index}
                        href={site.link}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        <Image
                          src={thumbnail || '/placeholder.svg'}
                          alt={`${site.title} thumbnail ${index + 1}`}
                          width={300}
                          height={200}
                          className="w-full aspect-video object-cover rounded-md hover:opacity-80 transition-opacity"
                        />
                      </Link>
                    ))}
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </main>
  );
}
