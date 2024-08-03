import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/views/category_screen/category_details.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .padding(EdgeInsets.all(4))
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .outerShadowSm
      .white
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
