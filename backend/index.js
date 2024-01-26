const express = require('express');
const cors = require("cors");
const mongoose = require('mongoose');
const userRouter = require('./views/user');
const PORT = process.env.PORT || 3000;


const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

//MongoDB Connection
mongoose.connect('mongodb://localhost:27017/saheli-database')
.then(() => console.log('MongoDB Connected'))
.catch(err => console.log(err));


// Routes
app.get('/',userRouter)


// Server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}` );
})

