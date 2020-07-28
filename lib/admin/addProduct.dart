import 'package:flutter/material.dart';
import '../widgets/customTextField.dart';
import '../services/store.dart';
import '../models/product.dart';

class AddProduct extends StatelessWidget {
  static const route = 'addProduct';
  String _name, _price, _description, _category, _location;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: 'Product name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product price',
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product category',
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Location',
              onClick: (value) {
                _location = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Add product'),
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _globalKey.currentState.reset();
                  _store.addProduct(Product(
                      name: _name,
                      price: _price,
                      location: _location,
                      category: _category,
                      description: _description));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
