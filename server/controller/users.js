const expressAsyncHandler = require("express-async-handler");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const userRouter = require('express').Router();


// user create
const UserCreate = expressAsyncHandler(async (req, res) => {
    let data = req.body;
    const user = await prisma.users.create({
        data: {
            name: data.name,
            email: data.email,
            password: data.password,
            Outlets: {
                create: {
                    name: data.outlet,
                }
            },
            Profiles: {
                create: {
                    phone: data.phone,
                },
            },
        }
    });

    delete user['password'];
    res.json({
        success: user != null,
        data: user,
        message: user == null ? "email sudah terdaftar" : ""
    });
});


// user get
const UsersGet = expressAsyncHandler(async (req, res) => {
    let users = await prisma.users.findMany({
        include: {
            Profiles: true,
            Outlets: true,
        },
    });
    res.json({
        success: true,
        data: users,
    });
})

// user update
const UserUpdate = expressAsyncHandler(async (req, res) => {
    let data = req.body;
    const user = await prisma.users.update({
        where: {
            id: data.id
        },
        data: {
            name: data.name,
            email: data.email,
            password: data.password,
            Outlets: {
                update: {
                    name: data.outlet,
                }
            },
            Profiles: {
                update: {
                    phone: data.phone,
                },
            },
        }
    });
    delete user['password'];
    res.json({
        success: user != null,
        data: user,
        message: user == null ? "email sudah terdaftar" : ""
    });
})

// user delete
const UserDelete = expressAsyncHandler(async (req, res) => {
    let data = req.body;
    const user = await prisma.users.delete({
        where: {
            id: data.id
        }
    });
    res.json({
        success: user != null,
        data: user,
        message: user == null ? "email sudah terdaftar" : ""
    });
})


const UserLoad = expressAsyncHandler(async (req, res) => {

    console.log(req.user);
    const user = await prisma.users.findUnique(
        {
            where: {
                id: req.user
            },
            include: {
                Profiles: true,
                Outlets: {
                    include: {
                        Products: true,
                        Categories: true,
                        Devices: true,
                    }
                }
            }

        }
    );

    res.json({
        success: true,
        data: user,
    });

})


// user router get
userRouter.get('/', UsersGet);
userRouter.get('/load', UserLoad);

// export
module.exports = { userRouter };


