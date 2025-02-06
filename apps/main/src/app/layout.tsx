import { Slack } from 'lucide-react';
/* eslint-env node */
import { Footer, Layout, Navbar } from 'nextra-theme-docs';
import 'nextra-theme-docs/style.css';
//@ts-ignore
import { Banner, Head } from 'nextra/components';
//@ts-ignore
import { getPageMap } from 'nextra/page-map';
import './globals.css';

export const metadata = {
  metadataBase: new URL('https://fusionauththemes.io'),
  title: {
    template: '%s - FusionAuth Themes',
  },
  description:
    'FusionAuth Themes showing examples of high polish custom logins.',
  applicationName: 'FusionAuth Themes',
  generator: 'Next.js',
  appleWebApp: {
    title: 'FusionAuthThemes',
  },
  other: {
    'msapplication-TileImage': '/ms-icon-144x144.png',
    'msapplication-TileColor': '#fff',
  },
  twitter: {
    site: 'https://fusionauth.io',
  },
};

export default async function RootLayout({ children }) {
  const navbar = (
    <Navbar
      logo={
        <div>
          <b>FusionAuth</b> <span style={{ opacity: '60%' }}>Themes</span>
        </div>
      }
      // Next.js discord server
      chatLink="https://join.slack.com/t/fusionauth/shared_invite/zt-6ykfov9u-MTwA1A6ptv0Gr6KcFBVG4w"
      chatIcon={<Slack />}
    />
  );
  const pageMap = await getPageMap();
  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <Head />
      <body>
        <Layout
          navbar={navbar}
          footer={<Footer>{new Date().getFullYear()} © FusionAuth.</Footer>}
          editLink="Edit this page on GitHub"
          docsRepositoryBase="https://github.com/alex-fusionauth/fusionauththemes/blob/main/docs"
          sidebar={{ defaultMenuCollapseLevel: 1 }}
          pageMap={pageMap}
          darkMode={true}
        >
          {children}
        </Layout>
      </body>
    </html>
  );
}
