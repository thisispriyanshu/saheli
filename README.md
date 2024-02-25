# Saheli - Your Ultimate Safety Companion

Saheli, meaning 'female best friend' in Hindi, is an innovative mobile application designed to ensure the safety and security of women, empowering them to navigate through various situations confidently. Developed as a part of the Google Solution Challenge hackathon 2024, Saheli app is built using Flutter and integrating cutting-edge technologies and thoughtful features to address the pressing issue of women's safety.

[![Watch the video](http://i3.ytimg.com/vi/c8pdFwBinEU/hqdefault.jpg)](https://www.youtube.com/embed/APOPm01BVrk)

## Features:

- **SOS Alert**: Women can swiftly send their location to pre-set trusted contacts in case of emergencies, ensuring immediate assistance.
  
- **Safe Route**: Utilizes Google Maps API and K-means clustering ML algorithm to provide the safest and shortest path to the destination, enhancing navigation security.
  
- **Emergency Services Locator**: Quickly access nearby police stations, hospitals, and bus stands from the current location, ensuring immediate access to help.
  
- **Helpline Directory**: Comprehensive list of important helpline numbers essential during emergencies, facilitating quick access to support services.

- **Fake Caller**: Activate a fake incoming call feature by shaking the phone or manually triggering, providing a discreet exit strategy from potentially unsafe situations.
  
- **Scheduled Fake Caller**: Set scheduled fake calls with customized name, number, and timing, offering a seamless escape plan.
  
- **AI Chatbot (Sakha)**: Integrated AI chatbot using Gemini AI, VERTEX AI API and Dialogflow which is trained on women's safety, providing guidance, tips, and assistance during emergencies.
  
- **Crowdsourced Safety Zones**: Empower users to report unsafe areas and identify verified safe zones, fostering community-driven safety initiatives.
  
- **Offline Accessibility**: Ensure core functionalities remain accessible even without internet connectivity, prioritizing usability in diverse environments.
  
- **Audio-Video Recording**: Activate automatic audio-video recording with SOS alerts, capturing real-time environment data for immediate assistance or legal evidence.

### How to use each feature in App visit : https://thisispriyanshu.github.io/saheli/

## Purpose:

Saheli aims to create a safer environment for women by leveraging technology and community engagement. Our mission is to empower women with tools and resources that enhance their safety and provide peace of mind, fostering a society where every woman feels secure and supported.

## Architecture
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/85655af2-4798-4f84-a291-4f5d7b181f2f)

## How to run the Frontend(Flutter):

1. Clone the repository:<br>
    ```git clone https://github.com/thisispriyanshu/saheli.git```
2. Navigate to the project directory Saheli/frontend/saheli_app:<br>
    ``` cd saheli/frontend`/saheli_app ```
3. Download the the zip repository of audioplayers library from here https://github.com/bluefireteam/audioplayers/tree/master/packages/audioplayers and add the path in the pubspec.yaml file in your directory like this
   ```
   audioplayers:
    path: E:\saheli\audioplayers-main\packages\audioplayers
   ```
   
5. Get dependencies
Run the following command to fetch dependencies using pub:<br>
   ```flutter pub get```
6. Connect your device or start an emulator/simulator.<br>
7. Run the app:
Run the main.dart file using the flutter run command:<br>
   ```flutter run lib/main.dart```

## How to run the backend(NodeJS):
 1. Clone the repository:<br>
    ``` git clone https://github.com/thisispriyanshu/saheli.git ```
2. Navigate to the project directory Saheli/backend:<br>
    ``` cd saheli/backend ```
3. Open terminal and run npm i to install all dependencies:<br>
    ```npm i```
4. Create .env in root folder and add some secret keys in .env file:<br>
   ```
   GEMINI_API_KEY =
   GOOGLE_MAPS_API_KEY=
   SECRET_KEY=
   PORT=
   ```
5. Now in terminal we can run npm start to start the server on mentioned port in .env otherwise it will  by default run in PORT:8080:<br>
   ``` npm start ```

## Technologies Used:

- Flutter & Dart (Frontend)
- Node.js (Backend)
- Google Maps API
- K-means Clustering
- Firebase (Authentication, Firestore)
- Dialogflow
- Gemini AI API
- Vertex AI API
- Compute Engine (Deployment)

## App Images
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/ad8efa48-6894-4612-b055-9aeab70428d2)
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/22b06add-c75e-4d52-ae3f-5ad564c2fcc3)
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/1e16bc1f-4ae2-4212-8b8b-fac3dab353f0)
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/ca744d0e-2ddb-465d-9078-7fb4550d6b2f)
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/35156629-1955-4397-ba24-23baa4b8ad38)

