import Icon from '@/components/ui/icon';
import { CuboidIcon as Cube } from 'lucide-react';

export function Header() {
  return (
    <header className="py-4 px-4 backdrop-blur-xs fixed top-0 w-full z-50">
      <div className="container mx-auto flex items-center justify-between gap-0 md:gap-12">
        <div className="flex items-center gap-2">
          <Icon />
        </div>
        <nav className="hidden md:flex items-center gap-8">
          {/* biome-ignore lint/a11y/useValidAnchor: <explanation> */}
          <a href="#" className="text-gray-300 hover:text-white">
            Games
          </a>
          {/* biome-ignore lint/a11y/useValidAnchor: <explanation> */}
          <a href="#" className="text-gray-300 hover:text-white">
            About
          </a>
          {/* biome-ignore lint/a11y/useValidAnchor: <explanation> */}
          <a href="#" className="text-gray-300 hover:text-white">
            News
          </a>
          {/* biome-ignore lint/a11y/useValidAnchor: <explanation> */}
          <a href="#" className="text-gray-300 hover:text-white">
            Support
          </a>
        </nav>
        <div className="flex items-center gap-4">
          <button className="btn btn-primary" type="button">
            <a href="/login">Sign In</a>
          </button>
          <button className="btn btn-ghost hidden md:block" type="button">
            <a href="/login">Play Now</a>
          </button>
        </div>
      </div>
    </header>
  );
}
