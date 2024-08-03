import 'package:ebazaar/consts/consts.dart';

Widget orderPlaceDetails({t1, t2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$t1".text.fontFamily(semibold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$t2".text.fontFamily(semibold).make(),
              "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
