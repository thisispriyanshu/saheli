import { ArrowLeft } from "lucide-react";
import { useState } from "react";
import Image from "next/image";

export default function Demo() {
  const [demoTaken, setDemoTaken] = useState<boolean | null>(null); // Using null to represent initial state

  const handleYesClick = () => {
    setDemoTaken(true);
  };

  const handleNoClick = () => {
    setDemoTaken(false);
  };

  const handleRevertClick = () => {
    setDemoTaken(null); // Reset to initial state
  };

  function handleDownload() {
    // Add your download logic here
    console.log("Download APK");
    
  }

  return (
    <div className="flex flex-col items-center justify-center px-6 gap-8 my-16" style={{ position: "relative", zIndex: 1 }}>
      <p className="md:text-2 xl text-lg font-bold">Have you taken the demo of the app?</p>
      {demoTaken === null && (
        <div className="flex gap-4">
          <button
            onClick={handleYesClick}
            className="px-6 py-3 rounded-lg font-bold hover:scale-105 bg-primary text-white transition-all hover:bg-primary-dark"
          >
            Yes
          </button>
          <button
            onClick={handleNoClick}
            className="px-6 py-3 rounded-lg font-bold hover:scale-105 transition-all bg-primary text-white  hover:bg-primary-dark"
          >
            No
          </button>
        </div>
      )}

      {demoTaken !== null && (
        <div className="flex gap-4">
          <button
            onClick={handleRevertClick}
            className="px-6 py-3 rounded-lg bg-primary text-white transition-colors hover:bg-primary-dark"
            title="Go back"
            style={{ width: "40px", height: "80px" }}
          >
            <ArrowLeft size={24} />
          </button>
          {!demoTaken ? (
            <>
              <button
                onClick={handleDownload}
                className="px-6 py-3 rounded-lg font-semibold bg-primary text-white transition-colors hover:bg-white hover:text-primary hover:border-primary border"
                title="Download APK" style={{ width: "120px", height: "80px" }}
              >
                Download APK
              </button>
              <Image width={120} height={120} src="/assets/qr-code.png" alt="QR Code" /> {/* Display QR code image */}
            </>
          ) : (
            <>
              <a
                href="https://forms.gle/8kh6sNz11FDNPCin6"
                target="_blank"
                rel="noopener noreferrer"
                title="Fill Feedback"
                style={{ width: "120px", height: "100px" }}
                className="px-6 py-3 rounded-lg font-semibold bg-primary text-white transition-colors hover:bg-white hover:text-primary hover:border-primary border"
              >
                Fill Feedback Form
              </a>
              <Image width={120} height={120} src="/assets/qrcode_feedback_form.png" alt="QR Code" /> {/* Display QR code image */}
            </>
          )}
        </div>
      )}
    </div>
  );
}
