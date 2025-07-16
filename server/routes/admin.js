const express = require('express');
const adminRoute = express.Router();

// add admin middleware
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');

adminRoute.post("/admin/add-product", admin, async (req, res) => {
    try {
        const {name, description, price, quantity, images, category} = req.body;
        // initialize product card
        let product = new Product({
            name, 
            description,
            price,
            quantity,
            images,
            category
        });
        product = await product.save(); // it returns _id, _version
        res.json(product);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
})

// get all products
// /admin/get-products
// admin is a middleware
adminRoute.get("/admin/get-products", admin, async (req, res) => {
    try {
        const product = await Product.find({});
        // send the results via res.json()
        res.json(product);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// delete a product
adminRoute.post("/admin/delete-product", admin, async (req, res) => {
    try {
        const {id} = req.body;
        // find the product by its id and delete
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

module.exports = adminRoute;