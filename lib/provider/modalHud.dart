
import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier{

  bool isLoading = false;

  void changeIsLoading(bool value){
    this.isLoading = value;
    notifyListeners();
  }
}