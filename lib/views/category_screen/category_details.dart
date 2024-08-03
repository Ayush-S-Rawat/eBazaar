import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/controllers/product_controller.dart';
import 'package:ebazaar/services/firestore_services.dart';
import 'package:ebazaar/views/category_screen/item_details.dart';
import 'package:ebazaar/widgets_common/bg_widgets.dart';
import 'package:ebazaar/widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.put(ProductController());

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<ProductController>();
    return bgwidget(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.subcat.length,
                (index) => "${controller.subcat[index]}"
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
                    .make()
                    .onTap(() {
                  switchCategory("${controller.subcat[index]}");
                  setState(() {});
                }),
              ),
            ),
          ),
          20.heightBox,
          StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: "No Products found!"
                        .text
                        .color(darkFontGrey)
                        .makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;

                  return Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p_imgs'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ).box.roundedSM.clip(Clip.antiAlias).make(),
                              "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p_price']}"
                                  .numCurrency
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
                            controller.checkIffav(data[index]);
                            Get.to(() => ItemDetails(
                                title: "${data[index]['p_name']}",
                                data: data[index]));
                          });
                        }),
                  );
                }
              }),
        ],
      ),
    ));
  }
}
