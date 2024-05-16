const mysql = require('mysql2');
const bcrypt = require('bcrypt');

// Koneksi ke MySQL
const mysqlConn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'supervise',
    database: 'peersupervision'
})

mysqlConn.connect(function (error) {
    if (error) {
        console.error('Error connecting to database:', err.message);
    } else {
        console.log('Connected to MySQL database: peersupervision.');
    }
});

module.exports = mysqlConn;