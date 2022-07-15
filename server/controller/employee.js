const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const { ModelEmployees } = require("../prisma/models");
const prisma = new PrismaClient();
const employee = require('express').Router();
const UId = require('short-unique-id');
const uid = new UId({ length: 10 });
const jwt = require('jsonwebtoken');
const TOKEN_SECRET = 'malikkurosaki';

const EmployeeCreate = expressAsyncHandler(async (req, res) => {
    try {
        let body = req.body;
        const employee = await prisma.employees.create({
            data: {
                pin: uid(),
                name: body.name,
                email: body.email,
                password: body.password,
                rolesId: body.rolesId,
                usersId: req.userId,
                address: body.address,
                phone: body.phone
            }
        })

        res.status(200).json({
            success: true,
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
})

const EmployeeGet = expressAsyncHandler(async (req, res) => {
    let data = await prisma.employees.findMany({
        where: {
            usersId: req.userId
        }
    })
    res.status(200).json({
        success: true,
        data: data,
    });
}
)

const EmployeeLogin = expressAsyncHandler(async (req, res) => {
    let body = req.body;
    let data = await prisma.employees.findFirst({
        select: {
            id: true,
            usersId: true,
            rolesId: true,
        },
        where: {
            AND: [
                {
                    pin: {
                        equals: body.pin
                    },
                    password: {
                        equals: body.password
                    }
                },
            ]
        }
    })

    if (data) {
        jwt.sign({
            id: data.id,
            usersId: data.usersId,
            rolesId: data.rolesId,
        }, TOKEN_SECRET, { expiresIn: '10000000000h' }, (err, token) => {
            
            if (err) {
                console.log(err);
                res.status(500).json({
                    success: false,
                    error: err.message
                });
            } else {

                res.status(200).json({
                    success: true,
                    token: token
                });
            }
        });
    } else {
        res.status(500).json({
            success: false,
            error: "Invalid Pin"
        });
    }
})

employee.post('/create', EmployeeCreate);
employee.get('/get', EmployeeGet);

module.exports = { employee, EmployeeLogin };



