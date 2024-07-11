import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/consts/lists.dart';
import 'package:ebazaar/controllers/auth_controller.dart';
import 'package:ebazaar/views/auth_screen/login_screen.dart';
import 'package:ebazaar/views/profile_screen/components/details_card.dart';
import 'package:ebazaar/widgets_common/bg_widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                ),
              ).onTap(() {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.widthBox,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dummy User".text.fontFamily(semibold).white.make(),
                      "customer@example.com".text.white.make(),
                    ],
                  )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: whiteColor)),
                      onPressed: () async {
                        await Get.put(AuthController()).signoutMethod(context);
                        Get.offAll(() => LoginScreen());
                      },
                      child: logout.text.fontFamily(semibold).white.make())
                ],
              ),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsCard(
                    count: "00",
                    title: "in your card",
                    width: context.screenWidth / 3.4),
                detailsCard(
                    count: "32",
                    title: "in your wishlist",
                    width: context.screenWidth / 3.4),
                detailsCard(
                    count: "675",
                    title: "your Orders",
                    width: context.screenWidth / 3.4),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  color: lightGrey,
                );
              },
              itemCount: profileButtonsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(profileButtonsIcon[index], width: 22),
                  title: profileButtonsList[index]
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                );
              },
            )
                .box
                .white
                .rounded
                .margin(EdgeInsets.all(12))
                .padding(EdgeInsets.symmetric(horizontal: 16))
                .shadowSm
                .make()
                .box
                .color(redColor)
                .make(),
          ],
        ),
      ),
    ));
  }
}
