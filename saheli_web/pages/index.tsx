import SlackButton from "@/components/slack-button";
import Layout from "@/components/layout";
import { Play } from "lucide-react";
import { useVideoModal } from "@/components/video-modal";
import Balancer from "react-wrap-balancer";
import Features from "@/components/Features";
import Demo from "@/components/Demo";
import UserReview from "@/components/UserReviews";

// Define an array of feature data
const features = [
  {
    title: "Emergency Services Locator",
    description: "Enables users to locate nearby police stations, hospitals, and other emergency services with a single click, ensuring immediate access to help.",
    icon: <svg className="w-5 h-5 text-primary-600 lg:w-6 lg:h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z"></path></svg>
  },
  {
    title: "Helpline Directory",
    description: "Provides a comprehensive directory of helplines and NGOs, enabling users to access help and support services at any time.",
    icon: <svg className="w-5 h-5 text-primary-600 lg:w-6 lg:h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fillRule="evenodd" d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z" clipRule="evenodd"></path></svg>
  },
  {
    title: "Crowdsourced Safety Zones",
    description: " Empower users to report unsafe areas and identify verified safe zones, fostering community-driven safety initiatives.",
    icon: <svg className="w-5 h-5 text-primary-600 lg:w-6 lg:h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fillRule="evenodd" d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z" clipRule="evenodd"></path></svg>
  },
  {
    title: "Offline Accessibility",
    description: "Ensure core functionalities remain accessible even without internet connectivity, prioritizing usability in diverse environments.",
    icon: <svg className="w-5 h-5 text-primary-600 lg:w-6 lg:h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fillRule="evenodd" d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z" clipRule="evenodd"></path></svg>
  },

  {
    title: "Audio-Video Recording",
    description: "Activate automatic audio-video recording with SOS alerts, capturing real-time environment data for immediate assistance or legal evidence.",
    icon: <svg className="w-5 h-5 text-primary-600 lg:w-6 lg:h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fillRule="evenodd" d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z" clipRule="evenodd"></path></svg>
  },
  {
    title: "Report Suspicious Location",
    description: "Help improve community safety by reporting suspicious locations within the Saheli app. Users can enter details about issues observed and pinpoint the location on the map, contributing to the identification of potentially unsafe areas and enhancing safety for others.",
    icon: <svg className="w-5 h-5 text-primary-600 lg:w-6 lg:h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fillRule="evenodd" d="M7 9.414V3h6v6.414l2.293-2.293a1 1 0 011.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L7 9.414zm6 4.172l-1.293 1.293a1 1 0 01-1.414-1.414L12.586 13H5v6a1 1 0 001 1h8a1 1 0 001-1v-6h.586l-1.293 1.293a1 1 0 01-1.414-1.414l3-3a1 1 0 011.414 0l3 3a1 1 0 01.003 1.417z" clipRule="evenodd"></path></svg>
  }
  
];


// have u taken a demo of our app --> yes no
//if yes -> google form link else download the apk file  


//features 


//footer (get refrence from tell.tv)

//try the features from canopi website (Those cards)





export default function Home() {
  const { setShowVideoModal, VideoModal } = useVideoModal();
  //demo taken or not if yes --> google form link else download the apk file 



  return (
    <Layout>
      <div className="bg-gradient-radial from-[#FD6978] via-[#F7F4F1] to-[#F7F4F1] w-[80vw] h-[120vh]  absolute top-0 ">
      </div>
      {/* hero section */}
      <VideoModal />
      <div className="text-center z-10  px-3 max-w-sm sm:max-w-3xl space-y-4">
        <h1 className="my-8 bg-gradient-to-br from-[#d84c5a] via-[#ff5a68] to-primary bg-clip-text text-center text-4xl font-bold tracking-tight text-transparent md:text-7xl">
          <Balancer ratio={0.6}>Your Ultimate Safety Companion</Balancer>
        </h1>
        <p className="md:text-xl text-lg text-neutral-700">
          Saheli, meaning &apos;female best friend&apos; in Hindi, is an innovative mobile application designed to ensure the safety and security of women, empowering them to navigate through various situations confidently.
        </p>
      </div>

      <div className="relative mt-6">
        <button
          onClick={() => setShowVideoModal(true)}
          className="group flex justify-center items-center absolute z-10 w-[350px] h-[350px] sm:w-[450px] sm:h-[450px] rounded-full hover:backdrop-blur-sm hover:bg-black/20 transition-all overflow-hidden"
        >
          <div className="flex justify-center items-center w-14 h-14 rounded-full bg-white shadow-lg">
            <Play size={20} fill="#27272A" aria-hidden="true" />
          </div>
          <p className="font-mono text-white absolute -bottom-10 group-hover:bottom-5 transition-all ease-in-out duration-300">
            <span className="sr-only">Play Video. Length of Video is</span> 2:01
          </p>
        </button>
        <video
          autoPlay
          loop
          muted
          src="/assets/demo.mp4"
          className="w-[320px] h-[320px] sm:w-[450px] sm:h-[450px] rounded-full object-cover"
          tabIndex={-1}
          aria-label="Looping video preview"
        />
      </div>
      {/* hero section */}

      {/* download buttons */}
      {/* <div className="flex place-items-center gap-4 px-4 ">
        <SlackButton
          text="Download from Play Store"
          icon="/google-play.svg"
          url={`https://slack.com/oauth/v2/authorize?scope=chat:write,chat:write.public,links:read,links:write,commands,team:read&client_id=${process.env.NEXT_PUBLIC_SLACK_CLIENT_ID}`}
        />
        <SlackButton
          text="Download from Google Drive"
          icon="/google-drive.svg"
          url={`https://slack.com/oauth/v2/authorize?scope=chat:write,chat:write.public,links:read,links:write,commands,team:read&client_id=${process.env.NEXT_PUBLIC_SLACK_CLIENT_ID}`}
        />
      </div> */}
      {/* download buttons end */}
      <Demo />
      <Features />
      {/* features */}
      <div className="flex place-items-center px-6 gap-4 my-12">
        <section className="">
          <div className="py-8 px-4 mx-auto max-w-screen-xl sm:py-16 lg:px-6">
            <div className="max-w-screen-md mb-8 lg:mb-16">
              <h2 className="mb-4 text-4xl tracking-tight font-extrabold text-neutral-700 ">Other Features</h2>
            </div>
            <div className="space-y-8 md:grid md:grid-cols-2 lg:grid-cols-3 md:gap-12 md:space-y-0">
              {features.map((feature, index) => (
                <div key={index}>
                  <div className="flex justify-center items-center mb-4 w-10 h-10 rounded-full bg-primary text-white lg:h-12 lg:w-12">
                    {feature.icon}
                  </div>
                  <h3 className="mb-2 text-neutral-800 text-xl font-bold ">{feature.title}</h3>
                  <p className="text-gray-600 text-lg">{feature.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>
      </div>
      {/* <UserReview/> */}
      {/* features end */}
    </Layout>
  );
}
