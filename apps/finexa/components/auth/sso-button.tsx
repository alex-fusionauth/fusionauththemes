"use client";

import { signIn } from "@/auth";
import Image from "next/image";

interface SSOButtonProps {
  provider: "google" | "microsoft";
  icon: string;
  label: string;
}

export function SSOButton({ provider, icon, label }: SSOButtonProps) {
  const handleClick = async () => {
    await signIn(provider);
  };

  return (
    <button
      onClick={handleClick}
      className="flex gap-0.5 justify-center items-center py-1 pr-5 pl-2 bg-blue-800 rounded-[100px] max-md:pr-5"
    >
      <Image
        src={icon}
        alt={`${provider} icon`}
        width={32}
        height={32}
        className="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
      />
      <span className="self-stretch my-auto">{label}</span>
    </button>
  );
}
