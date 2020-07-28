import 'package:e_commerce/provider/modalHud.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constant.dart';
import '../widgets/customTextField.dart';
import '../services/auth.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class SignupScreen extends StatelessWidget {
  static const route = 'SignupScreen';
  String email, password;
  final auth = Auth();
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
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
              CustomTextField(
                  onClick: (value) {},
                  hint: 'Enter your name',
                  icon: Icons.account_circle),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                  onClick: (value) {
                    email = value;
                  },
                  hint: 'Enter email address',
                  icon: Icons.email),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                onClick: (value) {
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
                  //علشان يعملي context جديد علشان ال Scaffold.of(context).showSnackBar رح يطلعلي ايرور
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      //تعني عند الضغط على الsign up  اعملي validate والي بدورها بتعمل rebuild لل form مع ال error message
                      final changeLoading = Provider.of<ModalHud>(context,listen: false);
                      /////////////////////////////////////
                      changeLoading.changeIsLoading(true);
                      ////////////////////////////////////
                      if (_globalkey.currentState.validate()) {
                        _globalkey.currentState.save();
                        try {
                          final authResult = await auth.signUp(email.trim(), password.trim());
                          print(authResult.user
                              .uid); //هادا ال id ال firebase هو اللي بعملي اياه
                          /////////////////////////////////////
                          changeLoading.changeIsLoading(false);
                          ////////////////////////////////////
                          Navigator.pushNamed(context, HomePage.route);
                        } catch (e) {
                          /////////////////////////////////////
                          changeLoading.changeIsLoading(false);
                          ////////////////////////////////////
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e
                                .message), //ممكن الاكسبشن علشان الايميل متكرر او علشان الفورمات غلط تبع الايميل
                          ));
                        }
                      }
                      /////////////////////////////////////
                      changeLoading.changeIsLoading(false);
                      ////////////////////////////////////
                    },
                    color: Colors.black,
                    child: Text(
                      'Sign up',
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
                    'Do you have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text('Login', style: TextStyle(fontSize: 16))
                ],
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
