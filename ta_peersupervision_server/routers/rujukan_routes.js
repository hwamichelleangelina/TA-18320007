const { Router } = require('express');

const routerRujukan = Router();

const rujukanController = require('../controller/rujukan_controller');

routerRujukan.get('/', (req, res) => {
    res.status(200).json('Database for Rujukan has been connected.');
});

routerRujukan.post('/createRujukan/:reqid', rujukanController.createRujukan);
routerRujukan.get('/getRujukan', rujukanController.getRujukan);
routerRujukan.put('/updateRujukan/:reqid', rujukanController.updateRujukan);

module.exports = routerRujukan;