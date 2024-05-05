# Saheli: Real-time Violence Detection System

Saheli is an advanced system designed to detect real-time violence occurrences in its surroundings. It employs cutting-edge technologies in machine learning and computer vision to analyze live video feeds and identify potential violent activities. This README provides an overview of the system, its components, and how to use it.

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [System Architecture](#system-architecture)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [License](#license)

## Introduction

Violence detection is crucial for ensuring the safety and security of individuals in various environments. Saheli offers a solution to monitor live video streams and detect violent behavior in real-time. By leveraging state-of-the-art machine learning models, Saheli provides accurate and efficient violence detection capabilities.

## Features

- Real-time violence detection in live video streams.
- Integration with existing surveillance systems.
- Customizable threshold settings for sensitivity adjustment.
- Detailed analytics and reporting on detected incidents.
- Scalable architecture to handle large volumes of video data.

## System Architecture

<!-- ![System Architecture](architecture_diagram.png) -->

Saheli's architecture consists of the following components:

- **Client**: The client application captures live video streams and sends them to the server for analysis.
- **Server**: The server receives video streams from multiple clients, processes them using machine learning algorithms, and returns the analysis results.
- **Machine Learning Models**: Two models are provided for violence detection:
  - **videoFightModel**: Utilizes VGG19-based architecture with LSTM layers for video analysis.
  - **videoFightModel2**: Implements a different VGG19-based architecture with LSTM layers and additional dense layers.
- **Prediction Function**: The `pred_fight` function is used to make predictions based on the input video and model.
- **Web API**: Exposes endpoints for communication between the client and server components.

## Installation

To install Saheli, follow these steps:

1. Clone the Saheli repository from GitHub:

```bash
git clone https://github.com/your_username/saheli.git
```

2. Navigate to the project directory:

```bash
cd saheli
```

3. Install the required dependencies:

```bash
pip install -r requirements.txt
```

4. Set up the configuration files according to your environment settings.

## Usage

To use Saheli, follow these steps:

1. Start the server component by running:

```bash
python web-flight22.py
```

2. Use the provided web API endpoints to send video files for analysis.

3. Monitor the console output or API responses for real-time analysis results.

## Contributing

Contributions to Saheli are welcome! If you have ideas for improvements or new features, feel free to submit a pull request. For major changes, please open an issue first to discuss your ideas.

## License

Saheli is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
