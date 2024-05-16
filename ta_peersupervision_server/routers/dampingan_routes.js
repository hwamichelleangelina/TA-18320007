const { Router } = require('express');

const dampinganController = require('../controller/dampingan_controller');

const routerDampingan = Router();

routerDampingan.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for Dampingan has been connected.');
});

routerDampingan.put('/:updateDampinganTanggal', dampinganController.updateDampinganTanggal);
routerDampingan.put('/:updateDataDampingan', dampinganController.updateDataDampingan);
routerDampingan.get('/getDampingan/:psnim', dampinganController.getDampingan);
routerDampingan.get('/getDampingan/', dampinganController.getAllDampingan);
routerDampingan.post('/importDampingan', dampinganController.importDampingan);
routerDampingan.delete('/:deleteDampingan', dampinganController.deleteDampingan);

module.exports = routerDampingan;
