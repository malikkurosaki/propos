const express = require('express');
const { api } = require('./routers');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/api/v1', api);

app.get('/', (req, res) => {
    res.type('html').send('<center><h1>PROPOS SERVER</h1></center>');
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});