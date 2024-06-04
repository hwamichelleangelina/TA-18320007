const Statistic = require('../models/statistic');

exports.jadwalpermonth = (req, res) => {
    const year = req.params.year;
    Statistic.jadwalpermonth(year, (err, results) => {
        if (err) {
            console.error('Error checking pendampingan per month distribution:', err);
            res.status(500).send('Error pendampingan per month count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.topPSdampingan = (req, res) => {
    const year = req.params.year;
    Statistic.topPSdampingan(year, (err, results) => {
        if (err) {
            console.error('Error checking dampingan per PS distribution:', err);
            res.status(500).send('Error dampingan per PS count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.topPSpendampingan = (req, res) => {
    const year = req.params.year;
    Statistic.topPSpendampingan(year, (err, results) => {
        if (err) {
            console.error('Error checking pendampingan per PS distribution:', err);
            res.status(500).send('Error pendampingan per PS count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.distribution = (req, res) => {
    const year = req.params.year;
    Statistic.distribution(year, (err, results) => {
        if (err) {
            console.error('Error checking dampingan distribution:', err);
            res.status(500).send('Error checking dampingan distribution.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.toptopics = (req, res) => {
    const year = req.params.year;
    Statistic.toptopics(year, (err, results) => {
        if (err) {
            console.error('Error checking top topics distribution:', err);
            res.status(500).send('Error top topics count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.toptopicsByMonth = (req, res) => {
    const year = req.params.year;
    Statistic.topTopicsByMonth(year, (err, results) => {
        if (err) {
            console.error('Error checking top topics per month distribution:', err);
            res.status(500).send('Error top topics per month count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.toptopicsByMonthAllTime = (req, res) => {
    Statistic.topTopicsByMonthAllTime(year, (err, results) => {
        if (err) {
            console.error('Error checking top topics distribution:', err);
            res.status(500).send('Error top topics count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.recommendedRatio = (req, res) => {
    const year = req.params.year;
    Statistic.recommendedRatio(year, (err, results) => {
        if (err) {
            console.error('Error checking isRecommended ratio:', err);
            res.status(500).send('Error isRecommended ratio distribution.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.jadwalpermonthAllTime = (req, res) => {
    Statistic.jadwalpermonthAllTime((err, results) => {
        if (err) {
            console.error('Error checking pendampingan per month distribution:', err);
            res.status(500).send('Error pendampingan per month count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.topPSdampinganAllTime = (req, res) => {
    Statistic.topPSdampinganAllTime((err, results) => {
        if (err) {
            console.error('Error checking dampingan per PS distribution:', err);
            res.status(500).send('Error dampingan per PS count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.topPSpendampinganAllTime = (req, res) => {
    Statistic.topPSpendampinganAllTime((err, results) => {
        if (err) {
            console.error('Error checking pendampingan per PS distribution:', err);
            res.status(500).send('Error pendampingan per PS count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.distributionAllTime = (req, res) => {
    Statistic.distributionAllTime((err, results) => {
        if (err) {
            console.error('Error checking dampingan distribution:', err);
            res.status(500).send('Error checking dampingan distribution.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.potentialRujuk = (req, res) => {
    const year = req.params.year;
    Statistic.potentialrujuk(year, (err, result) => {
        if (err) {
            console.error('Error checking potentially recommended:', err);
            res.status(500).send('Error potentially recommended');
            return;
          }
        else {
            res.status(200).json(result);
        }
    });
};

exports.potentialRujukAllTime = (req, res) => {
    Statistic.potentialrujukAllTime((err, result) => {
        if (err) {
            console.error('Error checking potentially recommended:', err);
            res.status(500).send('Error potentially recommended');
            return;
          }
        else {
            res.status(200).json(result);
        }
    });
};

exports.toptopicsAllTime = (req, res) => {
    Statistic.toptopicsAllTime((err, results) => {
        if (err) {
            console.error('Error checking top topics distribution:', err);
            res.status(500).send('Error top topics count.');
            return;
        }
        res.status(200).json(results);
    });
};

exports.recommendedRatioAllTime = (req, res) => {
    Statistic.recommendedRatioAllTime((err, results) => {
        if (err) {
            console.error('Error checking isRecommended ratio:', err);
            res.status(500).send('Error isRecommended ratio distribution.');
            return;
        }
        res.status(200).json(results);
    });
};
