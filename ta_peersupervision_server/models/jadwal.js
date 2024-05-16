const mysqlConn = require('../config/db');

class jadwal {
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
}

module.exports = jadwal;