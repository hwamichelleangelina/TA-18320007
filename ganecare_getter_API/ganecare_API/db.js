const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root', 
  password: 'supervise',
  database: 'ganecare'
});

module.exports = pool;
