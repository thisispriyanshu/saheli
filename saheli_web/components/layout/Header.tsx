import Image from 'next/image'
import Link from 'next/link'
import React from 'react'

type Props = {}

const Header = (props: Props) => {
  return (
    <div className="fixed top-0  mt-4 px-12  w-full text-black z-10 transition-all">
      <div className="   flex  items-center justify-between ">
        <Link href="/" className="flex md:bg-transparent backdrop-blur items-center justify-center space-x-3">
          <Image
            src="/logo.svg"
            alt="Precedent logo"
            width="48"
            height="48"
          />
          <p className="text-primary text-2xl font-bold tracking-tight text-transparent">
            Saheli
          </p>
        </Link>
        {/* <a
            href="https://github.com/vercel-labs/slacker"
            target="_blank"
            rel="noopener noreferrer"
            // here we are using the `isolate` property to create a new stacking context: https://github.com/tailwindlabs/tailwindcss/discussions/5675#discussioncomment-1987063
            className="relative isolate overflow-hidden rounded-full w-32 px-10 py-4"
          >
            <span className="absolute inset-px z-10 grid place-items-center rounded-full bg-black bg-gradient-to-t from-neutral-800 text-neutral-400 text-sm">
              View the code
            </span>
            <span
              aria-hidden
              className="absolute inset-0 z-0 scale-x-[2.0] blur before:absolute before:inset-0 before:top-1/2 before:aspect-square before:animate-disco before:bg-gradient-conic before:from-purple-200 before:via-gray-900 before:to-[#444]"
            />
          </a> */}
      </div>
    </div>)
}

export default Header