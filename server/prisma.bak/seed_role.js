const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();


const listRole = [
    {
        "id": "1",
        "name": "super user",
    },
    {
        "id": "2",
        "name": "owner"
    },
    {
        "id": "3",
        "name": "staff"
    },
    {
        "id": "3",
        "name": "cashier"
    }
]

async function SeedRole(){
    for(let rol of listRole){
        await prisma.roles.upsert({
            create: {
                name: rol['name'],
                id: rol['id']
            },
            update: {
                name: rol['name'],
                id: rol['id']
            },
            where: {
                id: rol['id']
            }
        })
    }

    console.log('seed role success')
}

module.exports = {SeedRole}