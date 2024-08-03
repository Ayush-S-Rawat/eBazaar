import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/consts/lists.dart';
import 'package:ebazaar/controllers/cart_controller.dart';
import 'package:ebazaar/widgets_common/loading_indicator.dart';

import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");
                    Get.offAll(Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place My Order"),
        ),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethods.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 120,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        fit: BoxFit.cover,
                      )
                          .box
                          .margin(EdgeInsets.only(bottom: 8))
                          .roundedSM
                          .border(
                              color: redColor,
                              width: controller.paymentIndex.value == index
                                  ? 4
                                  : 0)
                          .clip(Clip.antiAlias)
                          .make(),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: true,
                                onChanged: (value) {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            )
                          : Container(),
                      Positioned(
                          right: 10,
                          bottom: 10,
                          child: "${paymentMethods[index]}"
                              .text
                              .white
                              .size(16)
                              .fontFamily(semibold)
                              .make())
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
