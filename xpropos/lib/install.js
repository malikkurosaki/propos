
const prompts = require('prompts');
const execSync = require('child_process').execSync;

function XInstal(){
    prompts({
        type: 'select',
        name: 'install',
        message: 'run command to ?? ',
        choices: [
            { title: 'Server', value: 'server' },
            { title: 'Client', value: 'client' },
        ],
    }).then(({ install }) => {
        switch (install) {
            case 'server':
                prompts({
                    type: 'text',
                    name: 'com',
                    message: 'masukkan perintah: ',
                    initial: 'contoh: npm install colors',
                }).then(({ com }) => {
                    execSync(`cd server && ${com}`, { stdio: 'inherit' });
                });
                break;
            case 'client':
                prompts({
                    type: 'text',
                    name: 'com',
                    message: 'masukkan perintah: ',
                    initial: 'contoh: flutter pub get',
                }).then(({ com }) => {
                    execSync(`cd client && ${com}`, { stdio: 'inherit' });
                });
                break;
            default: process.exit(0);
        }
    })
}

module.exports = {XInstal}