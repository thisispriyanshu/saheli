const express = require('express');
const userRoutes = require('./routes/userRoutes');
const authRoutes = require('./routes/authRoutes');
const {Client} = require("@googlemaps/google-maps-services-js");
const bodyParser = require('body-parser');
const { safeRouteJson } = require('./safeRoute');
require("dotenv").config();
const axios = require('axios');

// Initialize Express
const app = express();
const PORT = process.env.PORT || 8080;

// // Use user routes
// app.use('/users', userRoutes);


// Google Maps API Key
const API_KEY = process.env.GOOGLE_MAPS_API_KEY;

// Endpoint to get safest route
app.post('/safest-route', async (req, res) => {
  try {
    // Get source and destination coordinates from the request
    const { source, destination, mode } = req.query;
  
      // Get Routes from source to destination
      const response = await axios.get(`https://maps.googleapis.com/maps/api/directions/json`, {
            params: {
                origin: source,
                destination: destination,
                mode: mode,
                key: API_KEY,
                alternatives: true // Request multiple routes
            }
        });
        const routes= response.data.routes;
        result=safeRouteJson(routes)
        return res.json(result)
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// Handle 404 errors
app.use((req, res, next) => {
  res.status(404).json({ error: 'Not Found' });
});

// Global error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
