import 'package:e_commerce/provider/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:e_commerce/constant.dart';

import 'cart_screen.dart';

class ProductInfo extends StatefulWidget {
  static const route = 'productInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(product.location),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 30, 30),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.route);
                    },
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .12,
                child: Column(
                  children: <Widget>[
                    Opacity(
                      opacity: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(product.name),
                              SizedBox(
                                height: 10,
                              ),
                              Text(product.description),
                              SizedBox(
                                height: 10,
                              ),
                              Text('\$ ${product.price}'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipOval(
                                    child: GestureDetector(
                                        onTap: add,
                                        child: Material(
                                          color: KMainColor,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Icon(Icons.add),
                                          ),
                                        )),
                                  ),
                                  Text(
                                    _quantity.toString(),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  ClipOval(
                                    child: GestureDetector(
                                        onTap: subtract,
                                        child: Material(
                                          color: KMainColor,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Icon(Icons.remove),
                                          ),
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        onPressed: () {
                          CartItem _cartItem =
                              Provider.of<CartItem>(context, listen: false);
                          var cartProduct = _cartItem.cartProducts;
                          bool exist = false;
                          //بدي اتاكد انه ال product مش موجودة بال cart من قبل
                          for (var _product in cartProduct) {
                            if (_product.name == product.name) {
                              exist = true;

                            }
                          }
                          if(exist==false){
                            product.quantity = _quantity;
                            _cartItem.addToCart(product);
                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                              Text('you have already added this product'),
                            ));
                          }

                        },
                        child: Text('ADD TO CART'),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }
}
