const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listCategor  = [
    {
        id: "1",
        name: 'Makanan',
        userId: "1",
    },
    {
        id: "2",
        name: 'Minuman',
        userId: "1",
    },
    {
        id: "3",
        name: 'Kue',
        userId: "1",
    },
    {
        id: "4",
        name: 'Kerajinan',
        userId: "1",
    }
]

async function SeedCategory() {
    for (let i = 0; i < listCategor.length; i++) {
        await prisma.categories.upsert({
            where: {
                id: listCategor[i].id
            },
            create: {
                id: listCategor[i].id,
                name: listCategor[i].name,
                usersId: listCategor[i].userId,
            },
            update: {
                name: listCategor[i].name,
                usersId: listCategor[i].userId,
            },
        })
    }

    console.log('Seed Category Success')

}

module.exports = { SeedCategory }