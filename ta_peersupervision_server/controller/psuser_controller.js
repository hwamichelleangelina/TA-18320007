const psUser= require('../models/psuser');
exports.loginPSUsers = (req, res) => {
    const { psnim, pspasswordhash } = req.body;

    psUser.getaPSUsers(psnim, pspasswordhash, (err, psusers) => {
        if (err) {
            console.error('Error fetching user:', err);
            res.status(500).json({message: 'User failed to login.'});
        }
        else if (psusers && psusers.inactive) {
            console.log('User is inactive:', psusers);
            res.status(403).json({message: 'User is inactive.'});
        }
        else if (psusers) {
            console.log('User successfully logged in:', psusers);
            res.status(200).json({message: 'User successfully logged in.', psusers});
        }
        else {
            console.log('Invalid credentials provided.');
            res.status(401).json({message: 'Invalid credentials. Please try again.'});
        }
    });
}


// BY ADMIN BK

exports.registerPSUsers = (req, res) => {
    const { psname, psnim, pspasswordhash, psisActive, psisAdmin } = req.body;

    psUser.createaPSUsers({psname, psnim, pspasswordhash, psisActive, psisAdmin}, (err, psusers) => {
        if (err) {
            res.status(500).json({message: 'Error while registering user.'});
        }
        else {
            res.status(200).json({message: 'User successfully registered, please continue login.', psusers});
        }
    });
}

exports.deletePSUsers = (req, res) => {
    const { psnim } = req.body;

    psUser.deleteaPSUsers(psnim, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error while deleting user.' });
        } else {
            if (result) {
                res.status(200).json({ message: 'User successfully deleted.' });
            } else {
                res.status(404).json({ message: 'User not found.' });
            }
        }
    });
}

exports.updatePSUsers = (req, res) => {
    const { psnim, psname, pspasswordhash, psisActive, psisAdmin } = req.body;

    psUser.updateaPSUsers(psnim, { psname, pspasswordhash, psisActive, psisAdmin }, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error while updating user.' });
        } else {
            if (result) {
                res.status(200).json({ message: 'User successfully updated.' });
            } else {
                res.status(404).json({ message: 'User not found.' });
            }
        }
    });
}

exports.nonActiveUsers = (req, res) => {
    const { psnim } = req.body;

    psUser.nonActivateUsers(psnim, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error while non-activating user.' });
        } else {
            if (result) {
                res.status(200).json({ message: 'User successfully non-activated.' });
            } else {
                res.status(404).json({ message: 'User not found.' });
            }
        }
    });
}

exports.getAllPSUsers = (req, res) => {
    psUser.getAllPSUsers((err, users) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving PS users.' });
        } else {
            res.status(200).json(users);
        }
    });
}

exports.getNAPSUsers = (req, res) => {
    psUser.getNAPSUsers((err, users) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving Non Active PS users.' });
        } else {
            res.status(200).json(users);
        }
    });
}

exports.getActivePS = (req, res) => {
    psUser.getActivePS((err, users) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving Active PS users.' });
        } else {
            res.status(200).json(users);
        }
    });
}

exports.countPSdone = (req, res) => {
    psUser.countPSdone((err, result) => {
        if (err) {
            console.error('Error checking pendampingan frequency:', err);
            res.status(500).send('Error pendampingan frequency');
            return;
          }
        else {
            res.status(200).json(result);
        }
    });
};

exports.countPSDampingandone = (req, res) => {
    psUser.countPSDampingandone((err, result) => {
        if (err) {
            console.error('Error checking dampingan frequency:', err);
            res.status(500).send('Error dampingan frequency');
            return;
          }
        else {
            res.status(200).json(result);
        }
    });
};