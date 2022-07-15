const express = require('express');
const { api } = require('./routers');
const app = express();
const cors = require('cors');
const { Login } = require('./controller/login');
const { Register } = require('./controller/register');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const fs = require('fs');
const { userRouter } = require('./controller/users');
const expressAsyncHandler = require('express-async-handler');
const { PaymentMethodRouter } = require('./controller/payment_methods');
const { ListbillBill } = require('./controller/listbill_bills');
const { customer } = require('./controller/customer');
const { employee, EmployeeLogin } = require('./controller/employee');
const apiRoot = '/api/v1';
const jwt = require('jsonwebtoken');
const TOKEN_SECRET = 'malikkurosaki';


app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('./uploads/'));

app.get('/', (req, res) => {
    res.type('html').send('<center><h1>PROPOS SERVER</h1></center>');
});

// display image
app.get('/image/:user/:image?', (req, res) => {
    if (req.params.image == null) {
        res.sendFile(`${__dirname}/uploads/default.png`);
    } else {
        if (fs.existsSync(`${__dirname}/uploads/${req.params.user}/${req.params.image}`)) {
            res.sendFile(`${__dirname}/uploads/${req.params.user}/${req.params.image}`);
        } else {
            res.sendFile(`${__dirname}/uploads/default.png`);
        }
    }

});

// auth
app.post('/login', Login);
app.post('/register', Register);
app.post('/login/employee', EmployeeLogin);



// token
app.use(apiRoot, async (req, res, next) => {
    if (req.headers.authorization) {
        const token = req.headers.authorization.split(' ')[1];
        const decoded = jwt.verify(token, TOKEN_SECRET);

        if (decoded) {
            req.id = decoded.data.id
            req.usersId = decoded.data.usersId
            req.rolesId = decoded.data.rolesId
            next();
        } else {
            res.status(401).json({
                success: false,
                error: 'Unauthorized'
            });
        }
    } else {
        res.status(401).json({
            success: false,
            error: 'Unauthorized'
        });
    }

})

// root api
app.use(apiRoot, api);

// development
app.use(apiRoot + '/user', userRouter);
app.use(apiRoot + '/images', expressAsyncHandler(async (req, res) => {
    // get all name of image in folder uploads by user folder
    if (fs.existsSync(`${__dirname}/uploads/${req.user}`)) {
        const images = fs.readdirSync(`${__dirname}/uploads/${req.user}`);
        res.status(200).json(images);
    } else {
        res.status(200).json([]);
    }

}));

// payment method router
app.use(apiRoot + '/payment-method', PaymentMethodRouter)
app.use(apiRoot + '/listbill-bill', ListbillBill)
app.use(apiRoot + '/customer', customer)
app.use(apiRoot + '/employee', employee)
app.use(apiRoot + '/user', userRouter)


// run
app.listen(3000, () => {
    console.log('Server is running on port 3000');
});