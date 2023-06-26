import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woocommerce_app/HandlingDataView.dart';
import 'package:woocommerce_app/controller/checkoutController.dart';

import 'package:woocommerce_app/view/widget/checkout/customAddadress.dart';
import 'package:woocommerce_app/view/widget/checkout/customCheckoutCard.dart';
import 'package:woocommerce_app/view/widget/checkout/customDeliverywayBox.dart';
import 'package:woocommerce_app/view/widget/checkout/custombottomnavigtionCheckout.dart';

import 'view/widget/checkout/customMyCheckoutText.dart';
import 'view/widget/checkout/customPaymentType.dart';
import 'view/widget/checkout/customtextCheckout.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ImpcheckoutController controller = Get.put(ImpcheckoutController());
    return Scaffold(
      bottomNavigationBar: GetBuilder<ImpcheckoutController>(
        builder: (c) => controller.dataAdress.isEmpty
            ? customAddaddress()
            : custombottomnavigitionCheckout(
                onpressed: () {
                  controller.checkout();
                },
              ),
      ),
      body: GetBuilder<ImpcheckoutController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CustomMyCheckouutText(
                      textname: "Checkout",
                    ),
                  ),
                  customtextCheckout(
                    textname: "Choose Payment Method",
                  ),
                  customPaymentType(
                    onpressed: () {
                      controller.getpaymetval("cash");
                    },
                    textname: "Cash On Delivery",
                    condetion: controller.paymentval == "cash" ? true : false,
                  ),
                  customPaymentType(
                    onpressed: () {
                      controller.getpaymetval("card");
                    },
                    textname: "Payment Card",
                    condetion: controller.paymentval == "card" ? true : false,
                  ),
                  customtextCheckout(textname: "Choose Delivery Type"),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: [
                        customDeliverywayBox(
                          onpressed: () {
                            controller.getdeliveryval("delivery");
                          },
                          size: size,
                          textname: "Delivery",
                          imageurl: "assets/images/006-delivery.png",
                          condetion: controller.deliveryval == "delivery"
                              ? true
                              : false,
                        ),
                        customDeliverywayBox(
                          onpressed: () {
                            controller.getdeliveryval("recive");
                          },
                          condetion:
                              controller.deliveryval == "recive" ? true : false,
                          textname: "recive",
                          imageurl: "assets/images/drivethru.png",
                          size: size,
                        ),
                      ],
                    ),
                  ),
                  if (controller.deliveryval == "delivery")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customtextCheckout(textname: "Shipping Address"),
                        ...List.generate(
                          controller.dataAdress.length,
                          (index) => InkWell(
                            onTap: () {
                              controller.getaddressval(controller
                                  .dataAdress[index].addressId
                                  .toString());
                            },
                            child: customCheckoutCard(
                              onpressed: () {},
                              title:
                                  "${controller.dataAdress[index].addressName}",
                              subtitle:
                                  "${controller.dataAdress[index].addressCity}" +
                                      ". ${controller.dataAdress[index].addressStreet}",
                              condetion: controller.addressval ==
                                      controller.dataAdress[index].addressId
                                          .toString()
                                  ? true
                                  : false,
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ))),
    );
  }
}
