const admin = require('../firebase/index');

const db = admin.firestore();

const userCollection = db.collection('users');

const User = {
  getAllUsers: async () => {
    const usersSnapshot = await userCollection.get();
    const users = [];
    usersSnapshot.forEach((doc) => {
      users.push({ id: doc.id, ...doc.data() });
    });
    return users;
  },

  getUserById: async (userId) => {
    const userDoc = await userCollection.doc(userId).get();
    if (!userDoc.exists) {
      return null;
    }
    return { id: userDoc.id, ...userDoc.data() };
  },

  createUser: async (userData) => {
    const newUserRef = await userCollection.add(userData);
    const newUserDoc = await newUserRef.get();
    return { id: newUserRef.id, ...newUserDoc.data() };
  },

  updateUserById: async (userId, userData) => {
    await userCollection.doc(userId).set(userData, { merge: true });
    const updatedUserDoc = await userCollection.doc(userId).get();
    return { id: updatedUserDoc.id, ...updatedUserDoc.data() };
  },

  deleteUserById: async (userId) => {
    await userCollection.doc(userId).delete();
  },
};

module.exports = User;
