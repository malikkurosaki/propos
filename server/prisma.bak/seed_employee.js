const { PrismaClient } = require('@prisma/client');
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('../../listId.json'));
const prisma = new PrismaClient();


async function SeedEmployee(){
    for(let da of data){
        await prisma.employees.upsert({
            where: {
                pin: da.pin
            },
            update: {
                pin: da.pin,
                name: da.name,
                address: da.address,
                phone: da.phone,
                email: da.email,
                password: da.password,
                usersId: da.usersId,
                rolesId: da.rolesId,
                // outletsId: da.outletsId,
            },
            create: {
                pin: da.pin,
                name: da.name,
                address: da.address,
                phone: da.phone,
                email: da.email,
                password: da.password,
                usersId: da.usersId,
                rolesId: da.rolesId,
                // outletsId: da.outletsId,
            },
        });
    }

    console.log("Seed Employee Success");
}  

module.exports = {SeedEmployee}