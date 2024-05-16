const resetPassword = require('../models/resetpass');

exports.resetPassPSUsers = (req, res) => {
    const { psnim, pspasswordhash } = req.body;

    resetPassword.updateaPSUsers(psnim, { pspasswordhash }, (err, result) => {
        if (err) {
            res.status(500).json({ message: "Error while updating user's password." });
        } else {
            if (result) {
                res.status(200).json({ message: "User's password successfully updated." });
            } else {
                res.status(404).json({ message: 'User not found.' });
            }
        }
    });
}

exports.resetPassBKUsers = (req, res) => {
    const { bkusername, bkpasswordhash } = req.body;

    resetPassword.updateaBKUsers(bkusername, { bkpasswordhash }, (err, result) => {
        if (err) {
            res.status(500).json({ message: "Error while updating BK user's password." });
        } else {
            if (result) {
                res.status(200).json({ message: "BK User's password successfully updated." });
            } else {
                res.status(404).json({ message: 'BK User not found.' });
            }
        }
    });
}

exports.verifyOldPSPassword = (req, res) => {
    const { psnim, oldPassword } = req.body;

    resetPassword.verifyOldPSPassword(psnim, oldPassword, (err, isMatch) => {
        if (err) {
            res.status(500).json({ message: "Error while verifying old password." });
        } else {
            if (isMatch) {
                res.status(200).json({ message: 'Password match.', isMatch: true });
            } else {
                res.status(401).json({ message: 'Old password is incorrect.', isMatch: false });
            }
        }
    });
};

exports.verifyOldBKPassword = (req, res) => {
    const { bkusername, oldPassword } = req.body;

    resetPassword.verifyOldBKPassword(bkusername, oldPassword, (err, isMatch) => {
        if (err) {
            res.status(500).json({ message: "Error while verifying old password." });
        } else {
            if (isMatch) {
                res.status(200).json({ message: 'Password match.', isMatch: true });
            } else {
                res.status(401).json({ message: 'Old password is incorrect.', isMatch: false });
            }
        }
    });
};