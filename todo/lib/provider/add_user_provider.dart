import 'package:flutter/cupertino.dart';

class AddUserProvider extends ChangeNotifier{
    bool checkAddUser= false;

    void checkAdd() {
        checkAddUser = true;
        notifyListeners();
        }
}