import 'package:flutter/cupertino.dart';

class PageRouter extends Route {
  Widget page;
  BuildContext context;
  PageRouter(this.page,this.context);

  PageRouteBuilder build() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
