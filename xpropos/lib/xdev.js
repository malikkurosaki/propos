const enq = require('enquirer');
const execSync = require('child_process').execSync;

async function XDev() {
    let select = await enq.prompt([
        {
            type: 'select',
            name: 'selectDev',
            message: 'Pilih dev:',
            choices: [
                { name: 'server', message: 'Server Command', hint: 'Command For Server' },
                { name: 'client', message: 'Client Command', hint: 'Command For Client' },
            ]
        },
        {
            type: 'input',
            name: 'inputDev',
            message: 'Masukan package:',
            hint: 'Masukan package yang akan di install'
        }

    ]).catch(err => process.exit(0));

    execSync(`cd ${select.selectDev} &&  ${select.inputDev}`, { stdio: 'inherit' });
}


module.exports = { XDev }