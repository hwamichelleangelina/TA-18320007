const mysqlConn = require('../config/db');

class laporan {
    // Untuk Laporan
    static getKatakunci(reqid, callback) {
        const getKatakunciQuery = 'SELECT katakunci FROM dampingan WHERE reqid = ?;';
        mysqlConn.query(getKatakunciQuery, [reqid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static getLaporan(callback) {
        const getLaporanQuery = 'SELECT *, CONVERT_TZ(tanggal, \'+00:00\', \'+07:00\') AS tanggalKonversi FROM laporan;';
        mysqlConn.query(getLaporanQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static get1Laporan(jadwalid, callback) {
        const get1LaporanQuery = 'SELECT *, CONVERT_TZ(tanggal, \'+00:00\', \'+07:00\') AS tanggalKonversi FROM laporan WHERE jadwalid = ?;';
        mysqlConn.query(get1LaporanQuery, [jadwalid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

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

    static fillLaporan(laporanData, callback) {
        if (!laporanData || Object.keys(laporanData).length === 0) {
            callback('Laporan data is empty', null);
            return;
        }
    
        const { jadwalid, isRecommended, gambaran, proses, hasil, kendala, isAgree } = laporanData;
        const createLaporanQuery = `
        INSERT INTO laporan (jadwalid, reqid, initial, psname, psnim, tanggal, isRecommended, katakunci, katakunci2, gambaran, proses, hasil, kendala, isAgree)
        VALUES (?, (SELECT reqid FROM jadwal WHERE jadwalid = ?), (SELECT initial FROM jadwal WHERE jadwalid = ?), (SELECT psname FROM jadwal WHERE jadwalid = ?), (SELECT psnim FROM jadwal WHERE jadwalid = ?), (SELECT tanggal FROM jadwal WHERE jadwalid = ?), ?, (SELECT katakunci FROM jadwal WHERE jadwalid = ?), (SELECT katakunci2 FROM jadwal WHERE jadwalid = ?), ?, ?, ?, ?, ?);
        `;
    
        mysqlConn.query(createLaporanQuery, [
            jadwalid, jadwalid, jadwalid, jadwalid, jadwalid, jadwalid, isRecommended, jadwalid, jadwalid, gambaran, proses, hasil, kendala, isAgree
        ], (err, result) => {
            if (err) {
                console.error('Error creating laporan pendampingan:', err);
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static getLaporanFilled(jadwalid, callback) {
        const getLaporanFilledQuery = 'SELECT COUNT(*) as count FROM laporan WHERE jadwalid = ?;';
        mysqlConn.query(getLaporanFilledQuery, [jadwalid], (err, result) => {
            if (err) {
                console.error('Error checking laporan filled:', err);
                res.status(500).send('Error checking laporan filled');
                return;
              }
            else {
                callback(null, result);
            }
            });
    }
}

module.exports = laporan;