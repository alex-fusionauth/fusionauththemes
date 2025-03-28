import { docs } from '@/.source';
import Finexa from '@/lib/finexa';
import TacosTruck from '@/lib/tacostruck';
import { loader } from 'fumadocs-core/source';
import { icons } from 'lucide-react';
import { createElement } from 'react';
import ChangeBank from './changebank';
import IronPixel from './iron-pixel';

export const source = loader({
  baseUrl: '/docs',
  source: docs.toFumadocsSource(),
  icon(icon) {
    if (!icon) {
      // You may set a default icon
      return;
    }
    if (icon === 'iron-pixel') {
      return createElement(IronPixel);
    }
    if (icon === 'changebank') {
      return createElement(ChangeBank);
    }
    if (icon === 'tacostruck') {
      return createElement(TacosTruck);
    }
    if (icon === 'finexa') {
      return createElement(Finexa);
    }
    if (icon in icons) return createElement(icons[icon as keyof typeof icons]);
  },
});
