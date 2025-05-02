import Link from 'next/link';

export default function Privacy() {
  return (
    <section className="relative mt-80 text-primary flex flex-col items-center justify-center gap-4 p-4 text-center">
      This is an example application, please see{' '}
      <Link
        className="underline"
        target="_blank"
        href="https://fusionauth.io/privacy-policy"
      >
        FusionAuth's Privacy Policy
      </Link>{' '}
      for more information.
    </section>
  );
}
