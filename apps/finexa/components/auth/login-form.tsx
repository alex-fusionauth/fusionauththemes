"use client";

import { useState } from "react";
import { AuthTabs } from "./auth-tabs";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { SSOButton } from "./sso-button";
import Image from "next/image";
import { signIn } from "@/auth";

export function LoginForm() {
  const [activeTab, setActiveTab] = useState<"signin" | "register">("signin");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await signIn("fusionauth", { email, password });
  };

  return (
    <div className="mt-16 w-full rounded max-md:mt-10 max-md:max-w-full">
      <AuthTabs activeTab={activeTab} onTabChange={setActiveTab} />
      <div className="overflow-hidden px-6 pt-5 pb-6 mt-4 w-full text-white rounded max-md:px-5 max-md:max-w-full">
        <form
          onSubmit={handleSubmit}
          className="flex flex-col w-full max-md:max-w-full"
        >
          <div className="w-full max-md:max-w-full">
            <div className="flex flex-col justify-center w-full rounded max-md:max-w-full">
              <Label className="text-sm font-medium tracking-normal leading-loose">
                Email
              </Label>
              <Input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Enter email"
                className="flex-1 shrink gap-2 self-stretch px-4 pt-3 pb-3.5 mt-1 w-full text-base tracking-normal rounded border border-solid basis-0 border-white border-opacity-50 bg-transparent"
              />
            </div>
            <div className="flex flex-col justify-center mt-5 w-full rounded max-md:max-w-full">
              <Label className="text-sm font-medium tracking-normal leading-loose">
                Password
              </Label>
              <Input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Enter password"
                className="flex-1 shrink gap-2 self-stretch px-4 pt-3 pb-3.5 mt-1 w-full text-base tracking-normal rounded border border-solid basis-0 border-white border-opacity-50 bg-transparent"
              />
            </div>
          </div>
          <button
            type="button"
            className="self-start mt-4 text-sm font-semibold leading-loose text-center underline"
          >
            Forgot your password?
          </button>
          <Button
            type="submit"
            className="gap-2.5 self-stretch px-5 py-4 mt-8 w-full text-base font-semibold leading-loose text-center text-white whitespace-nowrap rounded bg-blue-800 bg-opacity-50"
          >
            Continue
          </Button>
          <Image
            src="https://cdn.builder.io/api/v1/image/assets/cfdc3922ae324962acbb708d9e5bed22/78d8226bb5f75f1c84d633e62fd925f2db5e725e93f085f2afce9477aa1a79b8?placeholderIfAbsent=true"
            alt="Divider"
            width={500}
            height={1}
            className="object-contain mt-8 w-full aspect-[500]"
          />
          <div className="flex gap-5 justify-center items-start mt-8 w-full text-sm font-semibold leading-loose text-center max-md:max-w-full">
            <SSOButton
              provider="google"
              icon="https://cdn.builder.io/api/v1/image/assets/cfdc3922ae324962acbb708d9e5bed22/76878674357cc1b2c47c2e0884d5c20be8d50acbae1b98830f336e98b42f1584?placeholderIfAbsent=true"
              label="Sign in with Google"
            />
            <SSOButton
              provider="microsoft"
              icon="https://cdn.builder.io/api/v1/image/assets/cfdc3922ae324962acbb708d9e5bed22/b04c54cad8119b6350ef1b4f0659faa707281d2989aa08e0de4a32b30edff3cb?placeholderIfAbsent=true"
              label="Sign in with Microsoft"
            />
          </div>
        </form>
      </div>
    </div>
  );
}
