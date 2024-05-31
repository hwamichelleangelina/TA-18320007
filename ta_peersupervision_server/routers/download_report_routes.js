const { Router } = require('express');

const downloadReportController = require('../controller/download_laporan_controller');

const routerDownloadReport = Router();

routerDownloadReport.post('/', (req, res) => {
    res.status(200).json('Server on Port 3000 and Database to download Report has been connected.');
});

routerDownloadReport.get('/download/:jadwalid', downloadReportController.downloadReport);

module.exports = routerDownloadReport;