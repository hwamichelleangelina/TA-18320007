const mysqlConn = require('../config/db');

class dampingan {
    static getDampingan(psnim, callback) {
        const getDampinganQuery = 'SELECT * FROM dampingan WHERE psnim = ?;';
        mysqlConn.query(getDampinganQuery, [psnim], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static getAllJadwal(callback) {
        const getJadwalQuery = 'select initial, tanggal, psname from dampingan;';
        mysqlConn.query(getJadwalQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static getNoPSDampingan(callback) {
        const getNoPSDampinganQuery = `
            SELECT *
            FROM dampingan
            WHERE psname IS NULL;
        `;
        mysqlConn.query(getNoPSDampinganQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }  

    static getAllDampingan(callback) {
        const getAllDampinganQuery = `
            SELECT dampingan.*
            FROM dampingan
            JOIN psusers ON dampingan.psname = psusers.psname
            WHERE psusers.psisActive = 1;
        `;
        mysqlConn.query(getAllDampinganQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

        /*
        INSERT INTO dampingan (initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, tanggal, psnim, psname)
        SELECT (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, psusers.psnim, psusers.psname)
        FROM psusers
        WHERE psusers.psnim = ?;

        const values = [
        'initial_value',
        'fakultas_value',
        'gender_value',
        'angkatan_value',
        'kampus_value',
        'mediakontak_value',
        'kontak_value',
        'katakunci_value',
        'sesi_value',
        'tanggal_value',
        'psnim_value'
        ];

        */
    
    static createDampingan(dampinganData, callback) {
        if (!dampinganData || Object.keys(dampinganData).length === 0) {
            callback('Dampingan data is empty', null);
            return;
        }
    
        const { initial, fakultas, gender, angkatan, tingkat, kampus, mediakontak, kontak, katakunci, katakunci2, sesi, psname } = dampinganData;
        const createDampinganQuery = `
        INSERT INTO dampingan (initial, fakultas, gender, angkatan, tingkat, kampus, mediakontak, kontak, katakunci, katakunci2, sesi, psnim, psname)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT psnim FROM psusers WHERE psname = ?), ?);
        `;
    
        const getLastReqIdQuery = `
        SELECT reqid FROM dampingan ORDER BY reqid DESC LIMIT 1;
        `;
    
        const createRujukanQuery = `
        INSERT INTO rujukan (reqid, initial, isRujukanNeed)
        VALUES (?, ?, 0);
        `;
    
        // Mulai transaksi
        mysqlConn.beginTransaction((err) => {
            if (err) {
                console.error('Error starting transaction:', err);
                callback(err, null);
                return;
            }
    
            // Jalankan query untuk membuat data dampingan
            mysqlConn.query(createDampinganQuery, [
                initial, fakultas, gender, angkatan, tingkat, kampus, mediakontak, kontak, katakunci, katakunci2, sesi, psname, psname
            ], (err, result) => {
                if (err) {
                    return mysqlConn.rollback(() => {
                        console.error('Error creating dampingan:', err);
                        callback(err, null);
                    });
                }
    
                // Ambil reqid dari baris paling bawah (baru)
                mysqlConn.query(getLastReqIdQuery, (err, results) => {
                    if (err) {
                        return mysqlConn.rollback(() => {
                            console.error('Error getting last reqid:', err);
                            callback(err, null);
                        });
                    }
    
                    const reqid = results[0].reqid;
    
                    // Buat data baru dalam tabel rujukan
                    mysqlConn.query(createRujukanQuery, [reqid, initial], (err, result) => {
                        if (err) {
                            return mysqlConn.rollback(() => {
                                console.error('Error creating rujukan:', err);
                                callback(err, null);
                            });
                        }
    
                        // Commit transaksi jika semua query berhasil
                        mysqlConn.commit((err) => {
                            if (err) {
                                return mysqlConn.rollback(() => {
                                    console.error('Error committing transaction:', err);
                                    callback(err, null);
                                });
                            }
    
                            callback(null, result);
                        });
                    });
                });
            });
        });
    }
        
    
    static updateDataDampingan(reqid, newData, callback) {
        const { initial, fakultas, gender, angkatan, tingkat, kampus, mediakontak, kontak, katakunci, katakunci2, sesi, psname } = newData;
        const updateDampinganQuery = `
        UPDATE dampingan
        SET initial = ?, gender = ?, fakultas = ?, kampus = ?, angkatan = ?, tingkat = ?, mediakontak = ?, kontak = ?, katakunci = ?, katakunci2 = ?, psnim = (SELECT psnim FROM psusers WHERE psname = ?), sesi = ?, psname = ?
        WHERE reqid = ?
      `;
        mysqlConn.query(updateDampinganQuery, [initial, gender, fakultas, kampus, angkatan, tingkat, mediakontak, kontak, katakunci, katakunci2, psname, sesi, psname, reqid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static deleteDampingan(reqid, callback) {
        const deleteDampinganQuery = 'delete from dampingan where reqid = ?;';
        mysqlConn.query(deleteDampinganQuery, [reqid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static getCountPendampingan(reqid, callback) {
        const getCountPendampinganQuery = 'SELECT COUNT(*) as count FROM jadwal WHERE reqid = ?;';
        mysqlConn.query(getCountPendampinganQuery, [reqid], (err, result) => {
            if (err) {
                console.error('Error checking pertemuan:', err);
                res.status(500).send('Error checking pertemuan');
                return;
              }
            else {
                callback(null, result);
            }
            });
    }
}

module.exports = dampingan;
