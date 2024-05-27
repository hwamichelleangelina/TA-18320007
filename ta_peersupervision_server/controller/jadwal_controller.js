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

exports.deleteJadwal = (req, res) => {
    const jadwalid = req.params.jadwalid;

    jadwal.deleteJadwal(jadwalid, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to delete jadwal.' });
        } else {
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Jadwal deleted successfully.' });
            } else {
                res.status(404).json({ message: 'Jadwal not found.' });
            }
        }
    });
};

exports.getJadwal = (req, res) => {
    const psnim = req.params.psnim; // Mendapatkan reqid dari parameter URL
    jadwal.getJadwal(psnim, (err, jadwal) => {
        if (err) {
            res.status(500).json({ message: 'Failed to get schedule.' });
        } else {
            if (jadwal.length > 0) {
                res.status(200).json({ message: 'Successfully retrieved schedule.', jadwal });
            } else {
                res.status(404).json({ message: 'Schedule not found.' });
            }
        }
    });
};

exports.createJadwal = (req, res) => {
    const { reqid, tanggal, mediapendampingan } = req.body;

    // Persiapkan data untuk dimasukkan ke dalam model
    const jadwalData = {
        reqid,
        tanggal,
        mediapendampingan
    };

    jadwal.createJadwal(jadwalData, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to create jadwal pendampingan.', error: err });
        } else {
            if (result.affectedRows > 0) {
                res.status(201).json({ message: 'Jadwal pendampingan created successfully.' });
            } else {
                res.status(404).json({ message: 'User not found or no rows affected.' });
            }
        }
    });
};