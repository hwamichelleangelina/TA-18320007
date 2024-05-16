const { Router } = require('express');

const routerResetPassUser = Router();

const resetPassUserController = require('../controller/resetpass_controller');

routerResetPassUser.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for reset password has been connected.');
});

routerResetPassUser.post('/verifyOldPSPassword', resetPassUserController.verifyOldPSPassword);
routerResetPassUser.put('/resetPassPS', resetPassUserController.resetPassPSUsers);
routerResetPassUser.post('/verifyOldBKPassword', resetPassUserController.verifyOldBKPassword);
routerResetPassUser.put('/resetPassBK', resetPassUserController.resetPassBKUsers);

module.exports = routerResetPassUser;