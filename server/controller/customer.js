const expressAsyncHandler = require("express-async-handler");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const customer = require('express').Router();

const CustomerCreate = expressAsyncHandler(async (req, res) => {

})

const CustomerGet = expressAsyncHandler(async (req, res) => {
    let data = await prisma.customers.findMany({
        where: {
            usersId: req.usersId
        }
    })
    res.status(200).json({
        success: true,
        data: data,
    });
})


customer.post('/create', CustomerCreate);
customer.get('/get', CustomerGet);

module.exports = { customer };



