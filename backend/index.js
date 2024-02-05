const express = require('express');
const userRoutes = require('./routes/userRoutes');
const {Client} = require("@googlemaps/google-maps-services-js");
const bodyParser = require('body-parser');

const client = new Client({});

// Initialize Express
const app = express();
const PORT = process.env.PORT || 8080;

// Read data from data.json
const data = require('./data/data.json');

// Google Maps API Key
const googleMapsApiKey = process.env.GOOGLE_MAPS_API_KEY;

// Helper function to calculate distance between two points
function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371; // Radius of the earth in km
  const dLat = deg2rad(lat2 - lat1); // deg2rad below
  const dLon = deg2rad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c; // Distance in km
  return distance;
}

function deg2rad(deg) {
  return deg * (Math.PI / 180);
}

// Middleware
app.use(bodyParser.json());

// Use user routes
app.use('/users', userRoutes);


// Handle 404 errors
app.use((req, res, next) => {
  res.status(404).json({ error: 'Not Found' });
});

// Global error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

// Helper function to calculate distance between two points
function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371; // Radius of the earth in km
  const dLat = deg2rad(lat2 - lat1); // deg2rad below
  const dLon = deg2rad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c; // Distance in km
  return distance;
}

function deg2rad(deg) {
  return deg * (Math.PI / 180);
}

// Endpoint to get safest route
app.post('/safest-route', async (req, res) => {
  try {
    // Get source and destination coordinates from the request
    const { source, destination } = req.body;

    // Calculate distances between source and destination to each data point
    const distances = data.map(point => ({
      distance: calculateDistance(source.lat, source.lng, point.lati, point.longi),
      point,
    }));

    // Sort distances to find the closest point to the source
    distances.sort((a, b) => a.distance - b.distance);
    const closestPointToSource = distances[0].point;

    // console.log(distances);
    // claculate safest route
    function calculateSafestRoute(routes) {
      // Calculate safety score for each route
      const safetyScores = routes.map(route => {
        const steps = route.legs[0].steps;
        let safetyScore = 0;
        steps.forEach(step => {
          const { start_location } = step;
          const start = { lat: start_location.lat, lng: start_location.lng };
          const magnitude = distances.find(point => point.lati === start.lat && point.longi === start.lng)?.properties.mag || 5;
          const score = 1 / magnitude;
          safetyScore += score;
        });
        return safetyScore;
      });

      // Sort safety scores to find the safest route
      const safestRouteIndex = safetyScores.indexOf(Math.max(...safetyScores));
      const safestRoute = routes[safestRouteIndex];
      return safestRoute;
    }

    // Get directions from source to destination
    client.directions({
      params: {
        origin: `${source.lat},${source.lng}`,
        destination: `${destination.lat},${destination.lng}`,
        mode: 'driving',
        alternatives: true,  
        avoid: 'highways',
        key: googleMapsApiKey,
      }
    }).then((response) => {
      console.log(response.data.routes[0].legs[0].steps);
      const safestRoute = calculateSafestRoute(response.data.routes);
      res.json({safestRoute});
    }).catch((error) => {
      console.log(error);
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
