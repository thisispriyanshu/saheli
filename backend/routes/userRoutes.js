const express = require('express');
const router = express.Router();
const User = require('../models/user');

// Get all users
router.get('/', async (req, res) => {
  try {
    const users = await User.getAllUsers();
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Get a specific user by ID
router.get('/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    const user = await User.getUserById(userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Create a new user
router.post('/', async (req, res) => {
  const userData = req.body;
  try {
    const newUser = await User.createUser(userData);
    res.status(201).json(newUser);
  } catch (error) {
    res.status(400).json({ error: 'Bad Request' });
  }
});

// Update a user by ID
router.put('/:userId', async (req, res) => {
  const { userId } = req.params;
  const userData = req.body;
  try {
    const updatedUser = await User.updateUserById(userId, userData);
    if (!updatedUser) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(200).json(updatedUser);
  } catch (error) {
    res.status(400).json({ error: 'Bad Request' });
  }
});

// Delete a user by ID
router.delete('/:userId', async (req, res) => {
  const { userId } = req.params;
  try {
    await User.deleteUserById(userId);
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

module.exports = router;
