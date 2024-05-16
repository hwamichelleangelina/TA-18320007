const { Router } = require('express');

const routerBKUser = Router();

const bkUserController = require('../controller/bkuser_controller');

routerBKUser.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for BK has been connected.');
});

routerBKUser.post('/loginBKUsers', bkUserController.loginBKUsers);
routerBKUser.post('/registerBKUsers', bkUserController.registerBKUsers);


module.exports = routerBKUser;