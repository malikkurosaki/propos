
const asyncHandler = require('express-async-handler');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const Register = asyncHandler(async (req, res) => {
    let data = req.body;
    // let device = JSON.parse(data.device);
    try {

        let user = await prisma.users.create({
            data: {
                name: data.name,
                email: data.email,
                password: data.password,
                Profiles: {
                    create: {
                        phone: data.phone,
                    },
                }
            }
        })

        const outlet = await prisma.outlets.create({
            data: {
                name: data.outlet,
                usersId: user.id,
            }
        })

        // const perangkat = await prisma.devices.create({
        //     data: {
        //         model: device.model,
        //         version: device.version,
        //         manufacturer: device.manufacturer,
        //         brand: device.brand,
        //         device: device.device,
        //         usersId: user.id,
        //         outletsId: outlet.id,
        //     }
        // })

        res.json({
            success: true,
            data: user,
            message: "Register berhasil"
        })


        // let register = await prisma.users.create({
        //     data: {
        //         name: data.name,
        //         email: data.email,
        //         password: data.password,
        //         Outlets: {
        //             create: {
        //                 name: data.outlet,
        //             }
        //         },
        //         Profiles: {
        //             create: {
        //                 phone: data.phone,
        //             }
        //         },

        //         // id
        //         // model
        //         // version
        //         // manufacturer
        //         // brand
        //         // device
        //         Devices: {
        //             create: {
        //                 // id: device.id,
        //                 model: device.model,
        //                 version: device.version,
        //                 manufacturer: device.manufacturer,
        //                 brand: device.brand,
        //                 device: device.device
        //             }
        //         }

        //     }
        // });

        // delete register['password']
        // res.json({
        //     success: register != null,
        //     data: register,
        //     message: register == null ? "email sudah terdaftar" : ""
        // })
    } catch (error) {
        console.log(error)
        res.json({
            success: false,
            message: "503"
        })
    }

});

module.exports = { Register }