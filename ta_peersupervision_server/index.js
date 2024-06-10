const app = require('./app');
const { google } = require('googleapis');

var routerBKUser = require('./routers/bkuser_routes');
var routerPSUser = require('./routers/psuser_routes');
var routerResetPassUser = require('./routers/resetpass_routes');
var routerDampingan = require('./routers/dampingan_routes');
const routerJadwal = require('./routers/jadwal_routes');
const routerLaporan = require('./routers/laporan_routes');
const routerDownloadReport = require('./routers/download_report_routes');
const routerStats = require('./routers/statistic_routes');

const { listData } = require('./config/sheets'); // Ubah lokasi file sheets.js sesuai struktur proyek Anda

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

/*
function authorize(credentials, callback) {
    const { client_secret, client_id, redirect_uris } = credentials.installed;
    const oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);

    fs.readFile('token.json', (err, token) => {
        if (err) return getAccessToken(oAuth2Client, callback);
        oAuth2Client.setCredentials(JSON.parse(token));
        listData(oAuth2Client); // Panggil listData setelah otentikasi berhasil
    });
}

const cron = require('node-cron');

// Menjadwalkan eksekusi listData setiap 1 jam
cron.schedule('0 * * * *', () => {
    console.log('Running listData every hour');
    authorize(credentials, listData); // Panggil authorize dengan callback listData
});*/

// Start the server
app.listen(3000, () => {
    console.log('Server running on port 3000');
});

// Exporting app is usually not necessary unless it's for testing purposes
module.exports = app;