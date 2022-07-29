const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listUser = [
    {
        id: "1",
        name: 'admin',
        email: 'admin@gmail.com',
        password: 'admin',
        rolesId: "2",
        Outlets: {
            create: {
                name: 'denpasar',
            }
        },
        Profiles: {
            create: {
                phone: '08123456789',
            },
        },
    },
    {
        id: "2",
        rolesId: "2",
        name: 'user',
        email: 'user@gmail.com',
        password: 'user',
        Outlets: {
            create: {
                name: 'singaraja',
            }
        },
        Profiles: {
            create: {
                phone: '08123456789',
            },
        },
    },
    {
        id: "3",
        rolesId: "2",
        name: 'user2',
        email: 'user2@gmail.com',
        password: 'user2',
        Outlets: {
            create: {
                name: 'denpasar',
            }
        },
        Profiles: {
            create: {
                phone: '08123456789',
            },
        },
    },
]

async function Seeduser() {

    for (let i = 0; i < listUser.length; i++) {
        await prisma.users.upsert({
            where: {
                email: listUser[i].email
            },
            create: {
                id: listUser[i].id,
                rolesId: listUser[i].rolesId,
                name: listUser[i].name,
                email: listUser[i].email,
                password: listUser[i].password,
                Outlets: {
                    create: {
                        name: listUser[i].Outlets.create.name,
                    },
                },
                Profiles: {
                    create: {
                        phone: listUser[i].Profiles.create.phone,
                    },
                },
            },
            update: {
                name: listUser[i].name,
                email: listUser[i].email,
                password: listUser[i].password
            },
        });
    }

    console.log("Seed User Success");
}


module.exports = { Seeduser }