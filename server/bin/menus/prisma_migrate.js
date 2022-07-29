#!/usr/bin/env node

const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const clog = require('c-log');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const beautify = require('js-beautify').js_beautify;

execSync(`npx prisma migrate dev --name 'halo'`, { stdio: 'inherit', cwd: path.join(__dirname, '../../../server') });
