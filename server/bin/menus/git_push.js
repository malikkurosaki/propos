#!/usr/bin/env node

const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const clog = require('c-log');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const { exec } = require('child_process');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const beautify = require('js-beautify').js_beautify;


; (async () => {
    // find current branch
    const branch = execSync('git rev-parse --abbrev-ref HEAD').toString().trim();

    console.log(branch)

})();


// execSync(`git add . && git commit -m "auto commit && git push"`);