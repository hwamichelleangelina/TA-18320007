const mysql = require('mysql2');

// Koneksi ke MySQL
const mysqlConn = mysql.createConnection({
    host: 'bmxbqqk9rwqua9c5j7co-mysql.services.clever-cloud.com',
    user: 'u8gsfi6oxjcwhcws',
    password: 'OJiRLKJQbv2ZNILo7qZs',
    database: 'bmxbqqk9rwqua9c5j7co'
})

mysqlConn.connect(function (error) {
    if (error) {
        console.error('Error connecting to database:', err.message);
    } else {
        console.log('Connected to MySQL database: peersupervision.');
    }
});

module.exports = mysqlConn;