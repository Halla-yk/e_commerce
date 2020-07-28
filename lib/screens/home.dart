import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constant.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';
import 'product_info.dart';
class HomePage extends StatefulWidget {
  static const route = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  Store _store;
  int _bottomBarIndex = 0;
  List<Product> _allProducts;
  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              fixedColor: KMainColor,//لون اللي محدد
              currentIndex: _bottomBarIndex,
              onTap: (value){
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('Test')),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('Test')),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('Test')),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('Test'))
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: KMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex =
                        value; //ال value عبارة عن ال active tab index مرقمين من zero
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Jacket',
                    style: TextStyle(
                        color: _tabBarIndex == 0
                            ? Colors.black
                            : Colors.grey,
                        fontSize: _tabBarIndex == 0 ? 16 : null),
                  ),
                  Text('Pants',
                      style: TextStyle(
                          color: _tabBarIndex == 1
                              ? Colors.black
                              : Colors.grey,
                          fontSize: _tabBarIndex == 1 ? 16 : null)),
                  Text('shirts',
                      style: TextStyle(
                          color: _tabBarIndex == 2
                              ? Colors.black
                              : Colors.grey,
                          fontSize: _tabBarIndex == 2 ? 16 : null)),
                  Text('dresses',
                      style: TextStyle(
                          color: _tabBarIndex == 3
                              ? Colors.black
                              : Colors.grey,
                          fontSize: _tabBarIndex == 3 ? 16 : null))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketView(),
                gridViewForEachCategory(KPants),
                gridViewForEachCategory(KShirts),
                gridViewForEachCategory(KDresses)              ],
            ),
          ),
        ),
        Material(
          //علشنها خارج ال scaffold وبدي اياها تاخد style ال material
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 30, 30),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
                    Navigator.pushNamed(context, CartScreen.route);
                  },)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget jacketView() {
    StreamBuilder<QuerySnapshot>(
      //عند كل تغير بال list رح ينعمل rebuild لل stream
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product>
              products; //ما بنفع تكون خارج ال stream علشان عند اي تحديث بال document list ينعمللها rebuild ع ال streamBuilder لانه لو كانت خارج ال stream رح تكمل على الموجود قبل بال list
          for (var doc in snapshot.data.documents) {
            //loop on list of documents(rows)
            //ال doc عبارة عن map بتحتوي ال data
            var data = doc.data; //map

            products.add(Product(
                id: doc.documentID,
                name: data[KProductName],
                price: data[KProductPrice],
                location: data[KProductLocation],
                description: data[KProductDescription],
                category: data[KProductCategory]));
            //بدي ارجع list of products وبدي اعبي ال attributes تبعتها من ال doc data

          }
          _allProducts = [...products];
          products.clear();
          return gridViewForEachCategory(KJackets);
        } else {
    return Text("loading...");
      }},
    );
  }

  List<Product> getProductByCategory(category) {

    List<Product> products = [];
    try{for(var product in _allProducts){//عملت try and catch لانه ال all product في بداية التشغيل بتكون null ف رح يطلعلي ايرور
      if(product.category == KJackets)
        products.add(product);
    }}catch(ex){
      print(ex.message);
    }
    return products;
  }

  Widget gridViewForEachCategory(category){
    List<Product> products = [];
    products = getProductByCategory(category);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 8 / 10),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context,ProductInfo.route,arguments: products[index]);
          },
          child: MenuItem(products[index]),
        ),
      ),
      itemCount: products.length,
    );


  }
}
