const express = require('express');
const { Login } = require('./controller/login');
const api = express.Router();


api.post('/login', Login);

module.exports = {api}