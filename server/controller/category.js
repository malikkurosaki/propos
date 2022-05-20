const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();

// category create
const CategoryCreate = expressAsyncHandler(async (req, res) => {
    let category = await prisma.categories.create({
        include: {
            Outlets: true
        },  
        data: {
            name: req.body.name,
            description: req.body.description,
            outletsId: req.body.outletsId,
            usersId: req.user
        }
    })
    res.json({
        success: category != null,
        data: category,
        message: category == null ? "Gagal menambahkan kategori" : ""
    })

});

// category get
const CategoryGet = expressAsyncHandler(async (req, res) => {
    let categories = await prisma.categories.findMany({
        where: {
            usersId: {
                equals: req.user
            }
        }
    })
    res.json({
        success: categories != null,
        data: categories,
        message: categories == null ? "Gagal mengambil kategori" : ""
    })
})

// category update
const CategoryUpdate = expressAsyncHandler(async (req, res) => {
    let category = await prisma.categories.update({
        where: {
            id: req.body.id
        },
        data: {
            name: req.body.name,
            description: req.body.description,
        }
    })
    res.json({
        success: category != null,
        data: category,
        message: category == null ? "Gagal mengubah kategori" : ""
    })
})

// category delete
const CategoryDelete = expressAsyncHandler(async (req, res) => {
    let category = await prisma.categories.delete({
        where: {
            id: req.params.id
        },
    })
    res.json({
        success: category != null,
        data: category,
        message: category == null ? "Gagal menghapus kategori" : ""
    })
})

module.exports = { CategoryCreate, CategoryGet, CategoryUpdate, CategoryDelete };
