const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();

const Logout = expressAsyncHandler(async (req, res) => {
    let keluar = await prisma.tokens.delete({
        where: {
            usersId: req.user
        }
    })

    if (keluar) {
        res.json({
            success: true,
            message: "Berhasil keluar"
        })
    }else{
        res.json({
            success: false,
            message: "Gagal keluar"
        })
    }
})

module.exports = {Logout}