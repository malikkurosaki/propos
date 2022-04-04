#!/usr/bin/env node
const exec = require('child_process').exec;

let command = `
cd client
flutter pub get
`
exec(command, (err, stdout, stderr) => {
    if (err) {
        console.error(err);
        return;
    }
    console.log(stdout);
});