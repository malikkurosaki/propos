#!/usr/bin/env node
const args = process.argv.slice(2);
const dir = args[0];
const fetch = require(dir+'/cross-fetch');
const uuid = require(dir+'/uuid');

console.log(uuid.v4());
