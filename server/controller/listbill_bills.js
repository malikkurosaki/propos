const expressAsyncHandler = require("express-async-handler");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const ListbillBill = require('express').Router();

const ListbillBillCreate = expressAsyncHandler(async (req, res) => {

    let bodyListBill = JSON.parse(req.body['bodyListBill']);
    let bodyBilles = JSON.parse(req.body['bodyBilles']);



    const listbillBills = await prisma.listBill.create({
        data: {
            totalItems: Number(bodyListBill.totalItems) ?? undefined,
            totalPrice: Number(bodyListBill.totalPrice) ?? undefined,
            totalQty: Number(bodyListBill.totalQty) ?? undefined,
            transactionId: bodyListBill.transactionId ?? undefined,
            customersId: bodyListBill.customersId ?? undefined,
            billTypesId: bodyListBill.billTypesId ?? undefined,
            employeesId: bodyListBill.employeesId ?? undefined,
            outletsId: bodyListBill.outletsId ?? undefined,
            pax: bodyListBill.pax ?? undefined,
            usersId: bodyListBill.usersId ?? req.userId,
            paymentMethodsId: bodyListBill.paymentMethodsId ?? undefined,
        }
    })

    for (let bill of bodyBilles) {
        const billes = await prisma.bills.create({
            data: {
                listBillId: listbillBills.id,
                transactionId: listbillBills.transactionId,
                categoriesId: bill.categoriesId ?? undefined,
                discountsId: bill.discountsId ?? undefined,
                notes: bill.notes ?? undefined,
                qty: Number(bill.qty) ?? undefined,
                notes: bill.notes ?? undefined,
                productsId: bill.productsId ?? undefined,
                totalPrice: Number(bill.totalPrice) ?? undefined,
                usersId: bodyListBill.usersId ?? req.userId
            }
        })
    }

    res.status(200).json({
        success: true
    });

});

ListbillBill.post('/create', ListbillBillCreate);


module.exports = { ListbillBill };