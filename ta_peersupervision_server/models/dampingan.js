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
        
            const { initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psname } = dampinganData;
            const createDampinganQuery = `
            INSERT INTO dampingan (initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psnim, psname)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT psnim FROM psusers WHERE psname = ?), ?);
            `;
        
            mysqlConn.query(createDampinganQuery, [
                initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psname, psname
            ], (err, result) => {
                if (err) {
                    console.error('Error creating dampingan:', err);
                    callback(err, null);
                } else {
                    callback(null, result);
                }
            });
        }
    
    

    static updateDataDampingan(reqid, newData, callback) {
        const { initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psnim, tanggal, psname } = newData;
        const updateDampinganQuery = 'update dampingan set initial = ?, fakultas = ?, gender = ?, angkatan = ?, kampus = ?, mediakontak = ?, kontak = ?, katakunci = ?, sesi = ?, psnim = ?, tanggal = ?, psname = ? where reqid = ?;';
        mysqlConn.query(updateDampinganQuery, [initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psnim, tanggal, psname, reqid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
    
    // PEMBUATAN JADWAL
    static updateDampinganTanggal(reqid, newTanggal, callback) {
        const updateTanggalQuery = 'UPDATE dampingan SET tanggal = ? WHERE reqid = ?;';
        mysqlConn.query(updateTanggalQuery, [newTanggal, reqid], (err, result) => {
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
