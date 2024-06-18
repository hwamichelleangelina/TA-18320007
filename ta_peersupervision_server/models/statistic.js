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
            WHERE YEAR(dampinganadded) = ? AND psname IS NOT NULL
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
    
        const sqlFakultas = 'SELECT IFNULL(fakultas, "Prefer not to say") as fakultas, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY fakultas;';
        const sqlKampus = 'SELECT IFNULL(kampus, "Prefer not to say") as kampus, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY kampus;';
        const sqlAngkatan = 'SELECT IFNULL(angkatan, "Prefer not to say") as angkatan, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY angkatan;';
        const sqlGender = 'SELECT IFNULL(gender, "Prefer not to say") as gender, COUNT(*) as count FROM dampingan WHERE YEAR(dampinganadded) = ? GROUP BY gender;';
    
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
            WHERE YEAR(dampinganadded) = ? AND katakunci IS NOT NULL
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

    static toptopicpairs(year, callback) {
        const toptopicpairsQuery = `
            SELECT katakunci, katakunci2, COUNT(*) as count
            FROM dampingan
            WHERE katakunci IS NOT NULL AND katakunci2 IS NOT NULL AND YEAR(dampinganadded) = ?
            GROUP BY katakunci, katakunci2
            ORDER BY count DESC
        `;
        mysqlConn.query(toptopicpairsQuery, [year], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static toptopicpairsAllTime(year, callback) {
        const toptopicpairsQuery = `
            SELECT katakunci, katakunci2, COUNT(*) as count
            FROM dampingan
            WHERE katakunci IS NOT NULL AND katakunci2 IS NOT NULL
            GROUP BY katakunci, katakunci2
            ORDER BY count DESC
        `;
        mysqlConn.query(toptopicpairsQuery, [year], (err, result) => {
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
            SELECT isRujukanNeed, COUNT(*) as count
            FROM rujukan
            WHERE YEAR(rujukanadded) = ?
            GROUP BY isRujukanNeed;
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
                jadwal.katakunci,
                jadwal.reqid,
                jadwal.initial,
                COUNT(*) AS count
            FROM jadwal
            JOIN rujukan ON jadwal.reqid = rujukan.reqid
            WHERE YEAR(jadwal.jadwaladded) = ?
            AND rujukan.isRujukanNeed = 0
            GROUP BY jadwal.initial, jadwal.katakunci, jadwal.reqid
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
            WHERE psname IS NOT NULL
            GROUP BY psname
            ORDER BY dampingancount DESC
            LIMIT 70;
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
            LIMIT 70;
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
    
        const sqlFakultas = 'SELECT IFNULL(fakultas, "Prefer not to say") as fakultas, COUNT(*) as count FROM dampingan GROUP BY fakultas;';
        const sqlKampus = 'SELECT IFNULL(kampus, "Prefer not to say") as kampus, COUNT(*) as count FROM dampingan GROUP BY kampus;';
        const sqlAngkatan = 'SELECT IFNULL(angkatan, "Prefer not to say") as angkatan, COUNT(*) as count FROM dampingan GROUP BY angkatan;';
        const sqlGender = 'SELECT IFNULL(gender, "Prefer not to say") as gender, COUNT(*) as count FROM dampingan GROUP BY gender;';
    
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
            WHERE katakunci IS NOT NULL
            GROUP BY katakunci
            ORDER BY count DESC
            LIMIT 15;
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
            SELECT isRujukanNeed, COUNT(*) as count
            FROM rujukan
            GROUP BY isRujukanNeed;
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