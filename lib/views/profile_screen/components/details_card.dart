import 'package:ebazaar/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      "00".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      "in your Cart".text.color(darkFontGrey).make(),
    ],
  ).box.white.rounded.height(80).width(width).padding(EdgeInsets.all(4)).make();
}
