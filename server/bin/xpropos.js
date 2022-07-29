#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const menus = fs.readdirSync(path.join(__dirname, './menus'));
const defaults = fs.readdirSync(path.join(__dirname, './defaults'));
const clog = require('c-log');
const execSync = require('child_process').execSync;
const _ = require('lodash');

prompts({
    type: 'select',
    name: "menu",
    message: "What do you want to do?",
    choices: [
        ...defaults.map(e => {
            return {
                title: `${_.upperCase(e.split('.')[0])}`.green,
                value: {
                    type: 'defaults',
                    name: e
                }
            }
        }),
        ...menus.map(e => {
            return {
                title: e.replace('.js', '').replace('_', ' ').yellow,
                value: {
                    type: 'menus',
                    name: e
                }
            }
        })
    ]
}).then(({ menu }) => {
    if (menu == undefined) {
        clog.error('Please select a menu');
        return;
    }

    const xmenu = path.join(__dirname, `${menu.type}`, menu.name);
    execSync(`node ${xmenu}`, { stdio: 'inherit' });
    
})
