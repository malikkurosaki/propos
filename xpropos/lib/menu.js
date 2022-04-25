const { Select } = require('enquirer');
const fs = require('fs');
const execSync = require('child_process').execSync;
const colors = require('colors');

async function Menu() {
    const pilih = await new Select({
        name: 'pilih',
        message: 'pilih menu',
        choices: [
            { name: "run", message: "jalankan ", hint: "jalankan debug " },
            { name: "exit", message: "keluar" , hint: "keluar dari program"},
        ]
    }).run().catch(err => console.log("err"));

    if (pilih == null) {
        process.exit();
    }

    switch (pilih) {
        case "run":
            const dir = fs.readdirSync('./');
            let listDir = [];
            if (dir.includes('server')) {
                listDir.push({ name: 'server', message: 'server' });
            }
            if (dir.includes('client')) {
                listDir.push({ name: 'client', message: 'client' });
            }
            if (listDir.length == 0) {
                console.log("tidak ada folder client ataupun server");
                process.exit();
            }

            const selectDir = await new Select({
                name: 'selectDir',
                message: 'pilih folder',
                choices: listDir
            }).run().catch(err => console.log("err"));

            switch (selectDir) {
                case "client":
                    console.log("menjalankan client debug ...".green);
                    execSync(`cd client && flutter run`, { stdio: 'inherit' });
                    break;
                case "server":
                    console.log("server");
                    break;
            }
            break;
        case "exit":
            console.log("byeee ....".yellow);
            process.exit();
            break;
    }

}


module.exports = { Menu }