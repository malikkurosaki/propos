const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const log = require('c-log')


const roles = [
    {
        id: 1,
        name: 'owner'
    },
    {
        id: 2,
        name: 'admin'
    },
    {
        id: 3,
        name: 'employee'
    },
    {
        id: 4,
        name: 'developer'
    }

]

async function seed() {
    await prisma.roles.deleteMany();

    for (let role of roles) {
        await prisma.roles.create({
            data: {
                rolesId: Number(role.id),
                name: role.name
            }
        })
    }

    log.table(await prisma.roles.findMany())

}

seed()