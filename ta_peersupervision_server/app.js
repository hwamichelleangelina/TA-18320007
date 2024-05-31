'use strict';

var bodyParser = require('body-parser');
var express = require('express');
// const { request } = require('../appserver/node_modules/undici-types/api');

const PDFDocument = require('pdfkit');
const fs = require('fs');
const cors = require('cors'); // Mengizinkan semua asal (cors())

var app = express();

app.use(cors()); 
app.get('/hello', async (req, res) => {
    res.json({message: 'Hello!'})
})

app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}))

// applications
var urlencodedParser = bodyParser.urlencoded({extended: false});

module.exports = app;