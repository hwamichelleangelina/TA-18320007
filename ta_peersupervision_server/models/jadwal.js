const mysqlConn = require('../config/db');

class jadwal {
    static getAllJadwal(callback) {
        const getJadwalQuery = 'select initial, tanggal, psname , mediadampingan from jadwal;';
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
        INSERT INTO jadwal (reqid, tanggal, initial, psnim, psname, mediapendampingan)
        VALUES (?, ?, (SELECT initial FROM dampingan WHERE reqid = ?), (SELECT psnim FROM dampingan WHERE reqid = ?), (SELECT psname FROM dampingan WHERE reqid = ?), ?);
        `;
    
        mysqlConn.query(createJadwalQuery, [
            reqid, tanggal, reqid, reqid, reqid, mediapendampingan
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