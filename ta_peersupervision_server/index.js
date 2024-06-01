const app = require('./app');
const cors = require('cors');

// Settings
app.set('port', process.env.PORT || 3000);

// Routers
// var userBKRouter = require('./routers/bkusers_routes');
// app.use('/bkusers', userBKRouter);

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

app.listen(app.get('port'), () => {
    console.log('Server is on port', app.get('port'));
})