import 'package:ebazaar/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: EdgeInsets.all(12),
    ),
  );
}
