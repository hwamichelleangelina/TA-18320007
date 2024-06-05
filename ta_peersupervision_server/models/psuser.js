const mysqlConn = require('../config/db');
const bcrypt = require('bcryptjs');

class psUser {
    static getaPSUsers(psnim, pspasswordhash, callback) {
        const getPSquery = 'select * from psusers where psnim = ?;';
        mysqlConn.query(getPSquery, [psnim], (err, result) => {
            if (err) {
                callback(err, null);
            }
            else if (result.length > 0) {
                const psuser = result[0];
                bcrypt.compare(pspasswordhash, psuser.pspasswordhash, (err, result) => {
                    if (result) {
                        callback(null, psuser);
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

    static createaPSUsers(userPSData, callback) {
        const { psname, psnim, pspasswordhash, psisActive, psisAdmin } = userPSData;
        bcrypt.hash(pspasswordhash, 10, (err, hash) => {
            if (err) {
                callback(err, null);
            }
            else {
                const createPSquery = 'insert into psusers(psname, psnim, pspasswordhash, psisActive, psisAdmin, pstahunaktif) values (?, ?, ?, ?, ?, YEAR(CURRENT_TIMESTAMP));';
                mysqlConn.query(createPSquery, [psname, psnim, hash, psisActive, psisAdmin], (err, result) => {
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

    static deleteaPSUsers(psnim, callback) {
        const deletePSquery = 'delete from psusers where psnim = ?;';
        mysqlConn.query(deletePSquery, [psnim], (err, result) => {
            if (err) {
                callback(err, null);
            }
            else {
                // Jika operasi penghapusan berhasil, result berisi informasi tentang jumlah baris yang terpengaruh
                // Anda dapat memeriksa nilai result untuk memastikan penghapusan berhasil
                if (result.affectedRows > 0) {
                    callback(null, true); // Sukses menghapus
                } else {
                    callback(null, false); // Tidak ada baris yang terpengaruh, mungkin karena data tidak ditemukan
                }
            }
        });
    }

    static updateaPSUsers(psnim, NewuserPSData, callback) {
        const { psname, pspasswordhash, psisActive, psisAdmin } = NewuserPSData;
        bcrypt.hash(pspasswordhash, 10, (err, hash) => {
            if (err) {
                callback(err, null);
            }
            else {
                const updatePSquery = 'update psusers set psname = ?, pspasswordhash = ?, psisActive = ?, psisAdmin = ? where psnim = ?;';
                mysqlConn.query(updatePSquery, [psname, hash, psisActive, psisAdmin, psnim], (err, result) => {
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

    static nonActivateUsers(psnim, callback) {
        const nonActivateQuery = 'update psusers set psisActive = 0 where psnim = ?;';
            mysqlConn.query(nonActivateQuery, [psnim], (err, result) => {
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

    static getAllPSUsers(callback) {
        const query =
        `select
            psname as Nama,
            psnim as NIM,
            case 
                when psisAdmin = 1 then 'Kadiv Kuratif'
                else 'Anggota PS'
            end as Role
        from 
            psusers
        where
            psisActive = 1;`;
        mysqlConn.query(query, (err, results) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, results);
            }
        });
    }

    static getNAPSUsers(callback) {
        const query =
        `select
            psname as Nama,
            psnim as NIM,
            pstahunaktif as Tahun,
            case 
                when psisAdmin = 1 then 'Kadiv Kuratif'
                else 'Anggota PS'
            end as Role
        from 
            psusers
        where
            psisActive = 0;`;
        mysqlConn.query(query, (err, results) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, results);
            }
        });
    }

    // SELECT psname FROM psusers WHERE psisActive = 1;
    static getActivePS(callback) {
        const query =
        `SELECT
            psname
        FROM
            psusers
        WHERE
            psisActive = 1;`;
        mysqlConn.query(query, (err, results) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, results);
            }
        });
    } 

    static countPSDampingandone(callback) {
        const getCountPSdoneQuery = 'SELECT psnim, COUNT(*) AS count FROM dampingan GROUP BY psnim;';
        mysqlConn.query(getCountPSdoneQuery, (err, result) => {
            if (err) {
                console.error('Error checking pertemuan:', err);
                res.status(500).send('Error checking dampingan frequency');
                return;
              }
            else {
                callback(null, result);
            }
            });
    }
    
    static countPSdone(callback) {
        const getCountPSdoneQuery = 'SELECT psnim, COUNT(*) AS count FROM jadwal GROUP BY psnim;';
        mysqlConn.query(getCountPSdoneQuery, (err, result) => {
            if (err) {
                console.error('Error checking pertemuan:', err);
                res.status(500).send('Error checking pendampingan frequency');
                return;
              }
            else {
                callback(null, result);
            }
            });
    }
}

module.exports = psUser;