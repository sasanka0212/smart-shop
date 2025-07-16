const express = require('express');
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const userRouter = express.Router();

userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        // find the id of the product
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.cart.length == 0) {
            user.cart.push({product, quantity: 1});
        } else {
            let isProductFound = false;
            for(let i = 0; i<user.cart.length; i++) {
                if(user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;
                }
            }
            if(isProductFound) {
                let product3 = user.cart.find((product2) => product2.product._id.equals(product._id));
                product3.quantity += 1;
            } else {
                user.cart.push({product, quantity: 1});
            }
        }
        user = await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

module.exports = userRouter;