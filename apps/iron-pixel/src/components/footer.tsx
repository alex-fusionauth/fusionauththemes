import { CuboidIcon as Cube } from "lucide-react"

export function Footer() {
  return (
    <footer className="bg-brand-darker py-12">
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <div className="flex items-center gap-2 mb-4">
              <Cube className="h-6 w-6 text-brand-teal" />
              <span className="font-bold">IRON PIXEL STUDIOS</span>
            </div>
            <p className="text-gray-400">
              Creating immersive gaming experiences that push the boundaries of imagination.
            </p>
          </div>
          <div>
            <h3 className="font-bold mb-4">Games</h3>
            <ul className="space-y-2">
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  All Games
                </a>
              </li>
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  New Releases
                </a>
              </li>
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Coming Soon
                </a>
              </li>
            </ul>
          </div>
          <div>
            <h3 className="font-bold mb-4">Support</h3>
            <ul className="space-y-2">
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Help Center
                </a>
              </li>
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Community
                </a>
              </li>
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Contact Us
                </a>
              </li>
            </ul>
          </div>
          <div>
            <h3 className="font-bold mb-4">Legal</h3>
            <ul className="space-y-2">
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Privacy Policy
                </a>
              </li>
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Terms of Service
                </a>
              </li>
              <li>
                <a href="#" className="text-gray-400 hover:text-white">
                  Cookie Policy
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div className="border-t border-gray-800 mt-12 pt-8 text-center text-gray-400">
          <p>&copy; {new Date().getFullYear()} Iron Pixel Studios. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}

