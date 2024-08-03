import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/services/firestore_services.dart';
import 'package:ebazaar/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Product in Wishlist"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          '${data[index]['p_imgs'][0]}',
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedSM.clip(Clip.antiAlias).make(),
                        title: '${data[index]['p_name']}'
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        subtitle: '${data[index]['p_price']}'
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        trailing: Icon(
                          Icons.favorite,
                          color: redColor,
                        ).onTap(() async {
                          await firestore
                              .collection(productsCollection)
                              .doc(data[index].id)
                              .set({
                            'p_wishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
