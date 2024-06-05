'use strict';

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// Enable CORS for all origins
app.use(cors());

// Middleware to parse JSON bodies
app.use(bodyParser.json())

// Middleware to parse URL-encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));

module.exports = app;