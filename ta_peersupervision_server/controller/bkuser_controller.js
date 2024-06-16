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
    const validInviteCodes = ['KODEKHUSUSUNTUKBK183', 'REGISTRASIBKITB18320'];
    
    const { bkname, bknpm, bkusername, bkpasswordhash, inviteCode } = req.body;

    if (!validInviteCodes.includes(inviteCode)) {
        return res.status(400).json({message: 'Kode undangan salah.'});
      }
    else {
        bkUser.createaBKUsers({bkname, bknpm, bkusername, bkpasswordhash}, (err, bkusers) => {
            if (err) {
                res.status(500).json({message: 'Terjadi kesalahan eror pada saat registrasi user.'});
            }
            else {
                res.status(200).json({message: 'User baru berhasil registrasi, silakan lanjut masuk ke akun Anda.', bkusers});
            }
        });
    }
}