import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/account.dart';

class BlocAvatar extends Cubit<String> {
  BlocAvatar() : super("");

  increaseUrl(String imgUrl) {
    emit(imgUrl);
  }
}
