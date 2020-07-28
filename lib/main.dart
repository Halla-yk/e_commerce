import 'package:e_commerce/admin/addProduct.dart';
import 'package:e_commerce/admin/adminHome.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/modalHud.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/home.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import './screens/manageProducts.dart';
import './screens/edit_product.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<ModalHud>(
          create:(context)=> ModalHud(),

        ),
        ChangeNotifierProvider<CartItem>(
          create:(context)=> CartItem(),

        )
      ],child: MaterialApp(
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route:(context)=>LoginScreen()
        ,SignupScreen.route:(context)=> SignupScreen(),
        HomePage.route:(context)=> HomePage(),
        AdminHome.route:(context)=> AdminHome(),
        AddProduct.route:(context)=>AddProduct(),
        ManageProducts.route:(context)=>ManageProducts(),
        EditProduct.route:(context)=>EditProduct(),
        ProductInfo.route:(context)=>ProductInfo(),
        CartScreen.route:(context)=> CartScreen()
      },

    ),);



  }
}

