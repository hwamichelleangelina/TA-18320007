const express = require('express');
const pool = require('./db');
const router = express.Router();

// Get room data
router.get('/', async (req, res) => {
  try {
    res.status(200).json({ message: 'Database Ganecare has been connected.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
// Get room data
router.get('/rooms', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT idRoom, roomStatus, idConselor, createdAtRoom FROM room');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get users data
router.get('/users', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT id, ina_id, gender, role FROM users');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get gender and role comparison
router.get('/gender-role-comparison', async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT role, gender, COUNT(*) as count
      FROM users
      GROUP BY role, gender
    `);
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get role comparison
router.get('/role-comparison', async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT role, COUNT(*) as count
      FROM users
      GROUP BY role
    `);
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get ina_id ranking
router.get('/ina-id-ranking', async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT u.ina_id, COUNT(r.idConselor) as frequency
      FROM room r
      JOIN users u ON r.idConselor = u.id
      GROUP BY u.ina_id
      ORDER BY frequency DESC
    `);
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;