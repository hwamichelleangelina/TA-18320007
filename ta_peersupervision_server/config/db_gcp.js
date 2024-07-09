const mysql = require('mysql2');

// Fungsi untuk membuat koneksi MySQL
function createMySQLConnection() {
    const connection = mysql.createConnection({
        host: '127.0.0.1',
        user: 'root',
        password: 'supervise',
        database: 'peersupervision',
    });

    connection.connect(function (error) {
        if (error) {
            console.error('Error connecting to database:', error.message);
            setTimeout(createMySQLConnection, 5000); // Coba ulang setelah 5 detik
        } else {
            console.log('Connected to MySQL database: peersupervision.');
        }
    });

    connection.on('error', function (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection lost. Reconnecting...');
            createMySQLConnection();
        } else {
            throw err;
        }
    });

    return connection;
}

const mysqlConn = createMySQLConnection();

module.exports = mysqlConn;
