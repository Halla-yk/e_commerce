import 'package:e_commerce/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constant.dart';
import '../widgets/customTextField.dart';
import '../services/auth.dart';
import 'home.dart';
class LoginScreen extends StatelessWidget {
  static const route = 'loginScreen';
  String password,email;
  final auth = Auth();
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();//لازم يكون برة ال build لانه رح يسببلي مشاكل
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .2,
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/icons/buy.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Text(
                        'Buy it',
                        style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            CustomTextField(onClick: (value){
              email = value;
            },hint: 'Enter email address', icon: Icons.email),
            SizedBox(
              height: height * 0.02,
            ),
            CustomTextField(
              onClick: (value){
                password = value;
              },
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Builder(
                builder:(context)=>FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async{
                    //تعني عند الضغط على الsign up  اعملي validate والي بدورها بتعمل rebuild لل form مع ال error message

                    if(_globalkey.currentState.validate()){
                      _globalkey.currentState.save();
                      try{
                        final authResult = await auth.signIn(email, password);
                        print(authResult.user.uid);
                        Navigator.pushNamed(context, HomePage.route);
                      }catch(e){
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),));
                      }


                    }

                  },
                  color: Colors.black,
                  child: Text(
                    'login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dont have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text('sign up', style: TextStyle(fontSize: 16))
              ],
            )
          ],
        ),
      ),
    );
  }
}
