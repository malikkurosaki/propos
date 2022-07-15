const expressAsyncHandler = require("express-async-handler");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient()
const colors = require('colors');
const jwt = require('jsonwebtoken');
const TOKEN_SECRET = 'malikkurosaki';

const Login = expressAsyncHandler(async (req, res) => {

    let usr = await prisma.users.findFirst({
        where: {
            AND: [
                {
                    email: {
                        equals: req.body.email
                    },
                }, {
                    password: {
                        equals: req.body.password
                    },
                }
            ]
        }
    })

    if (usr) {
        const token = jwt.sign({
            data: {
                id: usr.id,
                usersId: usr.id,
                rolesId: usr.rolesId,
            }
        }, TOKEN_SECRET, {
            expiresIn: '1h'
        });

        res.status(200).json({
            success: true,
            token: token
        });
    } else {
        res.status(500).json({
            success: false,
            error: "Invalid Email or Password"
        });
    }
})


    // req.id = decoded.data.id
    // req.usersId = decoded.data.usersId
    // req.rolesId = decoded.data.rolesId

    // if (usr) {
    //     const token = await prisma.tokens.create({
    //         data: {
    //             usersId: usr.id
    //         }
    //     })

    //     let user = await prisma.users.findUnique({
    //         where: {
    //             id: usr.id,
    //         },
    //         include: {
    //             Profiles: true,
    //             Outlets: true,
    //         }
    //     })

    //     res.json({
    //         success: true,
    //         message: "Login Successful",
    //         data: user,
    //         token: token.token
    //     })

    // } else {
    //     res.status(400).json({
    //         success: false,
    //         message: "wrong email or password"
    //     })
    // }


// });

module.exports = { Login }