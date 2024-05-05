# Raspberry Pi Video and Audio Streaming with SOS Alert

This project demonstrates how to set up a Raspberry Pi for real-time video and audio streaming, along with an SOS alert functionality, using Bluetooth and Wi-Fi connections.

## Features

- Real-time video streaming from Raspberry Pi camera module.
- Audio streaming and playback on the Raspberry Pi.
- SOS alert functionality triggered by a physical button.

## Requirements

- Raspberry Pi (tested on Raspberry Pi 3 Model B+)
- Raspberry Pi camera module
- Bluetooth and Wi-Fi adapters
- Python 3
- OpenCV for video processing
- PyBluez for Bluetooth communication
- Aplay for audio playback

## Installation

1. Clone the repository to your Raspberry Pi:

   ```bash
   git clone https://github.com/thisispriyanshu/saheli.git
   cd smart-glasses-hardware
   ```

3. Install the required dependencies:

   ```bash
   sudo apt-get install python3-opencv
   sudo apt-get install python3-pybluez
   ```

4. Connect the Raspberry Pi camera module.

5. Connect Bluetooth and Wi-Fi adapters.

6. Run the main Python script:

   ```bash
   python3 main.py
   ```

## Usage

1. Run the script on the Raspberry Pi.

2. Connect to the Raspberry Pi via Bluetooth or Wi-Fi from your mobile app.

3. View real-time video streaming from the Raspberry Pi camera.

4. Send audio data to the Raspberry Pi for playback.

5. Press the SOS button to trigger an SOS alert.


## License

This project is licensed under the [MIT License](LICENSE).
