import Image from 'next/image';
import Link from 'next/link';

const games = [
  {
    title: 'Mystic Valley',
    description: 'Explore a vibrant world full of mystery and adventure',
    image: '/GameImage_01.png',
  },
  {
    title: 'Castle Siege',
    description: 'Epic medieval battles await in this strategic conquest',
    image: '/GameImage_02.png',
  },
  {
    title: "Merchant's Tale",
    description: 'Build your trading empire in a rich fantasy world',
    image: '/GameImage_03.png',
  },
];

export function FeaturedGames() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      {games.map((game) => (
        <Link
          key={game.title}
          href={`/games/${game.title.toLowerCase().replace(' ', '-')}`}
          className="group relative overflow-hidden rounded-lg"
        >
          <div className="aspect-[16/9] relative">
            <Image
              src={game.image || '/GameImage_01.png'}
              alt={game.title}
              fill
              className="object-cover transition-transform group-hover:scale-105"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent">
              <div className="absolute bottom-0 p-6">
                <h3 className="text-xl font-bold text-white mb-2">
                  {game.title}
                </h3>
                <p className="text-gray-300 text-sm">{game.description}</p>
              </div>
            </div>
          </div>
        </Link>
      ))}
    </div>
  );
}
