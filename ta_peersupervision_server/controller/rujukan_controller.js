const rujukan= require('../models/rujukan');

exports.createRujukan = (req, res) => {
    const reqid = req.params.reqid;

    rujukan.createRujukan(reqid, (err, rujuk) => {
        if (err) {
            res.status(500).json({message: 'Rujukan failed created.'});
        }
        else if (rujuk) {
            res.status(200).json({message: 'Rujukan successfully created.', rujuk});
        }
        else {
            res.status(401).json({message: 'Rujukan failed to create. Please try again.'});
        }
    });
}

exports.updateRujukan = (req, res) => {
    const reqid = req.params.reqid;
    const isRujukanNeed = req.body.isRujukanNeed;

    rujukan.updateRujukan(reqid, isRujukanNeed, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error while updating rujukan.' });
        } else {
            if (result) {
                res.status(200).json({ message: 'Rujukan successfully updated.' });
            } else {
                res.status(404).json({ message: 'Rujukan not found.' });
            }
        }
    });
}

exports.getRujukan = (req, res) => {
    rujukan.getRujukan((err, results) => {
        if (err) {
            res.status(500).json({ error: 'Database error' });
        } else {
            res.status(200).json(results);
        }
    });
}