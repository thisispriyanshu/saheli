
export default function Footer() {

  return (
    < >
      <div className="mx-auto  bg-[#F7F4F1] overflow-hidden px-12 py-20 sm:py-24 ">
        <nav className="-mb-6 columns-2 sm:flex sm:justify-center sm:space-x-12" aria-label="Footer">
          <div className="pb-6">
            <a className="text-sm leading-6 text-gray-600 hover:text-gray-900" href="https://www.youtube.com/watch?v=al7dooPSCwM">About us</a>
          </div>
          <div className="pb-6">
            <a className="text-sm leading-6 text-gray-600 hover:text-gray-900" href="https://github.com/thisispriyanshu/saheli">Code</a>
          </div>
          <div className="pb-6">
            <a className="text-sm leading-6 text-gray-600 hover:text-gray-900" href="/product#faqs">FAQs</a>
          </div>
          <div className="pb-6">
            <button className="text-sm leading-6 text-gray-600 hover:text-gray-900" ><a href="https://www.linkedin.com/in/priyanshu-agrawal-5a00651b1/">Contact</a></button>
          </div>
          <div className="pb-6">
            <a className="text-sm leading-6 text-gray-600 hover:text-gray-900" href="/privacy">Privacy</a>
          </div>
        </nav>
        <div>
          <p className="mt-4 text-center text-xs leading-5 text-gray-500">Built with ❤️ by Saheli Team</p>
        </div>
      </div>
    </>
  )
}