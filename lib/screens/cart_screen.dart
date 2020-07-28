import 'package:e_commerce/constant.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const route = 'cartScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> _products = Provider.of<CartItem>(context).cartProducts;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Screen'),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, constrains) {
            if (!_products.isEmpty) {
              return Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * 0.08 -
                      appBarHeight -
                      statusBarHeight,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return cartItem(_products[index], context);
                  },
                  itemCount: _products.length,
                ),
              );
            } else
              return Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * 0.08 -
                      appBarHeight -
                      statusBarHeight,
                  child: Text('Cart is Empty'));
          }),
          ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: RaisedButton(
                child: Text('ORDER NOW'),
              ))
        ],
      ),
    );
  }

  Widget cartItem(Product product, context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        color: KMainColor,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.15 / 2,
              backgroundImage: AssetImage(product.location),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(product.name),
                        Text(product.price)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[IconButton(icon: Icon(Icons.delete,),onPressed: (){
                      CartItem cartItem = Provider.of<CartItem>(context, listen: false);
                      cartItem.deleteFromCart(product);
                    },),
                      IconButton(icon: Icon(Icons.edit,),onPressed: (){
                        CartItem cartItem = Provider.of<CartItem>(context, listen: false);
                        cartItem.deleteFromCart(product);
                      },),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(product.quantity.toString()),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
