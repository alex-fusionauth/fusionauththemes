import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import type { SVGProps } from 'react';

export function TacosTruckLogo(props: SVGProps<SVGSVGElement>) {
  return (
    <Avatar>
      <AvatarImage
        src="https://res.cloudinary.com/djox1exln/image/upload/v1740770397/Group_27_xmigzi.png"
        alt="Taco Truck Logo"
      />
      <AvatarFallback>TT</AvatarFallback>
    </Avatar>
  );
}
