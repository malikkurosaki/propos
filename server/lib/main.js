const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const cors = require('cors');
const colors = require('colors');



module.exports = async () => {
    app.use(cors())
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(express.static('public'));

    app.listen(port, () => {
        console.log(`Server is running on port ${port}`.cyan);
    })
}