const bkUser= require('../models/bkuser');

exports.loginBKUsers = (req, res) => {
    const { bkusername, bkpasswordhash } = req.body;

    bkUser.getaBKUsers(bkusername, bkpasswordhash, (err, bkusers) => {
        if (err) {
            res.status(500).json({message: 'User failed to login.'});
        }
        else if (bkusers) {
            res.status(200).json({message: 'User successfully logged in.', bkusers});
        }
        else {
            res.status(401).json({message: 'Invalid credentials. Please try again.'});
        }
    });
}

exports.registerBKUsers = (req, res) => {
    const { bkname, bknpm, bkusername, bkpasswordhash } = req.body;

    bkUser.createaBKUsers({bkname, bknpm, bkusername, bkpasswordhash}, (err, bkusers) => {
        if (err) {
            res.status(500).json({message: 'Error while registering user.'});
        }
        else {
            res.status(200).json({message: 'User successfully registered, please continue login.', bkusers});
        }
    });
}