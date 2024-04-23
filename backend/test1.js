const express = require('express');
const axios = require('axios');
require('dotenv').config();

const app = express();
app.use(express.json())
const PORT = process.env.PORT || 3000;

// Google Maps API key
const API_KEY = process.env.GOOGLE_MAPS_API_KEY;

// import linked list class
const {LinkedList} = require('./linkedList');


function constructLinkedListsAndMap(routeDetails) {
    const linkedLists = [];
    const coordinateMap = {};

    // Iterate through waypoints and construct linked lists
    routeDetails.forEach((waypoint, index) => {
        // Construct linked list node
       
    });

    return { linkedLists, coordinateMap };
}

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
        res.json(routes)
        // Construct Linked Lists and Unordered Map
        // const {linkedList, unorderedMap }= constructLinkedListsAndMap(routes)
        // console.log(linkedList)
        // console.log(unorderedMap)
        // res.json({linkedList,unorderedMap})
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });

  // Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});