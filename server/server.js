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
const apiRoot = '/api/v1';

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

app.post('/login', Login);
app.post('/register', Register);


// jwt token
app.use(apiRoot, async (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        console.log(token);

        const tkn = await prisma.tokens.findUnique({
            where: {
                token: token
            }
        });

        if (tkn) {
            req.user = tkn.usersId;
            req.userId = tkn.usersId;
            next();
        } else {
            res.status(401).send('<center><h1>Propos | 403 | unauthorized | 01</h1></center>');
        }
    } catch (error) {
        console.log(error);
        res.status(401).send('<center><h1>Propos | 403 | unauthorized | 02</h1></center>');
    }

})


app.use(apiRoot, api);

// development
app.use(apiRoot+'/user', userRouter);
app.use(apiRoot+'/images', expressAsyncHandler(async (req, res) => {
    // get all name of image in folder uploads by user folder
    const images = fs.readdirSync(`${__dirname}/uploads/${req.user}`);
    console.log(images);
    res.json(images);
}));

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});