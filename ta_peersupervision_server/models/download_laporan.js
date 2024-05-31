const PDFDocument = require('pdfkit');
const fs = require('fs');

const mysqlConn = require('../config/db');

class downloadReport {
    // Untuk Laporan
    static downloadReport(jadwalid, callback) {
        const downloadReportQuery = 'SELECT * FROM laporan WHERE jadwalid = ?;';
        mysqlConn.query(downloadReportQuery, [jadwalid], (err, result) => {
            if (err) {
                callback(err, null);
            } else {
                callback(null, result);
            }
        });
    }
}

module.exports = downloadReport;