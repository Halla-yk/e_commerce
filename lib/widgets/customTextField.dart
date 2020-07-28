import 'package:flutter/material.dart';
import 'package:e_commerce/constant.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  CustomTextField({@required this.onClick,@required this.hint,@required this.icon});

  String _errorMessage(){
    switch(hint){
      case 'Enter your name': return 'Name is empty';
      case 'Enter email address': return 'Email is empty';
      case 'Enter your password': return 'password is empty';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onSaved: onClick,
        validator: (value){
          if(value.isEmpty){
            return this._errorMessage();
          }
        },obscureText: hint == 'Enter your password'?true:false,//علشان يعمل الباسورد نجوم
        cursorColor: KMainColor,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon,color: KMainColor,),
            hintText:this.hint,
            filled: true,
            fillColor: KseconderyColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red))),

      ),
    );
  }
}
