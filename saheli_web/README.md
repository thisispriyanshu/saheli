# Saheli - Empowering Women's Safety

Welcome to Saheli, a Next.js web application designed to empower women with features that enhance their safety and security.

## Getting Started

### Prerequisites

Ensure you have Node.js and npm (or yarn) installed on your system. You can check by running `node -v` and `npm -v` (or `yarn -v`) in your terminal.

### Clone the Repository

```bash
git clone https://thisispriyanshu/saheli.git
cd Saheli
cd saheli-web
```

### Install Dependencies
```bash
npm install  # or yarn install
```

### Install Dependencies
```bash
npm run dev  # or yarn dev
```

This starts the development server and opens the application in your default browser, usually at http://localhost:3000.

### Project Structure

Saheli/
  ├── components/     # Reusable UI components
  │   ├── Demo.tsx
  │   ├── Feature.tsx
  │   ├── loading-dots.tsx
  │   ├── modal.tsx
  │   ├── UserReviews.tsx
  │   └── video-modal.tsx  
  ├── pages/          # Application pages
  │   ├── index.jsx   
  │   ├── _app.jsx     
  │   └── _documents.jsx  
  ├── styles/         # Global and component-specific styles
  │   └── global.css
  ├── public/         # Static assets (images, fonts, etc.)
  │   └── assests
  ├── next.config.js  # Next.js configuration file
  └── package.json    # Project dependencies and scripts

# Saheli - Empowering Women's Safety

Saheli offers a comprehensive suite of features to equip women with peace of mind and the ability to navigate their surroundings confidently:

- **Safe Route Navigation:** Provides optimized route suggestions that prioritize well-lit and well-trafficked areas, enhancing your sense of security during travel.
- **Fake Caller:** Simulates an incoming call to create a diversion in potentially risky situations, offering a discreet way to excuse yourself.
- **Emergency Service Locators:** Helps you quickly find nearby police stations, hospitals, and other critical services, ensuring access to assistance when needed.
- **Offline Functionality:** Designed to function even in areas with limited internet connectivity, guaranteeing crucial safety features are always available.

## Future Features (Under Development):

- **Violence Detection:** Leverages advanced algorithms to detect potential violence in your vicinity and trigger immediate alerts to emergency contacts.
- **Harsh Braking Detection:** Senses sudden braking that could indicate an accident and sends automated notifications to your designated contacts to ensure your well-being.

## Contributing

We welcome contributions to Saheli! If you have ideas for improvement or want to fix issues, please feel free to fork the repository, create a branch for your changes, and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Additional Notes

- Consider creating a detailed `features.jsx` page that elaborates on the violence detection and harsh braking features (once implemented) and highlights their future benefits.
- Explore integrating map services (e.g., Google Maps) for the safe route navigation feature.
- For production deployment, follow Next.js's deployment documentation to configure a hosting environment and make your app accessible online.

By following these guidelines and leveraging the power of Next.js, you can create a robust and impactful web application that empowers women with the tools they need to stay safe.


