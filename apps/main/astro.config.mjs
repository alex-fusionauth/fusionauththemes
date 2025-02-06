import starlight from '@astrojs/starlight';
// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: 'FusionAuth Themes',
      social: {
        github: 'https://github.com/alex-fusionauth/fusionauththemes',
      },
      sidebar: [
        {
          label: 'Themes',
          items: [
            // Each item here is one entry in the navigation menu.
            { label: 'Iron Pixel Studios', slug: 'iron-pixel/walkthrough' },
          ],
        },
      ],
    }),
  ],
});
