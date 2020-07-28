import 'package:e_commerce/admin/addProduct.dart';
import 'package:e_commerce/screens/manageProducts.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static const route = 'adminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,//علشان يخلي ال column width بيساوي تبع الشاشة
          ),
          RaisedButton(
            child: Text('Add product'),
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.route);
            },
          ),
          RaisedButton(
            child: Text('Edit product'),
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.route);
            },
          ),
          RaisedButton(
            child: Text('View product'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
