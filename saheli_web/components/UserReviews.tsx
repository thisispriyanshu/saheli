import React, { useState } from "react";
import Modal from "./modal";

// UserReview component
const UserReview = () => {
  const [showModal, setShowModal] = useState(false);
  const [selectedVideo, setSelectedVideo] = useState("");

  // Handle opening modal and setting selected video
const handleVideoClick = (videoUrl: string) => {
    setSelectedVideo(videoUrl);
    setShowModal(true);
  };
  

  return (
    <div>
      <h2>User Reviews Videos</h2>
      {/* Render list of videos */}
      <div className="video-list">
        <div onClick={() => handleVideoClick("https://drive.google.com/file/d/1IOQ6L4sWEMqKYqFc5S4--1baCZiMz9KW/view?usp=sharing")}>Video 1</div>
        <div onClick={() => handleVideoClick("https://drive.google.com/file/d/1IOQ6L4sWEMqKYqFc5S4--1baCZiMz9KW/view?usp=sharing")}>Video 2</div>
        {/* Add more videos as needed */}
      </div>
      {/* Modal for playing videos */}
      <Modal showModal={showModal} setShowModal={setShowModal}>
        <iframe
          title="User Review Video"
          width="560"
          height="315"
          src={selectedVideo}
          frameBorder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowFullScreen
        ></iframe>
      </Modal>
    </div>
  );
};

export default UserReview;
