import { StarsBackground } from '@/components/stars-background';
import { Card, CardContent } from '@/components/ui/card';
import Image from 'next/image';
import Link from 'next/link';

const games = [
  {
    id: 1,
    title: 'Forest Adventure',
    image: '/images/iron-pixel/login.png',
    link: process.env.NEXT_PUBLIC_IRON_PIXEL_URL!,
    thumbnails: [
      '/images/iron-pixel/GameImage_01.png?height=200&width=300',
      '/images/iron-pixel/GameImage_02.png?height=200&width=300',
      '/images/iron-pixel/GameImage_03.png?height=200&width=300',
    ],
  },
  {
    id: 2,
    title: 'Medieval Quest',
    image: '/placeholder.svg?height=400&width=600',
    link: 'https://example.com/game2',
    thumbnails: [
      '/placeholder.svg?height=200&width=300',
      '/placeholder.svg?height=200&width=300',
      '/placeholder.svg?height=200&width=300',
    ],
  },
  {
    id: 3,
    title: 'Space Explorer',
    image: '/placeholder.svg?height=400&width=600',
    link: 'https://example.com/game3',
    thumbnails: [
      '/placeholder.svg?height=200&width=300',
      '/placeholder.svg?height=200&width=300',
      '/placeholder.svg?height=200&width=300',
    ],
  },
];

export default function HomePage() {
  return (
    <div className="relative overflow-hidden">
      <StarsBackground />
      <div className="relative">
        <div
          className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTQ0MCIgaGVpZ2h0PSI1MDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGcgc3Ryb2tlPSIjMjIxMTMzIiBzdHJva2Utd2lkdGg9IjIiIGZpbGw9Im5vbmUiPjxwYXRoIGQ9Ik0wIDUwMGwxNDQwLTUwME0wIDUwMGwxNDQwLTQwME0wIDUwMGwxNDQwLTMwME0wIDUwMGwxNDQwLTIwME0wIDUwMGwxNDQwLTEwME0wIDUwMGwxNDQwIDBNMCA1MDBsMTQ0MCAxMDBNMCA1MDBsMTQ0MCAyMDBNMCA1MDBsMTQ0MCAzMDBNMCA1MDBsMTQ0MCA0MDBNMCA1MDBsMTQ0MCA1MDAiLz48L2c+PC9zdmc+')] opacity-20"
          style={{
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            transform: 'translateY(50%)',
            animation: 'wave 20s linear infinite',
          }}
        />
        <div className="container mx-auto px-4 py-12">
          <h1 className="text-5xl font-bold text-white mb-4 text-center bg-clip-text text-transparent bg-gradient-to-r from-emerald-400 to-cyan-400">
            Featured Themes
          </h1>
          <p className="text-lg text-center text-gray-300 mb-12">
            Explore our collection of fully themed sites and logins.
          </p>
          <div className="grid gap-8 items-center justify-center">
            {games.map((game) => (
              <Card
                key={game.id}
                className="overflow-hidden bg-black backdrop-blur-sm border-0 shadow-[0_0_15px_rgba(0,255,200,0.1)] md:max-w-xl lg:max-w-3xl"
              >
                <CardContent className="p-0">
                  <Link
                    href={game.link}
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    <div className="relative group">
                      <Image
                        src={game.image || '/placeholder.svg'}
                        alt={game.title}
                        width={600}
                        height={400}
                        className="w-full object-cover "
                      />
                      <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                        <span className="text-emerald-400 text-lg font-bold">
                          Launch Game
                        </span>
                      </div>
                    </div>
                  </Link>
                  <div className="p-4">
                    <h2 className="text-xl font-bold text-white mb-4">
                      {game.title}
                    </h2>
                    <div className="grid grid-cols-3 gap-2">
                      {game.thumbnails.map((thumbnail, index) => (
                        <Link
                          // biome-ignore lint/suspicious/noArrayIndexKey: <explanation>
                          key={index}
                          href={game.link}
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          <Image
                            src={thumbnail || '/placeholder.svg'}
                            alt={`${game.title} thumbnail ${index + 1}`}
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
      </div>
    </div>
  );
}
