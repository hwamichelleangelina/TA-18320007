const mysqlConn = require('../config/db');
const bcrypt = require('bcryptjs');

class bkUser {
    static getaBKUsers(bkusername, bkpasswordhash, callback) {
        const getBKquery = 'select * from bkusers where bkusername = ?;';
        mysqlConn.query(getBKquery, [bkusername], (err, result) => {
            if (err) {
                callback(err, null);
            }
            else if (result.length > 0) {
                const bkuser = result[0];
                bcrypt.compare(bkpasswordhash, bkuser.bkpasswordhash, (err, result) => {
                    if (result) {
                        callback(null, bkuser);
                    }
                    else {
                        callback(null, null);
                    }
                });
            }
            else {
                callback(null, null);
            }
        });
    }

    static createaBKUsers(userBKData, callback) {
        const { bkname, bknpm, bkusername, bkpasswordhash } = userBKData;
        bcrypt.hash(bkpasswordhash, 10, (err, hash) => {
            if (err) {
                callback(err, null);
            }
            else {
                const createBKquery = 'insert into bkusers(bkname, bknpm, bkusername, bkpasswordhash) values (?, ?, ?, ?);';
                mysqlConn.query(createBKquery, [bkname, bknpm, bkusername, hash], (err, result) => {
                    if (err) {
                        callback(err, null);
                    }
                    else {
                        callback(null, result);
                    }
                });
            }
        });
    }
}

module.exports = bkUser;