const expressAsyncHandler = require("express-async-handler");
const {PrismaClient} = require('@prisma/client');
const prisma = new PrismaClient()

const Login = expressAsyncHandler(async (req, res) => {
    let usr = await prisma.users.findFirst({
        where: {
            email: {
                equals: req.body.email
            },
            password: {
                equals: req.body.password
            }
        }
    })

    res.json({
        success: usr != null,
        data: usr,
        message: usr == null? "email atau password salah": ""
    })
});


module.exports = {Login}