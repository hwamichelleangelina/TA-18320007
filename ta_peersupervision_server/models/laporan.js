const mysqlConn = require('../config/db');

class laporan {
    static fillLaporan(laporanData, callback) {
        if (!laporanData || Object.keys(laporanData).length === 0) {
            callback('Laporan data is empty', null);
            return;
        }
    
        const { jadwalid, reqid, isRecommended, gambaran, proses, hasil, kendala, isAgree } = laporanData;
        const createLaporanQuery = `
        INSERT INTO laporan (jadwalid, reqid, initial, psname, psnim, tanggal, isRecommended, katakunci, gambaran, proses, hasil, kendala, isAgree)
        VALUES (?, ?, (SELECT initial FROM jadwal WHERE jadwalid = ?), (SELECT psname FROM jadwal WHERE jadwalid = ?), (SELECT psnim FROM jadwal WHERE jadwalid = ?), (SELECT tanggal FROM jadwal WHERE jadwalid = ?), ?, (SELECT katakunci FROM dampingan WHERE reqid = ?), ?, ?, ?, ?, ?);
        `;
    
        mysqlConn.query(createLaporanQuery, [
            jadwalid, jadwalid, jadwalid, jadwalid, jadwalid, jadwalid, isRecommended, reqid, gambaran, proses, hasil, kendala, isAgree
        ], (err, result) => {
            if (err) {
                console.error('Error creating laporan pendampingan:', err);
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
}

module.exports = laporan;