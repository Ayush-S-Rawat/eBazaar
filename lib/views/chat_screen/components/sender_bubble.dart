import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  var isSenderTheUser = data['uid'] == currentUser!.uid;

  return Directionality(
    textDirection: isSenderTheUser ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: isSenderTheUser ? redColor : darkFontGrey,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: isSenderTheUser
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              bottomRight: isSenderTheUser
                  ? const Radius.circular(0)
                  : const Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}
