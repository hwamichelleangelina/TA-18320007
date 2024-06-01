const downloadReport = require('../models/download_laporan');
const PDFDocument = require('pdfkit');
const fs = require('fs');
const path = require('path');

exports.downloadReport = (req, res) => {
    const jadwalid = req.params.jadwalid; // Mendapatkan jadwalid dari parameter URL
    downloadReport.downloadReport(jadwalid, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Failed to download report.' });
        } else {
            if (result.length > 0) {
                const laporan = result[0];
                const doc = new PDFDocument();

                // Menggunakan font Times New Roman
                const timesNewRomanPath = path.join(__dirname, 'fonts', 'times new roman.ttf');
                doc.registerFont('TimesNewRoman', timesNewRomanPath);
                const timesNewRomanItalicPath = path.join(__dirname, 'fonts', 'times new roman italic.ttf');
                doc.registerFont('TimesNewRoman-Italic', timesNewRomanItalicPath);
                const timesNewRomanBoldPath = path.join(__dirname, 'fonts', 'times new roman bold.ttf');
                doc.registerFont('TimesNewRoman-Bold', timesNewRomanBoldPath);
                const timesNewRomanBoldItalicPath = path.join(__dirname, 'fonts', 'times new roman bold italic.ttf');
                doc.registerFont('TimesNewRoman-BoldItalic', timesNewRomanBoldItalicPath);

                const filename = `Laporan_${laporan.jadwalid}.pdf`;

                // Mengatur header untuk pengiriman file PDF
                res.setHeader('Content-disposition', 'attachment; filename=' + filename);
                res.setHeader('Content-type', 'application/pdf');

                doc.pipe(res);

                // Menambahkan konten ke dokumen PDF
                doc.font('TimesNewRoman-Bold')
                   .fontSize(20)
                   .text('LAPORAN PROSES PENDAMPINGAN', { align: 'center', bold: true });
                doc.moveDown();

                doc.font('TimesNewRoman').fontSize(12).text(`ID Dampingan: ${laporan.reqid}`);
                doc.text(`Inisial Dampingan: ${laporan.initial}`);
                doc.moveDown();

                doc.text(`Pendamping Sebaya: ${laporan.psname}`);
                doc.text(`NIM Pendamping Sebaya: ${laporan.psnim}`);
                doc.moveDown();

                doc.text(`ID Jadwal: ${laporan.jadwalid}`);

                function formatDateWithTimezone(date) {
                    const options = {
                        weekday: 'long',
                        day: '2-digit',
                        month: 'long',
                        year: 'numeric'
                    };
                
                    const formatter = new Intl.DateTimeFormat('id-ID', options);
                    const formattedDate = formatter.format(date);
                
                    return `${formattedDate}`;
                }
                

                doc.text(`Tanggal Pelaksanaan Pendampingan: ${formatDateWithTimezone(laporan.tanggal)}`);
                doc.moveDown();

                doc.text(`Kata Kunci Masalah Dampingan: ${laporan.katakunci}`);
                doc.moveDown();
                doc.font('TimesNewRoman-Bold').text(`Direkomendasikan untuk rujuk ke Psikolog?`, { align: 'center', bold: true, lineGap: 1.15 * 12 - 12 });
                doc.moveDown();
                if (laporan.isRecommended == 1) {
                    doc.fillColor('red').font('TimesNewRoman-BoldItalic').text('REKOMENDASIKAN KE PSIKOLOG', { align: 'center', bold: true, lineGap: 1.15 * 12 - 12 });
                } else {
                    doc.fillColor('black').font('TimesNewRoman-BoldItalic').text('TIDAK PERLU RUJUK KE PSIKOLOG', { align: 'center', bold: true, lineGap: 1.15 * 12 - 12 });
                }
                doc.font('TimesNewRoman').moveDown().moveDown();

                doc.font('TimesNewRoman-Bold').fillColor('black').fontSize(14).text('Gambaran Permasalahan Pendampingan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.font('TimesNewRoman').fontSize(12).text(laporan.gambaran, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown();

                doc.font('TimesNewRoman-Bold').fontSize(14).text('Proses Pendampingan yang Dilakukan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.font('TimesNewRoman').fontSize(12).text(laporan.proses, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown();

                doc.font('TimesNewRoman-Bold').fontSize(14).text('Hasil Akhir dari Proses Pendampingan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.font('TimesNewRoman').fontSize(12).text(laporan.hasil, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown();

                doc.font('TimesNewRoman-Bold').fontSize(14).text('Kendala Selama Pendampingan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.font('TimesNewRoman').fontSize(12).text(laporan.kendala, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown().moveDown().moveDown();

                doc.fontSize(10).text(`Saya, ${laporan.psname}, pendamping sebaya yang mendampingi ${laporan.initial} dengan sadar menyatakan bahwa pengisian laporan dan rekomendasi tindak lanjut selama kegiatan pendampingan telah diberitahukan kepada ${laporan.initial} dan ${laporan.initial} secara sadar menyetujui tindakan tersebut. Apabila terdapat tindak lanjut pendampingan, dampingan telah mengizinkan akses informasi pribadi dampingan oleh psikolog dan tenaga medis terkait.`, { align: 'justify', lineGap: 1.15 * 10 - 10 });
                doc.moveDown().moveDown().moveDown().moveDown();

                const timestamp = new Date();
                const date = `${String(timestamp.getDate()).padStart(2, '0')}/${String(timestamp.getMonth() + 1).padStart(2, '0')}/${timestamp.getFullYear()}`;
                const time = `${String(timestamp.getHours()).padStart(2, '0')}:${String(timestamp.getMinutes()).padStart(2, '0')}`;
                const timezoneOffsetInMinutes = timestamp.getTimezoneOffset();
                const timezoneOffsetInHours = Math.abs(timezoneOffsetInMinutes / 60);
                const timezoneOffsetSign = timezoneOffsetInMinutes > 0 ? '-' : '+';
                const timezone = `(GMT${timezoneOffsetSign}${String(timezoneOffsetInHours).padStart(2, '0')}:${String(Math.abs(timezoneOffsetInMinutes % 60)).padStart(2, '0')})`;
                
                const formattedTimestamp = `${date} ${time} ${timezone}`;
                doc.fontSize(9).text(`Diunduh pada tanggal ${formattedTimestamp}`, { align: 'right' });

                doc.end();
            } else {
                res.status(404).json({ message: 'Report not found.' });
            }
        }
    });
};
