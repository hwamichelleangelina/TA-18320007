const mysqlConn = require('../config/db');

class jadwal {
    static getJadwal(psnim, callback) {
        const getJadwalQuery = 'SELECT *, CONVERT_TZ(tanggal, \'+00:00\', \'+07:00\') AS tanggalKonversi FROM jadwal WHERE psnim = ?;';
        mysqlConn.query(getJadwalQuery, [psnim], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static deleteJadwal(jadwalid, callback) {
        const deleteJadwalQuery = 'delete from jadwal where jadwalid = ?;';
        mysqlConn.query(deleteJadwalQuery, [jadwalid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    // Untuk Admin BK
    static getAllJadwal(callback) {
        const getJadwalQuery = 'SELECT *, CONVERT_TZ(tanggal, \'+00:00\', \'+07:00\') AS tanggalKonversi FROM jadwal;';
        mysqlConn.query(getJadwalQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static createJadwal(jadwalData, callback) {
        if (!jadwalData || Object.keys(jadwalData).length === 0) {
            callback('Jadwal data is empty', null);
            return;
        }
    
        const { reqid, tanggal, mediapendampingan } = jadwalData;
        const createJadwalQuery = `
        INSERT INTO jadwal (reqid, tanggal, initial, psnim, psname, mediapendampingan, katakunci)
        VALUES (?, ?, (SELECT initial FROM dampingan WHERE reqid = ?), (SELECT psnim FROM dampingan WHERE reqid = ?), (SELECT psname FROM dampingan WHERE reqid = ?), ?, (SELECT katakunci FROM dampingan WHERE reqid = ?));
        `;
    
        mysqlConn.query(createJadwalQuery, [
            reqid, tanggal, reqid, reqid, reqid, mediapendampingan, reqid
        ], (err, result) => {
            if (err) {
                console.error('Error creating jadwal pendampingan:', err);
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
}

module.exports = jadwal;