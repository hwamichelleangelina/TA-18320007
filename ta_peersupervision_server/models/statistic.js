const mysqlConn = require('../config/db');

class statistic {
    // Untuk Laporan
    static jadwalpermonth(callback) {
        const jadwalpermonthQuery = `
        SELECT DATE_FORMAT(tanggal, '%Y-%m') as month, COUNT(*) as count
        FROM jadwal
        GROUP BY month
        ORDER BY month;
      `;
        mysqlConn.query(jadwalpermonthQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static topPSdampingan(callback) {
        const topPSdampinganQuery = `
            SELECT psname, COUNT(*) as dampingan_count
            FROM dampingan
            GROUP BY psname
            ORDER BY dampingan_count DESC
            LIMIT 20;
        `;
        mysqlConn.query(topPSdampinganQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static topPSpendampingan(callback) {
        const topPSpendampinganQuery = `
            SELECT psname, COUNT(*) as jadwal_count
            FROM jadwal
            GROUP BY psname
            ORDER BY jadwal_count DESC
            LIMIT 20;
        `;
        mysqlConn.query(topPSpendampinganQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static genderdistribution(callback) {
        const distributionQuery = `
            SELECT gender, COUNT(*) as count FROM dampingan GROUP BY gender;
        `;
        mysqlConn.query(distributionQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static classdistribution(callback) {
        const distributionQuery = `
            SELECT angkatan, COUNT(*) as count FROM dampingan GROUP BY angkatan;
        `;
        mysqlConn.query(distributionQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static kampusdistribution(callback) {
        const distributionQuery = `
            SELECT kampus, COUNT(*) as count FROM dampingan GROUP BY kampus;
        `;
        mysqlConn.query(distributionQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static fakuldistribution(callback) {
        const distributionQuery = `
            SELECT fakultas, COUNT(*) as count FROM dampingan GROUP BY fakultas;
        `;
        mysqlConn.query(distributionQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static toptopics(callback) {
        const toptopicsQuery = `
            SELECT katakunci, COUNT(*) as count
            FROM dampingan
            GROUP BY katakunci
            ORDER BY count DESC
            LIMIT 10;
        `;
        mysqlConn.query(toptopicsQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static recommendedRatio(callback) {
        const recommendedRatioQuery = `
            SELECT isRecommended, COUNT(*) as count
            FROM laporan
            GROUP BY isRecommended;
        `;
        mysqlConn.query(recommendedRatioQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
}

module.exports = statistic;