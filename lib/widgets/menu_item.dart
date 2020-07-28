import 'package:flutter/material.dart';
import '../models/product.dart';
class MenuItem extends StatelessWidget {
  final Product product;

  MenuItem(this.product);
  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: <Widget>[
          Positioned.fill(
            //بتاخد حجم ال stack
              child: Image(
                fit: BoxFit.fill,
                //ابعاد الصورة بتتمدد على حسب حجم ال stack
                image: AssetImage(product.location),
              )),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 6,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Text(product.name),
                      Text('\$ ${product.price} ')
                    ],
                  ),
                ),
              ),
            ),
          )
        ],

    );
  }
}
