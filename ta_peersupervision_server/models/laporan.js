const mysqlConn = require('../config/db');

class laporan {
    static fillLaporan(laporanData, callback) {
        if (!laporanData || Object.keys(laporanData).length === 0) {
            callback('Laporan data is empty', null);
            return;
        }
    
        const { reqid, isRecommended, gambaran, proses, hasil, kendala } = laporanData;
        const createLaporanQuery = `
        INSERT INTO laporan (reqid, initial, psname, psnim, tanggal, isRecommended, katakunci, gambaran, proses, hasil, kendala)
        VALUES (?, (SELECT initial FROM jadwal WHERE reqid = ?), (SELECT psname FROM dampingan WHERE reqid = ?), (SELECT psnim FROM dampingan WHERE reqid = ?), (SELECT tanggal FROM jadwal WHERE reqid = ?), ?, (SELECT katakunci FROM dampingan WHERE reqid = ?), ?, ?, ?, ?);
        `;
    
        mysqlConn.query(createLaporanQuery, [
            reqid, reqid, reqid, reqid, reqid, isRecommended, reqid, gambaran, proses, hasil, kendala
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

module.exports = laporan;