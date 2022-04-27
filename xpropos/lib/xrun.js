const { Select } = require('enquirer');
const execSync = require('child_process').execSync;


async function XRun() {
    const pilihanRun = await new Select({
        name: 'pilihanRun',
        message: 'Pilih run:',
        choices: [
            { name: 'server', message: 'Server', hint: "server debug nodejs" },
            { name: 'client', message: 'Client', hint: 'pilihan client berjalan di android' },
            {name: "clientChrome", message: "Client Chrome", hint: "pilihan client berjalan di chrome"},
        ]
    }).run().catch(err => null);

    switch (pilihanRun) {
        case 'server':
            execSync('cd server && nodemon server.js', { stdio: 'inherit' });
            break;
        case 'client':
            execSync('cd client && flutter run', { stdio: 'inherit' });
            break;
        case 'clientChrome':
            execSync('cd client && flutter run -d chrome', { stdio: 'inherit' });
            break;
        default: process.exit(0);
    }
}

module.exports = { XRun }