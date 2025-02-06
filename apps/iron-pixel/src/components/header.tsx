import Icon from '@/components/ui/icon';
import { CuboidIcon as Cube } from 'lucide-react';

export function Header() {
  return (
    <header className="py-4 px-4 bg-black backdrop-blur-sm fixed top-0 w-full z-50">
      <div className="container mx-auto flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Icon />
          <span className="text-xl font-bold">IRON PIXEL STUDIOS</span>
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
          <button className="btn" type="button">
            <a href="/login">Sign In</a>
          </button>
          <button
            className="btn btn-ghost bg-brand-teal hover:bg-brand-teal/90 text-brand-darker"
            type="button"
          >
            <a href="/login">Play Now</a>
          </button>
        </div>
      </div>
    </header>
  );
}
