const express = require('express');
const app = express();
const {Exec}= require('sh');
const { router } = require('./routers');


app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(router)

app.get('/', (req, res) => {
    res.type('html').send('<center><h1>PROPOS SERVER</h1></center>');
})

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});