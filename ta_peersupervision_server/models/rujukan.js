const mysqlConn = require('../config/db');

class rujukan {
    static createRujukan(initial, callback) {
        const createRujukanQuery = `
        INSERT INTO rujukan (reqid, initial, isRujukanNeed)
        VALUES (?, (SELECT initial FROM dampingan WHERE reqid = ?), 0);
        `;
    
        mysqlConn.query(createRujukanQuery, [
            reqid, reqid
        ], (err, result) => {
            if (err) {
                console.error('Error creating rujukan:', err);
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }

    static getRujukan(callback) {
        const rujukanQuery = 'SELECT * FROM rujukan;';
        mysqlConn.query(rujukanQuery, (err, results) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, results);
            }
        });
    }

    static updateRujukan(reqid, isRujukanNeed, callback) {
        const updateRujukquery = 'UPDATE rujukan SET isRujukanNeed = ? WHERE reqid = ?;';
        mysqlConn.query(updateRujukquery, [isRujukanNeed, reqid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                // If the update operation is successful, result contains information about the number of rows affected
                if (result.affectedRows > 0) {
                    callback(null, true); // Successfully updated
                } else {
                    callback(null, false); // No rows affected, maybe the data was not found
                }
            }
        });
    }
}

module.exports = rujukan;