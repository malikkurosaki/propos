#!/usr/bin/env node
const exec = require('child_process').exec;
async function Perintah(command, print) {
    let hasil = "";
    return new Promise((resolve, reject) => {
        exec(command, (error, stdout, stderr) => {
            hasil += stderr
            hasil += stdout
            if(print) console.log(hasil.trim())
            resolve(hasil.trim());
        });
    });
}


;(async() => {
    await Perintah('cd client && flutter pub get', true)
})()


// exec(command, (err, stdout, stderr) => err? console.log(err.message.trim()): console.log(stdout.trim())).on('data', (data) => console.log(`${data}`.trim()));
