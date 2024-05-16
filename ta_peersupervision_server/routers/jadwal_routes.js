const { Router } = require('express');

const jadwalController = require('../controller/jadwal_controller');

const routerJadwal = Router();

routerJadwal.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for Jadwal Pendampingan has been connected.');
});

routerJadwal.get('/getJadwal/', jadwalController.getAllJadwal);

module.exports = routerJadwal;