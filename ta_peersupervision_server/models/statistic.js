const mysqlConn = require('../config/db');

class Statistic {
    // Per tahun data
    static jadwalpermonth(year, callback) {
        const jadwalpermonthQuery = `
        SELECT DATE_FORMAT(tanggal, '%Y-%m') as month, COUNT(*) as count
        FROM jadwal
        WHERE YEAR(tanggal) = ?
        GROUP BY month
        ORDER BY month;
      `;
        mysqlConn.query(jadwalpermonthQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
    
    static topPSdampingan(year, callback) {
        const topPSdampinganQuery = `
            SELECT psname, COUNT(*) as dampingancount
            FROM dampingan
            WHERE YEAR(dampinganadded) = ?
            GROUP BY psname
            ORDER BY dampingancount DESC
            LIMIT 20;
        `;
        mysqlConn.query(topPSdampinganQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
    
    static topPSpendampingan(year, callback) {
        const topPSpendampinganQuery = `
            SELECT psname, COUNT(*) as jadwalcount
            FROM jadwal
            WHERE YEAR(jadwaladded) = ?
            GROUP BY psname
            ORDER BY jadwalcount DESC
            LIMIT 20;
        `;
        mysqlConn.query(topPSpendampinganQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
    
    static distribution(year, callback) {
        const results = {};
    
        const sqlFakultas = 'SELECT fakultas, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY fakultas;';
        const sqlKampus = 'SELECT kampus, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY kampus;';
        const sqlAngkatan = 'SELECT angkatan, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY angkatan;';
        const sqlGender = 'SELECT gender, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY gender;';
    
        mysqlConn.query(sqlFakultas, [year], (err, fakultasResults) => {
            if (err) {
                return callback(err, null);
            }
            results.fakultas = fakultasResults;
            mysqlConn.query(sqlKampus, [year], (err, kampusResults) => {
                if (err) {
                    return callback(err, null);
                }
                results.kampus = kampusResults;
                mysqlConn.query(sqlAngkatan, [year], (err, angkatanResults) => {
                    if (err) {
                        return callback(err, null);
                    }
                    results.angkatan = angkatanResults;
                    mysqlConn.query(sqlGender, [year], (err, genderResults) => {
                        if (err) {
                            return callback(err, null);
                        }
                        results.gender = genderResults;
                        callback(null, results);
                    });
                });
            });
        });
    }
    
    static toptopics(year, callback) {
        const toptopicsQuery = `
            SELECT katakunci, COUNT(*) as count
            FROM dampingan
            WHERE YEAR(dampinganadded) = ?
            GROUP BY katakunci
            ORDER BY count DESC
            LIMIT 10;
        `;
        mysqlConn.query(toptopicsQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static topTopicsByMonth(year, callback) {
        const topTopicsByMonthQuery = `
            SELECT 
                katakunci, 
                MONTH(tanggal) as month, 
                COUNT(*) as count
            FROM jadwal
            WHERE YEAR(tanggal) = ?
            GROUP BY katakunci, month
            ORDER BY month ASC, count DESC;
        `;
        mysqlConn.query(topTopicsByMonthQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static topTopicsByMonthAllTime(year, callback) {
        const topTopicsByMonthQuery = `
            SELECT 
                katakunci, 
                MONTH(tanggal) as month, 
                COUNT(*) as count
            FROM jadwal
            GROUP BY katakunci, month
            ORDER BY month ASC, count DESC;
        `;
        mysqlConn.query(topTopicsByMonthQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
    
    static recommendedRatio(year, callback) {
        const recommendedRatioQuery = `
            SELECT isRecommended, COUNT(*) as count
            FROM laporan
            WHERE YEAR(laporanadded) = ?
            GROUP BY isRecommended;
        `;
        mysqlConn.query(recommendedRatioQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
   
    static potentialrujuk(year, callback) {
        const potentiallyQuery = `
                SELECT
                katakunci,
                reqid,
                initial,
                COUNT(*) AS count
            FROM jadwal
            WHERE YEAR(jadwaladded) = ?
            GROUP BY initial, katakunci, reqid
            ORDER BY count DESC;
        `;
        mysqlConn.query(potentiallyQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static potentialrujukAllTime(callback) {
        const potentiallyQuery = `
                SELECT
                katakunci,
                reqid,
                initial,
                COUNT(*) AS count
            FROM jadwal
            GROUP BY initial, katakunci, reqid
            ORDER BY count DESC;
        `;
        mysqlConn.query(potentiallyQuery, (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }


    // Untuk Laporan
    static jadwalpermonthAllTime(callback) {
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

    static topPSdampinganAllTime(callback) {
        const topPSdampinganQuery = `
            SELECT psname, COUNT(*) as dampingancount
            FROM dampingan
            GROUP BY psname
            ORDER BY dampingancount DESC
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

    static topPSpendampinganAllTime(callback) {
        const topPSpendampinganQuery = `
            SELECT psname, COUNT(*) as jadwalcount
            FROM jadwal
            GROUP BY psname
            ORDER BY jadwalcount DESC
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

    static distributionAllTime(callback) {
        const results = {};
    
        const sqlFakultas = 'SELECT fakultas, COUNT(*) as count FROM dampingan GROUP BY fakultas;';
        const sqlKampus = 'SELECT kampus, COUNT(*) as count FROM dampingan GROUP BY kampus;';
        const sqlAngkatan = 'SELECT angkatan, COUNT(*) as count FROM dampingan GROUP BY angkatan;';
        const sqlGender = 'SELECT gender, COUNT(*) as count FROM dampingan GROUP BY gender;';
    
        mysqlConn.query(sqlFakultas, (err, fakultasResults) => {
            if (err) {
                return callback(err, null);
            }
            results.fakultas = fakultasResults;
            mysqlConn.query(sqlKampus, (err, kampusResults) => {
                if (err) {
                    return callback(err, null);
                }
                results.kampus = kampusResults;
                mysqlConn.query(sqlAngkatan, (err, angkatanResults) => {
                    if (err) {
                        return callback(err, null);
                    }
                    results.angkatan = angkatanResults;
                    mysqlConn.query(sqlGender, (err, genderResults) => {
                        if (err) {
                            return callback(err, null);
                        }
                        results.gender = genderResults;
                        callback(null, results);
                    });
                });
            });
        });
    }

    static toptopicsAllTime(callback) {
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

    static recommendedRatioAllTime(callback) {
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
/*    
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
    }*/
}

module.exports = Statistic;