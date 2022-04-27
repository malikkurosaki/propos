const prompts = require('prompts');
const execSync = require('child_process').execSync;

async function XGit() {
    const pilihan = await prompts({
        type: 'select',
        name: 'pilihan',
        message: 'Pilih menu:',
        choices: [
            { title: 'push', value: 'push', description: 'push ke remote' },
        ]
    }).catch(err => process.exit());

    let branch = execSync('git branch').toString().trim().split('\n').map(branch => branch.trim());

    let selBranch = await prompts({
        type: 'select',
        name: 'sb',
        message: 'Pilih branch:',
        choices: branch.map(branch => ({ title: branch, value: branch, description: branch }))
    }).catch(err => process.exit());

    let jadinya = selBranch.sb.replace('*', '');
    execSync(`git add . && git commit -m "$(date)" && git push origin ${jadinya}`);
    process.exit()
    
}

module.exports = { XGit }