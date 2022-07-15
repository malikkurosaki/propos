const { SeedCategory } = require("./seed_category");
const { SeedEmployee } = require("./seed_employee");
const { SeedPaymentMethod } = require("./seed_mater_payment_method");
const { SeedBreactfast } = require("./seed_product");
const { SeedRole } = require("./seed_role");
const { Seeduser } = require("./seed_user");

(async x => {
    await SeedRole();
    await Seeduser();
    await SeedCategory();
    await SeedPaymentMethod();
    await SeedBreactfast();
    await SeedEmployee()
})();