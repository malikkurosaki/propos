const path = require('path');
const fs = require('fs');
const prompts = require('prompts');
const colors = require('colors');
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;

prompts({
    type: 'text',
    name: 'menu',
    message: 'What is the name of the menu?'
}).then(({ menu }) => {
    if (menu == undefined) {
        console.log('Please enter a menu name'.red);
        return;
    }

    const file = path.join(__dirname, './../menus', _.snakeCase(menu) + '.js');
    if (fs.existsSync(file)) {
        console.log('Menu already exists'.red);
        return;
    }

    const templete = `
        #!/usr/bin/env node
        const prompts = require('prompts');
        const fs = require('fs');
        const path = require('path');
        const clog = require('c-log');
        const execSync = require('child_process').execSync;
        const _ = require('lodash');
        const PrismaClient = require('@prisma/client').PrismaClient;
        const prisma = new PrismaClient();
        const beautify = require('js-beautify').js_beautify;
    `;
    fs.writeFileSync(file, beautify(templete));
    console.log(`Menu ${menu} created`.green);
})