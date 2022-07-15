const express = require('express');
const { CategoryCreate, CategoryGet, CategoryUpdate, CategoryDelete } = require('./controller/category');
const { OutletCreate, OutletGet, OutletDelete, OutletUpdate } = require('./controller/outlet');
const { ProductCreate, ProductGet, ProductUpdate, ProductDelete } = require('./controller/product');
const api = express.Router();
const fs = require('fs');

// multer upload image
const multer = require('multer');
const { Logout } = require('./controller/logout');
const { PaymentMethodRouter } = require('./controller/payment_methods');


const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        if (!fs.existsSync('./uploads/'+req.user)) {
            fs.mkdirSync('./uploads/'+req.user);
        }
        cb(null, './uploads/'+req.user);
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname);
    }
});

// Category
// create outlet
api.post('/outlet/create', OutletCreate);

// get outlet
api.get('/outlet/get', OutletGet);

// update outlet
api.put('/outlet/update/:id', OutletUpdate);

// delete outlet
api.delete('/outlet/delete/:id', OutletDelete);

// Category
// create category 
api.post('/category/create', CategoryCreate);

// get category
api.get('/category/get', CategoryGet);

// update category
api.put('/category/update/:id', CategoryUpdate);

// delete category
api.delete('/category/delete/:id', CategoryDelete);

// Product
// create product
api.post('/product/create', ProductCreate);

// get product
api.get('/product/get', ProductGet);

// update product
api.put('/product/update/:id', ProductUpdate);

// delete product
api.delete('/product/delete/:id', ProductDelete);


// upload image with multer
api.post('/upload', multer({ storage: storage }).single('image'), (req, res) => {
    console.log(req.file);
    res.json({
        path: req.file.path,
        name: req.file.filename,
        success: true
    })
})


// logout
api.delete('/logout', Logout)

api.get('/', (req, res) => {
    res.type('html').send('<center><h1>PROPOS SERVER API</h1></center>');
})

module.exports = { api }