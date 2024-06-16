const { Router } = require('express');

const statsController = require('../controller/statistic_controller');

const routerStats = Router();

routerStats.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Statistics has been connected.');
});

routerStats.get('/jadwalpermonth', statsController.jadwalpermonthAllTime);
routerStats.get('/topPSdampingan', statsController.topPSdampinganAllTime);
routerStats.get('/topPSpendampingan', statsController.topPSpendampinganAllTime);
//routerStats.get('/fakultas', statsController.fakuldistribution);
routerStats.get('/distribution', statsController.distributionAllTime);
//routerStats.get('/gender', statsController.genderdistribution);
//routerStats.get('/angkatan', statsController.classdistribution);
//routerStats.get('/kampus', statsController.kampusdistribution);
routerStats.get('/topTopics', statsController.toptopicsAllTime);
routerStats.get('/topTopicPairs', statsController.toptopicpairsAllTime);
routerStats.get('/recRatio', statsController.recommendedRatioAllTime);

routerStats.get('/distribution/:year', statsController.distribution);
routerStats.get('/jadwalpermonth/:year', statsController.jadwalpermonth);
routerStats.get('/topPSdampingan/:year', statsController.topPSdampingan);
routerStats.get('/topPSpendampingan/:year', statsController.topPSpendampingan);
routerStats.get('/topTopics/:year', statsController.toptopics);
routerStats.get('/topTopicPairs/:year', statsController.toptopicpairs);
routerStats.get('/recRatio/:year', statsController.recommendedRatio);

routerStats.get('/potentially/:year', statsController.potentialRujuk);
routerStats.get('/potentially', statsController.potentialRujukAllTime);

routerStats.get('/topTopicsByMonth/:year', statsController.toptopicsByMonth);
routerStats.get('/topTopicsByMonth', statsController.toptopicsByMonthAllTime);

module.exports = routerStats;