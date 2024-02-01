const User = require('../models/user');

const getUser = async (req, res) => {
    const user = await User.find();
    res.send(user);
}


module.exports = {
    getUser
}