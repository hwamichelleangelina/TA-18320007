const { Router } = require('express');

const laporanController = require('../controller/laporan_controller');

const routerLaporan = Router();

routerLaporan.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database for Laporan Pendampingan has been connected.');
});

routerLaporan.post('/fillLaporan', laporanController.fillLaporan);
routerLaporan.get('/getJadwal/:psnim', laporanController.getJadwal);
routerLaporan.get('/isLaporanFilled/:jadwalid', laporanController.getLaporanFilled);
routerLaporan.get('/getLaporan', laporanController.getLaporan);
routerLaporan.get('/getLaporan/:jadwalid', laporanController.get1Laporan);

module.exports = routerLaporan;