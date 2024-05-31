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

                const filename = `Laporan_${laporan.jadwalid}.pdf`;

                // Mengatur header untuk pengiriman file PDF
                res.setHeader('Content-disposition', 'attachment; filename=' + filename);
                res.setHeader('Content-type', 'application/pdf');

                doc.pipe(res);

                // Menambahkan konten ke dokumen PDF
                doc.font('TimesNewRoman')
                   .fontSize(20)
                   .text('Laporan Proses Pendampingan', { align: 'center', bold: true });
                doc.moveDown();

                doc.font('TimesNewRoman').fontSize(12).text(`ID Dampingan: ${laporan.reqid}`);
                doc.text(`Inisial Dampingan: ${laporan.initial}`);
                doc.moveDown();

                doc.text(`Pendamping Sebaya: ${laporan.psname}`);
                doc.moveDown();

                doc.text(`ID Jadwal: ${laporan.jadwalid}`);
                doc.text(`Tanggal Pelaksanaan Pendampingan: ${laporan.tanggal}`);
                doc.moveDown();

                doc.text(`Kata Kunci Masalah Dampingan: ${laporan.katakunci}`);
                doc.moveDown();
                doc.text(`Direkomendasikan untuk rujuk ke Psikolog?`, { align: 'center', bold: true, lineGap: 1.15 * 12 - 12 });
                if (laporan.isRecommended == 1) {
                    doc.fillColor('red').font('TimesNewRoman-Italic').text('REKOMENDASIKAN KE PSIKOLOG', { align: 'center', bold: true, lineGap: 1.15 * 12 - 12 });
                } else {
                    doc.fillColor('black').font('TimesNewRoman-Italic').text('TIDAK PERLU RUJUK KE PSIKOLOG', { align: 'center', bold: true, lineGap: 1.15 * 12 - 12 });
                }
                doc.font('TimesNewRoman').moveDown().moveDown();

                doc.fillColor('black').fontSize(14).text('Gambaran Permasalahan Pendampingan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.fontSize(12).text(laporan.gambaran, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown();

                doc.fontSize(14).text('Proses Pendampingan yang Dilakukan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.fontSize(12).text(laporan.proses, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown();

                doc.fontSize(14).text('Hasil Akhir dari Proses Pendampingan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.fontSize(12).text(laporan.hasil, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown();

                doc.fontSize(14).text('Kendala Selama Pendampingan', { align: 'center', bold: true, lineGap: 1.15 * 14 - 14 });
                doc.fontSize(12).text(laporan.kendala, { indent: 20, align: 'justify', lineGap: 1.15 * 12 - 12 });
                doc.moveDown().moveDown().moveDown();

                doc.fontSize(10).text(`Saya, ${laporan.psname}, pendamping sebaya yang mendampingi ${laporan.initial} dengan sadar menyatakan bahwa pengisian laporan dan rekomendasi tindak lanjut selama kegiatan pendampingan telah diberitahukan kepada ${laporan.initial} dan ${laporan.initial} secara sadar menyetujui tindakan tersebut. Apabila terdapat tindak lanjut pendampingan, dampingan telah mengizinkan akses informasi pribadi dampingan oleh psikolog dan tenaga medis terkait.`, { align: 'justify', lineGap: 1.15 * 10 - 10 });
                doc.moveDown().moveDown().moveDown().moveDown();

                const timestamp = new Date().toLocaleDateString();
                doc.fontSize(9).text(`Diunduh pada tanggal ${timestamp}`, { align: 'right' });

                doc.end();
            } else {
                res.status(404).json({ message: 'Report not found.' });
            }
        }
    });
};