## Further Enhancement Ideas:

1. **Community Engagement Campaigns**: Organize workshops, webinars, or awareness campaigns to educate and empower women on safety practices and app usage.
  
2. **Partnerships with Local Authorities**: Collaborate with law enforcement agencies and local authorities to integrate Saheli into existing safety infrastructure and emergency response systems.
  
3. **Gamification Elements**: Introduce gamification elements within the app to incentivize users to actively contribute to the crowdsourcing of safe zones and report unsafe areas.
  
4. **Real-time Safety Alerts**: Implement a feature that provides real-time safety alerts based on user location and reported incidents, keeping users informed about potential risks in their vicinity.
  
5. **Peer Support Networks**: Facilitate the creation of peer support networks within the app, allowing users to connect with nearby individuals for assistance or companionship during travel or emergencies.

## Impact & UN Sustainable Development Goals:
![image](https://github.com/thisispriyanshu/saheli/assets/73881504/13d035f9-95bc-4a0f-916a-f83094528685) ![image](https://github.com/thisispriyanshu/saheli/assets/73881504/cd13f45b-faf2-4d4e-9aff-d565cfe5ef05) ![image](https://github.com/thisispriyanshu/saheli/assets/73881504/41d480cb-607b-40d9-88e9-b2bebbb6b581) ![image](https://github.com/thisispriyanshu/saheli/assets/73881504/6073a03a-dd09-4eac-aeca-4ab17d91380e)

**Goal 4: Quality education**
* **Self-defense knowledge:** Equips women with practical skills for personal safety and builds confidence.
* **Crime awareness:** Increases understanding of risks and empowers informed choices, promoting safety for all.
* **Self-empowerment topics:** Builds confidence, resilience, and critical thinking skills, fostering overall well-being and empowerment.
  
**Goal 5: Achieve gender equality and empower all women and girls**
* **Empowers women:** Features like SOS, self-defense information, and the AI chatbot enhance security and confidence, allowing women to navigate their environments more freely.
* **Reduces violence:** Safer journeys, proactive alerts, and community-driven safety reporting decrease women's vulnerability to violence and harassment.
* **Increases participation:** Freedom from fear and improved safety encourage women to participate more fully in public life, education, and employment.

**Goal 11: Sustainable cities and communities**
* **Safer public spaces:** Saheli empowers women to utilize public spaces freely, fostering inclusion and vibrant communities.
* **Community involvement:** Crowdsourced data on unsafe areas and verified safe zones improve safety mapping and awareness for everyone.
* **Empowered citizens:** By promoting women's safety and participation, Saheli contributes to a more equitable and sustainable urban environment.
 
**Goal 16: Peace, justice and strong institutions**
* **Reduces violence and crime:** By empowering women and promoting safer communities, Saheli contributes to a decrease in violence and crime overall.
* **Strengthens institutions:** Increased trust and collaboration between community members and law enforcement agencies can be fostered through Saheli's features.
* **Promotes justice:** By providing women with tools and resources to report abuse and seek help, Saheli contributes to a more just society.

## How to Contribute:

Contributions to Saheli are welcome! If you have ideas for new features, improvements, or bug fixes, please feel free to submit a pull request.

## About Team
 - [Apoorv Yash](https://www.linkedin.com/in/apoorv-yash-75b130230/)
 - [Priyanshu Agrawal](https://www.linkedin.com/in/priyanshu-agrawal-5a00651b1/)
 - [Yuvraj Singh](https://www.linkedin.com/in/yuvraj-singh-5198441aa/)
 - [Agrim Saxena](https://www.linkedin.com/in/agrim-saxena-29529b223/)


## License:

This project is licensed under the [MIT License](LICENSE).
