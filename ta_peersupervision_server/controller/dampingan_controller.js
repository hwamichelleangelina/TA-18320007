const dampingan = require('../models/dampingan');

exports.getDampingan = (req, res) => {
    const psnim = req.params.psnim; // Mendapatkan reqid dari parameter URL
    dampingan.getDampingan(psnim, (err, dampingan) => {
        if (err) {
            res.status(500).json({ message: 'Failed to get dampingan.' });
        } else {
            if (dampingan.length > 0) {
                res.status(200).json({ message: 'Successfully retrieved dampingan.', dampingan });
            } else {
                res.status(404).json({ message: 'Dampingan not found.' });
            }
        }
    });
};

exports.getAllDampingan = (req, res) => {
    dampingan.getAllDampingan((err, results) => {
        if (err) {
            res.status(500).json({ error: 'Database error' });
        } else {
            res.status(200).json(results);
        }
    });
};


exports.updateDataDampingan = (req, res) => {
    const { reqid, newData } = req.body;

    dampingan.updateDataDampingan(reqid, newData, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to update dampingan.' });
        } else {
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Dampingan Data updated successfully.', newData });
            } else {
                res.status(404).json({ message: 'Dampingan not found.' });
            }
        }
    });
};

exports.updateDampinganTanggal = (req, res) => {
    const { reqid, newTanggal } = req.body; // Ambil tanggal baru dari body request

    dampingan.updateDampinganTanggal(reqid, newTanggal, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to update tanggal dampingan.' });
        } else {
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Tanggal dampingan updated successfully.', newTanggal });
            } else {
                res.status(404).json({ message: 'Dampingan not found.' });
            }
        }
    });
};

exports.deleteDampingan = (req, res) => {
    const reqid = req.params.reqid;

    dampingan.deleteDampingan(reqid, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to delete dampingan.' });
        } else {
            if (result.affectedRows > 0) {
                res.status(200).json({ message: 'Dampingan deleted successfully.' });
            } else {
                res.status(404).json({ message: 'Dampingan not found.' });
            }
        }
    });
};

exports.createDampingan = (req, res) => {
    const { initial, fakultas, gender, angkatan, kampus, mediakontak, kontak, katakunci, sesi, tanggal, psname } = req.body;

    // Persiapkan data untuk dimasukkan ke dalam model
    const dampinganData = {
        initial,
        fakultas,
        gender,
        angkatan,
        kampus,
        mediakontak,
        kontak,
        katakunci,
        sesi,
        tanggal,
        psname
    };

    dampingan.createDampingan(dampinganData, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to create dampingan.', error: err });
        } else {
            if (result.affectedRows > 0) {
                res.status(201).json({ message: 'Dampingan created successfully.' });
            } else {
                res.status(404).json({ message: 'User not found or no rows affected.' });
            }
        }
    });
};

exports.getCountPendampingan = (req, res) => {
    const reqid = req.params.reqid;

    dampingan.getCountPendampingan(reqid, (err, result) => {
        if (err) {
            console.error('Error checking pertemuan:', err);
            res.status(500).send('Error checking pertemuan');
            return;
          }
          const hasMeeting = result[0].count > 0;
          res.json({ hasMeeting });
    });
};