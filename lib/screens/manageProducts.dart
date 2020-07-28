import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/edit_product.dart';
import 'package:flutter/material.dart';
import '../services/store.dart';
import '../constant.dart';
import '../widgets/menu_item.dart';
class ManageProducts extends StatelessWidget {
  final _store = Store();
  static const route = 'ManageProduct';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        //عند كل تغير بال list رح ينعمل rebuild لل stream
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>
                _products; //ما بنفع تكون خارج ال stream علشان عند اي تحديث بال document list ينعمللها rebuild ع ال streamBuilder لانه لو كانت خارج ال stream رح تكمل على الموجود قبل بال list
            for (var doc in snapshot.data.documents) {
              //loop on list of documents(rows)
              //ال doc عبارة عن map بتحتوي ال data
              var data = doc.data; //map

              _products.add(Product(
                id: doc.documentID,
                  name: data[KProductName],
                  price: data[KProductPrice],
                  location: data[KProductLocation],
                  description: data[KProductDescription],
                  category: data[KProductCategory]));
              //بدي ارجع list of products وبدي اعبي ال attributes تبعتها من ال doc data

            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 8 / 10),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child:GestureDetector(
                  onTapUp: (details) async{
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double right = MediaQuery.of(context).size.width - dx;
                    double bottom = MediaQuery.of(context).size.height - dy;
                    await showMenu(//من نوع future
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, right, bottom),
                        items: [
                          MyPopupMenuItem(
                            child: Text('Edit'),
                            onClick: (){
                              Navigator.pushNamed(context, EditProduct.route,arguments: _products[index]);
                            },
                          ),
                          MyPopupMenuItem(
                            child: Text('Delete'),
                            onClick: (){
                              _store.deleteProduct(_products[index].id);
                              Navigator.pop(context);
                            },
                          )
                        ]);
                  },
                  child: MenuItem(_products[index]),
                ),
              ),
              itemCount: _products.length,
            );
          } else {
            return Text("loading...");
          }
        },
      ),
    );
  }
}
class MyPopupMenuItem<T> extends PopupMenuItem<T>{
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({@required this.onClick,@required this.child}): super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T,PopupMenuItem> extends PopupMenuItemState<T,MyPopupMenuItem<T>>{

  @override
  void handleTap() {
    widget.onClick();
    super.handleTap();

  }
}
//رح نستخدم ال stream builder علشان مشكلة التحديث
//return Scaffold(
//body: FutureBuilder<List<Product>>(
//future: _store.loadProducts(), builder: (context,snapshot){
//return ListView.builder(
//itemBuilder: (context, index) => Text(snapshot.data[index].name)
//,itemCount: snapshot.data.length,
//);
//},),
//);

//الطريقة خطأ لانه ال build معتمد على future فهيك ال list رح تكون empty لما ينفذ ال build
//    return Scaffold(
//      body: ListView.builder(
//        itemBuilder: (context, index) => Text(_products[index].name),
//        itemCount: _products.length,
//      ),
//    );
//  }
//  @override
//  void initState(){
//    getProducts();
//  }
//  void getProducts() async{
//    _products = await _store.loadProducts();
//  }
//}
