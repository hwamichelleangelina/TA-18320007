const mysqlConn = require('../config/db');
const bcrypt = require('bcryptjs');

class resetPassword {
    static updateaPSUsers(psnim, NewuserPSData, callback) {
        const { pspasswordhash } = NewuserPSData;
        bcrypt.hash(pspasswordhash, 10, (err, hash) => {
            if (err) {
                callback(err, null);
            }
            else {
                const updatePSquery = 'update psusers set pspasswordhash = ? where psnim = ?;';
                mysqlConn.query(updatePSquery, [hash, psnim], (err, result) => {
                    if (err) {
                        callback(err, null);
                    } else {
                        // Jika operasi pembaruan berhasil, result berisi informasi tentang jumlah baris yang terpengaruh
                        // Anda dapat memeriksa nilai result untuk memastikan pembaruan berhasil
                        if (result.affectedRows > 0) {
                            callback(null, true); // Sukses memperbarui
                        } else {
                            callback(null, false); // Tidak ada baris yang terpengaruh, mungkin karena data tidak ditemukan
                        }
                    }
                });
            }
        });
    }

    static updateaBKUsers(bkusername, NewuserData, callback) {
        const { bkpasswordhash } = NewuserData;
        bcrypt.hash(bkpasswordhash, 10, (err, hash) => {
            if (err) {
                callback(err, null);
            }
            else {
                const updateBKquery = 'update bkusers set bkpasswordhash = ? where bkusername = ?;';
                mysqlConn.query(updateBKquery, [hash, bkusername], (err, result) => {
                    if (err) {
                        callback(err, null);
                    } else {
                        // Jika operasi pembaruan berhasil, result berisi informasi tentang jumlah baris yang terpengaruh
                        // Anda dapat memeriksa nilai result untuk memastikan pembaruan berhasil
                        if (result.affectedRows > 0) {
                            callback(null, true); // Sukses memperbarui
                        } else {
                            callback(null, false); // Tidak ada baris yang terpengaruh, mungkin karena data tidak ditemukan
                        }
                    }
                });
            }
        });
    }

    static verifyOldPSPassword(psnim, oldPassword, callback) {
        const query = 'select pspasswordhash from psusers where psnim = ?;';
        mysqlConn.query(query, [psnim], (err, results) => {
            if (err) {
                callback(err, null);
            } else {
                if (results.length > 0) {
                    bcrypt.compare(oldPassword, results[0].pspasswordhash, (err, isMatch) => {
                        if (err) {
                            callback(err, null);
                        } else {
                            callback(null, isMatch);
                        }
                    });
                } else {
                    callback(null, false);
                }
            }
        });
    }

    static verifyOldBKPassword(bkusername, oldPassword, callback) {
        const query = 'select bkpasswordhash from bkusers where bkusername = ?;';
        mysqlConn.query(query, [bkusername], (err, results) => {
            if (err) {
                callback(err, null);
            } else {
                if (results.length > 0) {
                    bcrypt.compare(oldPassword, results[0].bkpasswordhash, (err, isMatch) => {
                        if (err) {
                            callback(err, null);
                        } else {
                            callback(null, isMatch);
                        }
                    });
                } else {
                    callback(null, false);
                }
            }
        });
    }
}

module.exports = resetPassword;