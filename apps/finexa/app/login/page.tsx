import Image from "next/image";
import { LoginForm } from "@/components/auth/login-form";

export default function LoginPage() {
  return (
    <div className="flex overflow-hidden flex-wrap bg-sky-950 min-h-screen">
      <div className="flex overflow-hidden flex-col flex-1 shrink px-24 py-20 basis-0 bg-sky-950 min-w-60 max-md:px-5 max-md:max-w-full">
        <div className="flex flex-col justify-center items-center self-center max-w-full text-4xl leading-none text-center text-white w-[203px]">
          <Image
            src="https://cdn.builder.io/api/v1/image/assets/cfdc3922ae324962acbb708d9e5bed22/a0e692705e2868511f73ae66cf384ccce4eebe3bc1aecc2614526c29911a213d?placeholderIfAbsent=true"
            alt="Finexa Logo"
            width={71}
            height={71}
            className="object-contain aspect-[1.01] w-[71px]"
          />
          <div className="mt-2">finexa pro</div>
        </div>
        <LoginForm />
      </div>
      <Image
        src="https://cdn.builder.io/api/v1/image/assets/cfdc3922ae324962acbb708d9e5bed22/0e7238da-c5e8-49cb-b6e3-6c9928c8e7ac?placeholderIfAbsent=true"
        alt="Login illustration"
        width={800}
        height={1024}
        className="object-contain flex-1 shrink py-2.5 w-full aspect-[0.78] basis-48 bg-sky-950 min-w-60 max-md:max-w-full"
      />
    </div>
  );
}
