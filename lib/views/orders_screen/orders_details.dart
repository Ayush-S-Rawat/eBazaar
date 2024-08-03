import 'package:ebazaar/views/orders_screen/components/order_place_details.dart';
import 'package:ebazaar/views/orders_screen/components/order_status.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  showDone: data['order_placed'],
                  title: "Placed"),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up_alt_rounded,
                  showDone: data['order_confirmed'],
                  title: "Confirmed"),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.delivery_dining_rounded,
                  showDone: data['order_on_delivery'],
                  title: "On Delivery"),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  showDone: data['order_delivered'],
                  title: "Delivered"),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    t1: "Order Code",
                    d1: data['order_code'],
                    t2: "Shipping Method",
                    d2: data['shipping_method'],
                  ),
                  orderPlaceDetails(
                    t1: "Order Date",
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format(data['order_date'].toDate()),
                    t2: "Payment Method",
                    d2: data['payment_method'],
                  ),
                  orderPlaceDetails(
                    t1: "Payment Status",
                    d1: "Unpaid",
                    t2: "Delivery Status",
                    d2: "Order Placed",
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).box.white.shadow.make(),
              Divider(),
              10.heightBox,
              "Ordered_Products"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          t1: data['orders'][index]['title'],
                          t2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']} x",
                          d2: "Refundable"),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        height: 20,
                        width: 30,
                        color: Color(int.parse(data['orders'][index]['color'])),
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              ).box.white.shadow.margin(EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
