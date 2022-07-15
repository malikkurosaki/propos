const expressAsyncHandler = require("express-async-handler");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const PaymentMethodRouter = require('express').Router();

// payment method create
const PaymentMethodsCreate = expressAsyncHandler(async (req, res) => {
    let data = req.body;
    const payment_methods = await prisma.paymentMethods.create({
        data: {
            id: data.id,
            name: data.name,
            usersId: req.usersId
        },
    });

    res.json({
        success: payment_methods != null,
        data: payment_methods,
        message: payment_methods == null ? "payment_methods sudah terdaftar" : ""
    });
});

// payment method upsert many
const PaymentMethodsUpsert = expressAsyncHandler(async (req, res) => {
    let data = JSON.parse(req.body.data);
    let listData = [];

    for (let d of data) {
        const payment_methods = await prisma.paymentMethods.upsert({
            where: {
                id_usersId: {
                    id: d.id,
                    usersId: req.usersId
                }
            },
            update: {
                name: d.name,
            },
            create: {
                name: d.name,
                usersId: req.usersId,
            }
        });
        listData.push(payment_methods);
    }

    res.status(200).json({
        success: true,
        data: listData,
        message: "payment_methods created"
    });

});

// payment method get
const PaymentMethodsGet = expressAsyncHandler(async (req, res) => {
    let payment_methods = await prisma.paymentMethods.findMany({
        where: {
            usersId: req.usersId,
        },
    });
    
    res.status(200).json({
        success: true,
        data: payment_methods,
    });
});

// payment method master get
const PaymentMethodsMasterGet = expressAsyncHandler(async (req, res) => {
    let payment_methods = await prisma.masterPaymentMethods.findMany();
    res.status(200).json({
        success: true,
        data: payment_methods,
    });

});

// payment method delete
const PaymentMethodsDelete = expressAsyncHandler(async (req, res) => {
    let id = req.params.id;
    const payment_methods = await prisma.paymentMethods.delete({
        where: {
            id: id
        }
    });

    res.status(200).json({
        success: payment_methods != null,
        message: payment_methods == null ? "payment_methods sudah terhapus" : ""
    });

});

PaymentMethodRouter.post('/create', PaymentMethodsCreate);
PaymentMethodRouter.get('/get', PaymentMethodsGet);
PaymentMethodRouter.get('/master', PaymentMethodsMasterGet);
PaymentMethodRouter.post('/upsert', PaymentMethodsUpsert);
PaymentMethodRouter.delete('/delete/:id', PaymentMethodsDelete);

module.exports = {PaymentMethodRouter};


