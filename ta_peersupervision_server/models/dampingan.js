const mysqlConn = require('../config/db');

class dampingan {
    static getDampingan(psnim, callback) {
        const getDampinganQuery = 'select * from dampingan where psnim = ?;';
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
        const getAllDampinganQuery = 'select * from dampingan;';
        mysqlConn.query(getAllDampinganQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static createDampingan(dampinganData, callback) {
        if (!dampinganData || Object.keys(dampinganData).length === 0) {
            callback('Dampingan data is empty', null);
            return;
        }
    
        const { initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psnim, tanggal, psname } = dampinganData;
        const createDampinganQuery = `
            INSERT INTO dampingan (initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psnim, tanggal, psname) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        `;
    
        mysqlConn.query(createDampinganQuery, [
            initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, psnim, tanggal, psname
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
}

module.exports = dampingan;
