import Image from "next/image";
import React from "react";
import SafeRoute from "../public/assets/safe-route-portrait.png";
import SakhaChatbot from "../public/assets/sakha-chatbot-portrait.png";
import Sos from "../public/assets/sos-portrait.png";
import FakeCaller from "../public/assets/fake-caller-portrait.png";

type Props = {};

const Features = (props: Props) => {
  return (
    <div className="w-full overflow-x-auto">
      <section className="mx-auto max-w-5xl space-y-20 px-4 py-20">
        <h2 className="text-4xl font-bold tracking-tight md:mx-auto md:max-w-3xl md:text-center md:text-5xl">
          Main Features
        </h2>
        <div className="grid grid-cols-1 items-center gap-8 md:grid-cols-2 md:gap-24">
          <Image
            width={1000}
            height={1000}
            src={SafeRoute.src}
            alt="Safe Route"
            className="h-120 w-full bg-slate-50 object-cover"
          />
          <div>
            <h3 className="mb-2 text-xl font-semibold">
              Safe Route - Safest and Shortest route
            </h3>
            <p className="text-slate-700">
              Navigate safely to your destination with the Saheli app&apos;s Safe
              Route feature, which leverages advanced technology to guide you
              along the most secure and efficient path.
            </p>
            <ul className="my-6 space-y-3 text-slate-700">
              <li>
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  viewBox="0 0 24 24"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  xmlns="http://www.w3.org/2000/svg"
                  className="mr-2 inline-block size-4 text-emerald-500"
                >
                  <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
                </svg>
                <span>Utilizes Google Maps API for accurate navigation.</span>
              </li>
              <li>
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  viewBox="0 0 24 24"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  xmlns="http://www.w3.org/2000/svg"
                  className="mr-2 inline-block size-4 text-emerald-500"
                >
                  <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
                </svg>
                <span>Incorporates Machine Learning algorithm to identify the safest routes.</span>
              </li>
              <li>
                <svg
                  width="24"
                  height="24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  viewBox="0 0 24 24"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  xmlns="http://www.w3.org/2000/svg"
                  className="mr-2 inline-block size-4 text-emerald-500"
                >
                  <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
                </svg>
                <span>Enhances navigation security for peace of mind during travel.</span>
              </li>
            </ul>
          </div>
        </div>
        <div className="grid grid-cols-1 items-center gap-8 md:grid-cols-2 md:gap-24">
  <Image
    width={1000}
    height={1000}
    src={SakhaChatbot.src}
    alt="Sakha Chatbot"
    className="h-120 w-full bg-slate-50 object-cover md:order-last"
  />
  <div>
    <h3 className="mb-2 text-xl font-semibold">Sakha Chatbot - Gemini AI integrated chatbot</h3>
    <p className="text-slate-700">
      Access instant guidance and assistance with the Sakha Chatbot, an integrated AI feature trained specifically on women&apos;s safety, available within the Saheli app.
    </p>
    <ul className="my-6 space-y-3 text-slate-700">
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Utilizes Gemini AI for intelligent interactions.</span>
      </li>
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Provides personalized safety tips and support during emergencies.</span>
      </li>
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Enhances user confidence and empowerment through real-time assistance.</span>
      </li>
    </ul>
  </div>
      </div>
      <div className="grid grid-cols-1 items-center gap-8 md:grid-cols-2 md:gap-24">
  <Image
    width={1000}
    height={1000}
    src={Sos.src}
    alt="SOS Emergency"
    className="h-120 w-full bg-slate-50 object-cover"
  />
  <div>
    <h3 className="mb-2 text-xl font-semibold">SOS Emergency</h3>
    <p className="text-slate-700">
      Ensure immediate assistance in times of distress with the SOS Emergency feature of the Saheli app, allowing users to swiftly send their location to pre-set trusted contacts.
    </p>
    <ul className="my-6 space-y-3 text-slate-700">
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Enables quick transmission of location to trusted contacts in emergencies.</span>
      </li>
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Prioritizes user safety by facilitating immediate assistance.</span>
      </li>
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Offers peace of mind and security for women navigating various situations.</span>
      </li>
    </ul>
  </div>
</div>

<div className="grid grid-cols-1 items-center gap-8 md:grid-cols-2 md:gap-24">
  <Image
    width={1000}
    height={1000}
    src={FakeCaller.src}
    alt="Fake Caller"
    className="h-120 w-full bg-slate-50 object-cover md:order-last"
  />
  <div>
    <h3 className="mb-2 text-xl font-semibold">Fake Caller</h3>
    <p className="text-slate-700">
      Safely exit potentially unsafe situations with the Fake Caller feature, allowing users to trigger a fake incoming call discreetly, providing an effective escape strategy.
    </p>
    <ul className="my-6 space-y-3 text-slate-700">
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Activated by shaking the phone or manually triggering.</span>
      </li>
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Offers scheduled fake calls for seamless exit planning.</span>
      </li>
      <li>
        <svg
          width="24"
          height="24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
          strokeLinecap="round"
          strokeLinejoin="round"
          xmlns="http://www.w3.org/2000/svg"
          className="mr-2 inline-block size-4 text-emerald-500"
        >
          <path d="m6 13.626 1.606 1.722c.886.95 1.329 1.424 1.825 1.574.436.131.9.096 1.315-.1.473-.224.852-.761 1.612-1.836L18 7"></path>
        </svg>
        <span>Enhances personal safety by providing a discreet way to leave uncomfortable situations.</span>
      </li>
    </ul>
  </div>
</div>

      </section>
    </div>
  );
};

export default Features;
