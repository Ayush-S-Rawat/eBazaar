import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/views/cart_screen/shipping_screen.dart';

import '../../controllers/cart_controller.dart';
import '../../services/firestore_services.dart';
import '../../widgets_common/loading_indicator.dart';
import '../../widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => ShippingDetails());
              },
              textColor: whiteColor,
              title: 'Proceed to shipping'),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: 'Shopping cart'
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: 'Cart is Empty'.text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  '${data[index]['img']}',
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedSM.clip(Clip.antiAlias).make(),
                                title:
                                    '${data[index]['title']} (x${data[index]['qty']})'
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                subtitle: '${data[index]['tprice']}'
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Total price'
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => '${controller.totalP.value}'
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          )
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(12))
                          .width(context.screenWidth - 60)
                          .color(lightGolden)
                          .roundedSM
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
