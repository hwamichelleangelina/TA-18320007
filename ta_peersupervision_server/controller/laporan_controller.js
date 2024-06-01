const laporan = require('../models/laporan');

exports.getJadwal = (req, res) => {
    const psnim = req.params.psnim; // Mendapatkan reqid dari parameter URL
    laporan.getJadwal(psnim, (err, laporan) => {
        if (err) {
            res.status(500).json({ message: 'Failed to get schedule.' });
        } else {
            if (laporan.length > 0) {
                res.status(200).json({ message: 'Successfully retrieved schedule for reports.', laporan });
            } else {
                res.status(404).json({ message: 'Schedule not found.' });
            }
        }
    });
};

exports.getKatakunci = (req, res) => {
    const reqid = req.params.reqid; // Mendapatkan reqid dari parameter URL
    laporan.getKatakunci(reqid, (err, katakunci) => {
        if (err) {
            res.status(500).json({ message: 'Failed to get katakunci.' });
        } else {
            if (katakunci.length > 0) {
                res.status(200).json({ message: 'Successfully retrieved katakunci.', katakunci });
            } else {
                res.status(404).json({ message: 'Reqid not found.' });
            }
        }
    });
};

exports.fillLaporan = (req, res) => {
    const { jadwalid, isRecommended, gambaran, proses, hasil, kendala, isAgree } = req.body;

    // Persiapkan data untuk dimasukkan ke dalam model
    const laporanData = {
        jadwalid,
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

exports.getLaporanFilled = (req, res) => {
    const jadwalid = req.params.jadwalid;

    laporan.getLaporanFilled(jadwalid, (err, result) => {
        if (err) {
            console.error('Error checking laporan filled:', err);
            res.status(500).send('Error checking laporan filled');
            return;
          }
          const hasReported = result[0].count > 0;
          res.json({ hasReported });
    });
};


// Untuk list laporan pendampinan ditampilkan khusus kepada BK ITB
exports.getLaporan = (req, res) => {

    laporan.getLaporan((err, reportlist) => {
        if (err) {
            res.status(500).json({ message: 'Failed to get report list.' });
        } else {
            if (reportlist.length > 0) {
                res.status(200).json({ message: 'Successfully retrieved report list.', reportlist });
            } else {
                res.status(404).json({ message: 'Reports not found.' });
            }
        }
    });
};

exports.get1Laporan = (req, res) => {
    const jadwalid = req.params.jadwalid;

    laporan.get1Laporan(jadwalid, (err, report) => {
        if (err) {
            res.status(500).json({ message: 'Failed to get report list.' });
        } else {
            if (report.length > 0) {
                res.status(200).json({ message: 'Successfully retrieved report.', report });
            } else {
                res.status(404).json({ message: 'Reports not found.' });
            }
        }
    });
};