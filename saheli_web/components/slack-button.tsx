import Image from "next/image";

export default function SlackButton({
  text,
  icon,
  url
}: {
  text: string;
  url: string;
  icon?: string;
}) {
  return (
    <a
      href={url}
      style={{
        fontFamily: "Lato, sans-serif",
        fontSize: "16px",
        fontWeight: "600",
      }}
      className="group flex items-center text-center justify-center rounded-md w-fit px-3 py-2 gap-2 md:text-base text-xs border border-gray-300 hover:border-black bg-white transition-all"
    >
        <Image
          src={icon || "/logo.svg"}
          width={40}
          height={40}
          alt="Slack logo animated"
          priority
        />


      {text}
    </a>
  );
}
