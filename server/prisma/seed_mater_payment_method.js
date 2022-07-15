const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const listPaymentMethod = [
    {
        id: "1",
        name: 'cash'
    },
    {
        id: "2",
        name: 'credit card'
    },
    {
        id: "3",
        name: 'debit card'
    },
    {
        id: "4",
        name: 'bank transfer'
    },
    {
        id: "5",
        name: 'gopay'
    },
    {
        id: "6",
        name: 'ovo'
    },
    {
        id: "7",
        name: 'dana'
    },
    {
        id: "8",
        name: 'indomaret'
    },
    {
        id: "9",
        name: 'alfamart'
    },
    {
        id: "10",
        name: 'tokopedia'
    },
    {
        id: "11",
        name: 'bca'
    },
    {
        id: "12",
        name: 'bni'
    },
    {
        id: "13",
        name: 'mandiri'
    },
    {
        id: "14",
        name: 'bri'
    },
    {
        id: "15",
        name: 'cimb'
    },
    {
        id: "16",
        name: 'danamon'
    }
]

// seed master paymet method
async function SeedPaymentMethod() {
    // create or update
    for (let i = 0; i < listPaymentMethod.length; i++) {
        let payment_method = await prisma.masterPaymentMethods.upsert({
            where: {
                id: listPaymentMethod[i].id
            },
            create: {
                id: listPaymentMethod[i].id,
                name: listPaymentMethod[i].name,
            },
            update: {
                name: listPaymentMethod[i].name,
            },
        });
    }

    // log
    console.log("Seed Payment Method Success");
    
}

module.exports = { SeedPaymentMethod }

