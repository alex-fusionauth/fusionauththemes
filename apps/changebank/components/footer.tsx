import Link from 'next/link';

export function Footer() {
  return (
    <footer className="">
      <div className="container mx-auto px-4">
        <div className="border-t py-8 text-sm text-center">
          <p>
            &copy; {new Date().getFullYear()} Change Bank. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
