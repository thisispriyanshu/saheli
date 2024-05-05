import Image from "next/image";
import Link from "next/link";
import { ReactNode } from "react";
import Meta from "./meta";
import Footer from "./Footer";
import Header from "./Header";

export default function Layout({
  meta,
  children,
}: {
  meta?: {
    title?: string;
    description?: string;
    image?: string;
  };
  children: ReactNode;
}) {
  return (
    <>
      <Meta {...meta} />
      <Header />
      <main className=" min-h-screen flex flex-col bg-[#F7F4F1] items-center justify-start py-20 ">
        {children}
      </main>
      <Footer />
    </>
  );
}
