const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();

// create outlet
const OutletCreate = expressAsyncHandler(async (req, res) => {
    let cekOutlet = await prisma.outlets.findFirst({
        where: {
            usersId: {
                equals: req.user
            },
            name: {
                equals: req.body.name
            }
        },
    })

    if (cekOutlet) {
        res.json({
            success: false,
            message: "Outlet sudah ada"
        })
    }

    let outlet = await prisma.outlets.create({
        data: {
            name: req.body.name,
            description: req.body.description,
            usersId: req.user,
        }
    })

    res.json({
        success: outlet != null,
        data: outlet,
        message: outlet == null ? "Gagal menambahkan outlet" : ""
    })
});

// get outlet
const OutletGet = expressAsyncHandler(async (req, res) => {

    let outlets = await prisma.outlets.findMany({
        where: {
            usersId: {
                equals: req.user
            }
        }
    })

    res.json({
        success: outlets != null,
        data: outlets,
        message: outlets == null ? "Gagal mengambil outlet" : ""
    })
})

// update outlet
const OutletUpdate = expressAsyncHandler(async (req, res) => {
    let outlet = await prisma.outlets.update({
        where: {
            id: req.body.id
        },
        data: {
            name: req.body.name,
            description: req.body.description,
        }
    })
    res.json({
        success: outlet != null,
        data: outlet,
        message: outlet == null ? "Gagal mengubah outlet" : ""
    }
    )
})

// delete outlet
const OutletDelete = expressAsyncHandler(async (req, res) => {
    let outlet = await prisma.outlets.delete({
        where: {
            id: req.params.id
        },
    })
    res.json({
        success: outlet != null,
        data: outlet,
        message: outlet == null ? "Gagal menghapus outlet" : ""
    }
    )
})



module.exports = { OutletCreate, OutletGet, OutletUpdate, OutletDelete };
