const {Select} = require('enquirer');
const execSync = require('child_process').execSync;

async function XPrisma(){
    let selectPrisma = await new Select({
        name: 'selectPrisma',
        message: 'Pilih prisma:',
        choices: [
            { name: 'migrate', message: 'Migrate', hint: 'pilihan migrate' },
            { name: 'generate', message: 'Generate', hint: 'pilihan generate' }
        ]
    }).run().catch(err => null);

    switch (selectPrisma) {
        case 'migrate':
            execSync('cd server && npx prisma migrate dev --name $(date)', { stdio: 'inherit' });
            break;
        case 'generate':
            execSync('cd server && npx prisma generate', { stdio: 'inherit' });
            break;
        default: process.exit(0);
    }
}

module.exports = {XPrisma}