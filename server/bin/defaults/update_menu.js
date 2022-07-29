const path = require('path');
const fs = require('fs');
const prompts = require('prompts');
const colors = require('colors');
const execSync = require('child_process').execSync;
const menus = fs.readdirSync(path.join(__dirname, './../menus'));
const _ = require('lodash');

prompts({
    type: 'select',
    name: "menu",
    message: "What do you want to do?",
    choices: menus.map(e => {
        return {
            title: e.replace('.js', ''),
            value: e
        }
    })

}).then(({ menu }) => {
    if (menu == undefined) {
        console.log('Please select a menu'.red);
        return;
    }

    const xmenu = path.join(__dirname, `./../menus`);

    prompts({
        type: 'text',
        name: 'name',
        message: 'What is the name of the menu?'
    }).then(({ name }) => {
        if (name == undefined) {
            console.log('Please enter a menu name'.red);
            return;
        }

        execSync(`mv ${menu} ${_.snakeCase(name)}.js`, { stdio: 'inherit', cwd: xmenu });
        console.log(`Menu ${menu} renamed to ${_.snakeCase(name)}.js`.green);
    })

})