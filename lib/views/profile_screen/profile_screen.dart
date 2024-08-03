import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/consts/lists.dart';
import 'package:ebazaar/controllers/auth_controller.dart';
import 'package:ebazaar/controllers/profile_controller.dart';
import 'package:ebazaar/services/firestore_services.dart';
import 'package:ebazaar/views/auth_screen/login_screen.dart';
import 'package:ebazaar/views/chat_screen/messaging_screen.dart';
import 'package:ebazaar/views/orders_screen/orders_screen.dart';
import 'package:ebazaar/views/profile_screen/components/details_card.dart';
import 'package:ebazaar/views/profile_screen/edit_profile_screen.dart';
import 'package:ebazaar/views/wishlist_screen/wishlist_screen.dart';
import 'package:ebazaar/widgets_common/bg_widgets.dart';
import 'package:ebazaar/widgets_common/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgwidget(
        child: Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor)));
          } else {
            var data = snapshot.data!.docs[0];
            return SafeArea(
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
                    ).onTap(() {
                      controller.nameController.text = data['name'];
                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageURL'] == ''
                            ? Image.asset(
                                imgProfile2,
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageURL'],
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            "${data['email']}".text.white.make(),
                          ],
                        )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: whiteColor)),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => LoginScreen());
                            },
                            child:
                                logout.text.fontFamily(semibold).white.make())
                      ],
                    ),
                  ),
                  20.heightBox,
                  FutureBuilder(
                    future: FirestoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return loadingIndicator().box.makeCentered();
                      } else {
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "In your Cart",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "In your Wishlist",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[2].toString(),
                                title: "Your Orders",
                                width: context.screenWidth / 3.4),
                          ],
                        );
                      }
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         count: data['cart_count'],
                  //         title: "In your Cart",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['wishlist_count'],
                  //         title: "In your Wishlist",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['order_count'],
                  //         title: "Your Orders",
                  //         width: context.screenWidth / 3.4),
                  //   ],
                  // ),
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
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => MessagesScreen());
                              break;
                          }
                        },
                        leading:
                            Image.asset(profileButtonsIcon[index], width: 22),
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
            );
          }
        },
      ),
    ));
  }
}
