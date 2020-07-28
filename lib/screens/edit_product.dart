import 'package:e_commerce/constant.dart';
import 'package:flutter/material.dart';
import '../widgets/customTextField.dart';
import '../services/store.dart';
import '../models/product.dart';

class EditProduct extends StatelessWidget {
  static const route = 'editProduct';
  String _name, _price, _description, _category, _location;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product p = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(//لازم احط ال column تبع ال textFields داخل ListView علشان ما يعملي مشاكل مع الكيبورد
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Column(
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
                      _store.updateProduct({
                        KProductLocation: _location,
                        KProductPrice: _price,
                        KProductName: _name,
                        KProductDescription: _description,
                        KProductCategory: _category
                      }, p.id);
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
