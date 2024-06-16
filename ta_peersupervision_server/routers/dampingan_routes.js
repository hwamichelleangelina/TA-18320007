const { Router } = require('express');

const dampinganController = require('../controller/dampingan_controller');

const routerDampingan = Router();

routerDampingan.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for Dampingan has been connected.');
});

routerDampingan.put('/updateDampingan/:reqid', dampinganController.updateDataDampingan);
routerDampingan.get('/getDampingan/:psnim', dampinganController.getDampingan);
routerDampingan.get('/getDampingan/', dampinganController.getAllDampingan);
routerDampingan.get('/getNoPSDampingan/', dampinganController.getNoPSDampingan);
routerDampingan.post('/createDampingan', dampinganController.createDampingan);
routerDampingan.delete('/deleteDampingan/:reqid', dampinganController.deleteDampingan);
routerDampingan.get('/countPendampingan/:reqid', dampinganController.getCountPendampingan);

module.exports = routerDampingan;
