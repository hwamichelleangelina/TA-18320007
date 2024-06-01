const { Router } = require('express');

const statsController = require('../controller/statistic_controller');

const routerStats = Router();

routerStats.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Statistics has been connected.');
});

routerStats.get('/jadwalpermonth', statsController.jadwalpermonth);
routerStats.get('/topPSdampingan', statsController.topPSdampingan);
routerStats.get('/topPSpendampingan', statsController.topPSpendampingan);
routerStats.get('/fakultas', statsController.fakuldistribution);
routerStats.get('/gender', statsController.genderdistribution);
routerStats.get('/angkatan', statsController.classdistribution);
routerStats.get('/kampus', statsController.kampusdistribution);
routerStats.get('/topTopics', statsController.toptopics);
routerStats.get('/recRatio', statsController.recommendedRatio);

module.exports = routerStats;