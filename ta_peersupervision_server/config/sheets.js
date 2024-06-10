const fs = require('fs');
const { google } = require('googleapis');
const express = require('express');
const mysqlConn = require('../config/db');

const app = express();
const PORT = 3000;

// Load client secrets from a local file.
fs.readFile('credentials.json', (err, content) => {
  if (err) return console.log('Error loading client secret file:', err);
  authorize(JSON.parse(content), listData);
});

function authorize(credentials, callback) {
  const { client_secret, client_id, redirect_uris } = credentials.installed;
  const oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);

  fs.readFile('token.json', (err, token) => {
    if (err) return getAccessToken(oAuth2Client, callback);
    oAuth2Client.setCredentials(JSON.parse(token));
    callback(oAuth2Client);
  });
}

function getAccessToken(oAuth2Client, callback) {
  const authUrl = oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: ['https://www.googleapis.com/auth/spreadsheets.readonly'],
  });
  console.log('Authorize this app by visiting this url:', authUrl);
  // Implementasikan kode untuk membuka browser dan meminta pengguna memasukkan kode otorisasi
}

function listData(auth) {
  const sheets = google.sheets({ version: 'v4', auth });
  const spreadsheetId = '12eujA0Wvh0hsiEGo0-MhXyekW79qylH-lnRZCloYn28';
  const range = 'Form responses 1!B:AD'; // Ambil data dari kolom B sampai AD

  sheets.spreadsheets.values.get({ spreadsheetId, range }, (err, res) => {
    if (err) return console.log('The API returned an error: ' + err);
    const rows = res.data.values;
    if (rows.length) {
      const header = rows[0];
      const filteredRows = rows.slice(1).filter(row => {
        const indexOfColumn = header.indexOf('Apa kamu mau dikontak atau didengerin langsung terkait cerita unek2 kamu?');
        const answer = row[indexOfColumn];
        return answer !== 'Tidak';
      });

      if (filteredRows.length) {
        const query = 'INSERT INTO dampingan (initial, gender, fakultas, angkatan, tingkat, mediakontak, kontak) VALUES ?';
        const values = filteredRows.map(row => [
          row[header.indexOf('Kalau boleh tahu namanya siapa? (Anonim boleh)')], // Mapping column to initial
          row[header.indexOf('Jenis kelamin')],
          row[header.indexOf('Fakultas / Sekolah apaa?')],
          row[header.indexOf('Angkatan berapa nih kalau boleh tau??')],
          row[header.indexOf('Kamu tingkat sarjana / pascasarjana ya?')],
          row[header.indexOf('Boleh minta no HP/email/apapun yang bisa kami hubungi?? (harus sinkron sama yang pertanyaan diatas)\n\nKesalahan menulis kontak akan mempersulit kami untuk menghubungi anda~\n\n*Pastikan ulang NOMOR atau KONTAK yang dihubungi SUDAH BENAR')]
        ]);
        mysqlConn.query(query, [values], (error) => {
          if (error) throw error;
          console.log('Data inserted into MySQL');
        });
      }
    } else {
      console.log('No data found.');
    }
  });
}

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});