const { Select } = require('enquirer');
const fs = require('fs');
const execSync = require('child_process').execSync;
const colors = require('colors');
const { XPrisma } = require('./xprisma');
const { XRun } = require('./xrun');
const { XDev } = require('./xdev');
const { XGit } = require('./git');

async function XMenu() {
    const pilihanMenu = await new Select({
        name: 'pilihanMenu',
        message: 'Pilih menu:'.green,
        hint: 'gunakan panah atas dan bawah untuk memilih CTRL+C untuk keluar',
        choices: [
            { name: 'run', message: 'Run', hint: 'pilihan run debug [server | client ]' },
            { name: 'prisma', message: 'Prisma', hint: 'pilihan prisma' },
            { name: 'dev', message: "Dev", hint: "pilihan dev" },
            { name: 'git', message: 'Git', hint: 'pilihan git' },
        ]
    }).run().catch(err => null);

    switch (pilihanMenu) {
        case 'run':
            XRun()
            break
        case 'prisma':
            XPrisma();
            break
        case 'dev':
            XDev();
            break
        case 'git':
            XGit();
            break

        default: process.exit(0);
    }

}


module.exports = { XMenu }