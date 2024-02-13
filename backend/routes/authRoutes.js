const express = require("express");
const router = express.Router();
const firebase = require("../firebase/index");
const User = require('../models/user');

// Helper function to verify and decode token
async function verifyAndDecodeToken(token) {
    const decodedToken = await firebase.auth().verifyIdToken(token);
    return decodedToken;
  }

  // Helper function to get user from Firebase
async function getUserFromFirebase(email) {
    try {
      const userRecord = await firebase.auth().getUserByEmail(email);
      return userRecord.toJSON();
    } catch (error) {
      if (error.code === "auth/user-not-found") {
        return null; // User doesn't exist in Firebase
      } else {
        throw error;
      }
    }
  }

    // Helper function to get user details from the database
async function getUserDetails(email) {
    try {
      const user = await User.getUserByEmail(email)
      return user;
    } catch (error) {   
        throw error;
        }   
    }

// Helper function to create a user in Firebase
async function createFirebaseUser(decodedToken) {
    const { email, uid } = decodedToken;
  
    try {
      const userRecord = await firebase.auth().createUser({
        uid,
        email,
      });
  
      return userRecord.toJSON();
    } catch (error) {
      throw error;
    }
  }

    // Helper function to create a user in the database
async function createDatabaseUser(decodedToken) {
    const { email, uid } = decodedToken;
  
    try {
      const newUser = await User.createUser({ email, firebase_uid: uid });
      return newUser;
    } catch (error) {
      throw error;
    }
  }


router.get("/",async (req, res) => {
    try {
        const token = req.headers.authorization.split(" ")[1];
        const decodedToken = await verifyAndDecodeToken(token);
        // Check if the user exists in Firebase
        const firebaseUser = await getUserFromFirebase(decodedToken.email);
        if(firebaseUser){
            //check if user exist in database or not
            const saheliUser = await getUserDetails(decodedToken.email);
            if(saheliUser.length !== 0){
                //login
                return res.status(200).json({saheliUser, type:"login"});
            }
            else{
                //register
                createFirebaseUser(decodedToken);
                const newUser = await createDatabaseUser(decodedToken);
                return res.status(200).json({newUser, type:"register"});
            }
        }
    } catch (error) {
        res.send(error);            

    }   
}
);

module.exports = router;