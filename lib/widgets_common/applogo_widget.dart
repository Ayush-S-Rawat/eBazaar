import 'package:ebazaar/consts/consts.dart';

Widget applogowidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
