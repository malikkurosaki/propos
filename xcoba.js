const uuid = require('short-unique-id');
const uid = new uuid({length: 10});
const fs = require('fs');

// id
// pin
// name
// address
// phone
// email
// password
// createdAt
// updatedAt
// User
// usersId
// ListBill
// Roles
// Outlet
// outletsId

const listId = [];
const ld = Array.from(Array(12).keys());
const result = ld.map(x => {
    return {
        "pin": uid(),
        "name": "name" + x,
        "address": "address" + x,
        "email": "email" + x + "@gmail.com",
        "phone": "08123456789",
        "password": "password" + x,
        "usersId": "1",
        "outletsId": "1",
        "rolesId": "1"
    }
});

fs.writeFileSync('listId.json', JSON.stringify(result));

