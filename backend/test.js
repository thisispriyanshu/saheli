const express = require('express');
const axios = require('axios');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Google Maps API key
const API_KEY = process.env.GOOGLE_MAPS_API_KEY;

// Example source and destination coordinates
const source = '28.8162605,77.1306592';
const destination = '28.550121,77.1866867';

// Route to fetch directions with alternate routes
app.get('/directions', async (req, res) => {
    try {
        const response = await axios.get(`https://maps.googleapis.com/maps/api/directions/json`, {
            params: {
                origin: source,
                destination: destination,
                key: API_KEY,
                // alternatives: true // Request multiple routes
            }
        });

        const routes = response.data.routes.slice(0, 5); // Extract the first 5 routes
        res.json(routes);
    } catch (error) {
        console.error('Error fetching directions:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
