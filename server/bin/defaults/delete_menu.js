const path = require('path');
const fs = require('fs');
const prompts = require('prompts');
const colors = require('colors');
const menus = fs.readdirSync(path.join(__dirname, './../menus'));

prompts({
    type: 'multiselect',
    name: 'menus',
    message: 'What is the name of the menu?',
    choices: menus.map(e => {
        return {
            title: e.replace('.js', ''),
            value: e
        }
    })
}).then(({ menus }) => {
    if (menus == undefined) {
        console.log('Please select a menu'.red);
        return;
    }

    menus.forEach(e => {
        fs.unlinkSync(path.join(__dirname, './../menus', e));
    })

    console.log(`Menus ${menus} deleted`.green);
})