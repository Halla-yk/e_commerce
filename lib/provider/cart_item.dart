import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../models/product.dart';
class CartItem extends ChangeNotifier{
//عملت provider انه الlist  بستخدمها باكتر من سكرين
//وحدة بضيف من خلالعا و التانبة بعرض من خلالها
  List<Product> cartProducts =[];
  addToCart(Product product){
    cartProducts.add(product);
    notifyListeners();
  }

  deleteFromCart(Product product){
    cartProducts.remove(product);
    notifyListeners();
  }
}