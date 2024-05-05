module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      backgroundImage: {
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",
        "gradient-conic": "conic-gradient(var(--tw-gradient-stops))",
      },
      colors: {
        primary: "#FD6978",
        secondary: "#FCF3E8",
        text: "#F0F0F0",
      },
      fontFamily: {
        default: ["var(--font-inter)", "system-ui", "sans-serif"],
      },
      keyframes: {
        disco: {
          "0%": { transform: "translateY(-50%) rotate(0deg)" },
          "100%": { transform: "translateY(-50%) rotate(360deg)" },
        },
      },
      animation: {
        disco: "disco 1.5s linear infinite",
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
