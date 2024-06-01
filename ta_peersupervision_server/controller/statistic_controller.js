const statistic = require('../models/statistic');

exports.jadwalpermonth = (req, res) => {
    statistic.jadwalpermonth((err, results) => {
        if (err) {
            console.error('Error checking pendampingan per month distribution:', err);
            res.status(500).send('Error pendampingan per month count.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.topPSdampingan = (req, res) => {
    statistic.topPSdampingan((err, results) => {
        if (err) {
            console.error('Error checking dampingan per PS distribution:', err);
            res.status(500).send('Error dampingan per PS count.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.topPSpendampingan = (req, res) => {
    statistic.topPSpendampingan((err, results) => {
        if (err) {
            console.error('Error checking pendampingan per PS distribution:', err);
            res.status(500).send('Error pendampingan per PS count.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.fakuldistribution = (req, res) => {
    statistic.fakuldistribution((err, results) => {
        if (err) {
            console.error('Error checking fakultas dampingan distribution:', err);
            res.status(500).send('Error fakultas dampingan distribution.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.genderdistribution = (req, res) => {
    statistic.genderdistribution((err, results) => {
        if (err) {
            console.error('Error checking gender dampingan distribution:', err);
            res.status(500).send('Error gender dampingan distribution.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.classdistribution = (req, res) => {
    statistic.classdistribution((err, results) => {
        if (err) {
            console.error('Error checking angkatan dampingan distribution:', err);
            res.status(500).send('Error angkatan dampingan distribution.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.kampusdistribution = (req, res) => {
    statistic.kampusdistribution((err, results) => {
        if (err) {
            console.error('Error checking kampus dampingan distribution:', err);
            res.status(500).send('Error kampus dampingan distribution.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.toptopics = (req, res) => {
    statistic.toptopics((err, results) => {
        if (err) {
            console.error('Error checking top topics distribution:', err);
            res.status(500).send('Error top topics count.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};

exports.recommendedRatio = (req, res) => {
    statistic.recommendedRatio((err, results) => {
        if (err) {
            console.error('Error checking isRecommended ratio:', err);
            res.status(500).send('Error isRecommended ratio distribution.');
            return;
          }
        else {
            res.status(200).json(results);
        }
    });
};