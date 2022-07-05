import 'package:flutter/cupertino.dart';

class AvatarNotifier extends ChangeNotifier{
    String url = "";

    void increaseUrl(String imageUrl){
      imageUrl = url;
      notifyListeners();
    }
}