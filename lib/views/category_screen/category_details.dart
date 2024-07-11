import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/views/category_screen/item_details.dart';
import 'package:ebazaar/widgets_common/bg_widgets.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    6,
                    (index) => "Baby Clothing"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make()),
              ),
            ),
            20.heightBox,
            Expanded(
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgP1,
                          height: 150,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        "Laptop 4GB/64GB"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        "\$600"
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make()
                      ],
                    )
                        .box
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .white
                        .roundedSM
                        .outerShadowSm
                        .padding(EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(() => ItemDetails(title: "Dummy Item"));
                    });
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
