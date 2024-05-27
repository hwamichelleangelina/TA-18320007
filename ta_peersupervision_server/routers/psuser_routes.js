const { Router } = require('express');

const routerPSUser = Router();

const psUserController = require('../controller/psuser_controller');

routerPSUser.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for PS has been connected.');
});

routerPSUser.post('/loginPSUsers', psUserController.loginPSUsers);

// UNTUK ADMIN BK EDIT ANGGOTA PS
routerPSUser.post('/registerPSUsers', psUserController.registerPSUsers);
routerPSUser.delete('/deletePSUsers', psUserController.deletePSUsers);
routerPSUser.put('/updatePSUsers', psUserController.updatePSUsers);
routerPSUser.put('/nonActivateUsers', psUserController.nonActiveUsers);
routerPSUser.get('/getAllPSUsers', psUserController.getAllPSUsers);
routerPSUser.get('/getNAUsers', psUserController.getNAPSUsers);
routerPSUser.get('/getActivePS', psUserController.getActivePS);

//frekuensi pendampingan dilakukan
routerPSUser.get('/countPSDone', psUserController.countPSdone);
routerPSUser.get('/countPSDampinganDone', psUserController.countPSDampingandone);

module.exports = routerPSUser;