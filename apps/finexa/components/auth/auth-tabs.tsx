"use client";

interface AuthTabsProps {
  activeTab: "signin" | "register";
  onTabChange: (tab: "signin" | "register") => void;
}

export function AuthTabs({ activeTab, onTabChange }: AuthTabsProps) {
  return (
    <div className="flex overflow-hidden flex-wrap items-start p-1.5 w-full text-base rounded-lg bg-slate-900 max-md:max-w-full">
      <button
        onClick={() => onTabChange("signin")}
        className={`flex-1 shrink p-4 font-semibold rounded basis-0 min-w-60 ${
          activeTab === "signin" ? "bg-white text-sky-950" : "text-white"
        }`}
      >
        Sign In
      </button>
      <button
        onClick={() => onTabChange("register")}
        className={`flex-1 shrink p-4 font-semibold rounded basis-0 min-w-60 ${
          activeTab === "register" ? "bg-white text-sky-950" : "text-white"
        }`}
      >
        Register
      </button>
    </div>
  );
}
