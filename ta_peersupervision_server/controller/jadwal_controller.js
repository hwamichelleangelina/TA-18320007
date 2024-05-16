const jadwal = require('../models/jadwal');

exports.getAllJadwal = (req, res) => {
    jadwal.getAllJadwal((err, results) => {
        if (err) {
            res.status(500).json({ error: 'Database error' });
        } else {
            res.status(200).json(results);
        }
    });
};