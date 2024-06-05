const app = require('./app');

var routerBKUser = require('./routers/bkuser_routes');
var routerPSUser = require('./routers/psuser_routes');
var routerResetPassUser = require('./routers/resetpass_routes');
var routerDampingan = require('./routers/dampingan_routes');
const routerJadwal = require('./routers/jadwal_routes');
const routerLaporan = require('./routers/laporan_routes');
const routerDownloadReport = require('./routers/download_report_routes');
const routerStats = require('./routers/statistic_routes');

app.use('/bkusers', routerBKUser);
app.use('/psusers', routerPSUser);
app.use('/users', routerResetPassUser);
app.use('/dampingan', routerDampingan);
app.use('/jadwal', routerJadwal);
app.use('/laporan', routerLaporan);
app.use('/report', routerDownloadReport);
app.use('/stats', routerStats);

app.get('/hello', async (req, res) => {
    res.json({ message: 'Hello!' });
});

app.get('/', async (req, res) => {
    res.json({ message: 'This is Peer ITB Supervision API for BK ITB.' });
});

// Start the server
app.listen(3000, () => {
    console.log('Server running on port 3000');
});

// Exporting app is usually not necessary unless it's for testing purposes
module.exports = app;