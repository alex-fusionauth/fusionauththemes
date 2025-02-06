import { Button } from "@/components/ui/button"
import { CuboidIcon as Cube } from "lucide-react"

export function Header() {
  return (
    <header className="py-4 px-4 bg-brand-darker/80 backdrop-blur-sm fixed top-0 w-full z-50">
      <div className="container mx-auto flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Cube className="h-8 w-8 text-brand-teal" />
          <span className="text-xl font-bold">IRON PIXEL STUDIOS</span>
        </div>
        <nav className="hidden md:flex items-center gap-8">
          <a href="#" className="text-gray-300 hover:text-white">
            Games
          </a>
          <a href="#" className="text-gray-300 hover:text-white">
            About
          </a>
          <a href="#" className="text-gray-300 hover:text-white">
            News
          </a>
          <a href="#" className="text-gray-300 hover:text-white">
            Support
          </a>
        </nav>
        <div className="flex items-center gap-4">
          <Button variant="ghost" className="text-gray-300 hover:text-white" asChild>
            <a href="/login">Sign In</a>
          </Button>
          <Button className="bg-brand-teal hover:bg-brand-teal/90 text-brand-darker" asChild>
            <a href="/login">Play Now</a>
          </Button>
        </div>
      </div>
    </header>
  )
}

