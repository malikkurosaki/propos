const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();

// create product
const ProductCreate = expressAsyncHandler(async (req, res) => {

    let {
        name,
        price,
        description,
        outletsId,
        categoriesId,
        stock,
        minStock,
        image
    } = req.body;

    prisma.products.create({
        data: {
            name: name,
            price: Number(price),
            description: description??"",
            outletsId: outletsId == 'all' ? undefined : outletsId,
            categoriesId: categoriesId,
            usersId: req.userId,
            Images: {
                create: {
                    url: image??""
                }
            },
            Stocks: {
                create: {
                    quantity: Number(stock??0),
                    minQuantity: Number(minStock??0)
                }
            }
        }
    }).then(product => {
        res.status(200).json({
            success: true,
            message: "Product created"
        })
    })
    .catch(err => {
        console.log(err.message);
        res.status(500).json({
            success: false,
            message: err.message
        });
    });


})

// get product
const ProductGet = expressAsyncHandler(async (req, res) => {
    const products = await prisma.products.findMany({
        where: {
            usersId: {
                equals: req.user
            }
        },
        include: {
            Outlets: {
                select: {
                    id: true,
                    name: true
                }
            },
            Categories: {
                select: {
                    id: true,
                    name: true
                }
            },
            Images: {
                select: {
                    url: true
                }
            },
            Stocks: {
                select: {
                    quantity: true,
                    minQuantity: true
                }
            }
        }
    })
    res.json({
        success: products != null,
        data: products,
        message: products == null ? "Gagal mengambil produk" : ""
    })
})


// update product
const ProductUpdate = expressAsyncHandler(async (req, res) => {
    const product = await prisma.products.update({
        where: {
            id: req.body.id
        },
        data: {
            name: req.body.name,
            price: req.body.price,
            categoriesId: req.body.categoriesId,
            outletsId: req.body.outletsId
        }
    })
    res.json({
        success: product != null,
        data: product,
        message: product == null ? "Gagal mengubah produk" : ""
    }
    )
})

// delete product
const ProductDelete = expressAsyncHandler(async (req, res) => {
    const product = await prisma.products.delete({
        where: {
            id: req.params.id
        }
    })
    res.json({
        success: product != null,
        data: product,
        message: product == null ? "Gagal menghapus produk" : ""
    })
})



module.exports = { ProductCreate, ProductGet, ProductUpdate, ProductDelete };