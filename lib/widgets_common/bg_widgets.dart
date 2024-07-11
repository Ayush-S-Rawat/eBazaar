import 'package:ebazaar/consts/consts.dart';

Widget bgwidget({Widget? child}) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage(imgBackground),
      fit: BoxFit.fill,
    )),
    child: child,
  );
}
