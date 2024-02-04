const express = require('express');
const userRoutes = require('./routes/userRoutes');

// Initialize Express
const app = express();
const PORT = process.env.PORT || 8080;

// Middleware
app.use(express.json());

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

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
