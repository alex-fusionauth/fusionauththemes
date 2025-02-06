import Link from "next/link"

export function Footer() {
  return (
    <footer className="bg-[#0a0b0f] py-12 text-gray-400">
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <h3 className="font-bold text-white mb-4">IRON PIXEL STUDIOS</h3>
            <p className="text-sm">Creating immersive gaming experiences that push the boundaries of imagination.</p>
          </div>

          <div>
            <h4 className="font-bold text-white mb-4">Games</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/games" className="hover:text-white">
                  All Games
                </Link>
              </li>
              <li>
                <Link href="/new-releases" className="hover:text-white">
                  New Releases
                </Link>
              </li>
              <li>
                <Link href="/coming-soon" className="hover:text-white">
                  Coming Soon
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="font-bold text-white mb-4">Support</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/help" className="hover:text-white">
                  Help Center
                </Link>
              </li>
              <li>
                <Link href="/community" className="hover:text-white">
                  Community
                </Link>
              </li>
              <li>
                <Link href="/contact" className="hover:text-white">
                  Contact Us
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="font-bold text-white mb-4">Legal</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/privacy" className="hover:text-white">
                  Privacy Policy
                </Link>
              </li>
              <li>
                <Link href="/terms" className="hover:text-white">
                  Terms of Service
                </Link>
              </li>
              <li>
                <Link href="/cookies" className="hover:text-white">
                  Cookie Policy
                </Link>
              </li>
            </ul>
          </div>
        </div>

        <div className="border-t border-gray-800 mt-12 pt-8 text-sm text-center">
          <p>&copy; 2025 Iron Pixel Studios. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}

