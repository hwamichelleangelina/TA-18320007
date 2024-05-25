const laporan = require('../models/laporan');

exports.fillLaporan = (req, res) => {
    const { jadwalid, reqid, isRecommended, gambaran, proses, hasil, kendala, isAgree } = req.body;

    // Persiapkan data untuk dimasukkan ke dalam model
    const laporanData = {
        jadwalid,
        reqid,
        isRecommended,
        gambaran,
        proses,
        hasil,
        kendala,
        isAgree
    };

    laporan.fillLaporan(laporanData, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to fill laporan pendampingan.', error: err });
        } else {
            if (result.affectedRows > 0) {
                res.status(201).json({ message: 'Laporan pendampingan created successfully.' });
            } else {
                res.status(404).json({ message: 'User not found or no rows affected.' });
            }
        }
    });
};