import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';

import '../../../constants/themes.dart';
import '../../../constants/widget.dart';
import '../../../localization/localization_constants.dart';
import '../../../models/order_data_model.dart';

class OrderDetailsScreen extends StatefulWidget {
   OrderDetailsScreen(this.ordersListData,{Key? key}) : super(key: key);
   OrderData? ordersListData;
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.ordersListData!.status);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 14,
              color: HexColor("#9098B1"),
            )),
        title: customText(getTranslated(context, "Order Details")!,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
      ),
      /*floatingActionButton: customFloatingActionButton(context,
          text: getTranslated(context, "Notify Me")!, onPress: () {}),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Row(
            //     children: [
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Container(
            //                 padding: EdgeInsets.all(3),
            //                 decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: HexColor("#087DA9")),
            //                 child: Icon(
            //                   Icons.check,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //               ),
            //               Container(
            //                 height: 1,
            //                 width: MediaQuery.of(context).size.width / 5.5,
            //                 color: HexColor("#40BFFF"),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           customText(getTranslated(context, "Packing")!,
            //               color: customTextColor.withOpacity(.5))
            //         ],
            //       ),
            //
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               Container(
            //                 padding: EdgeInsets.all(3),
            //                 decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: rng/*widget.ordersListData!.status!*/ >= 1 ?
            //                     HexColor("#087DA9"):
            //                     HexColor("#EBF0FF")
            //
            //                 ),
            //                 child: Icon(
            //                   Icons.check,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //               ),
            //               Container(
            //                 height: 1,
            //                 width: MediaQuery.of(context).size.width / 5.5,
            //                 color: rng/*widget.ordersListData!.status!*/ >= 1 ?
            //                 HexColor("#087DA9")
            //                 :HexColor("#EBF0FF"),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           customText(getTranslated(context,"Shipping")!,
            //               color: customTextColor.withOpacity(.5))
            //         ],
            //       ),
            //
            //
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               Container(
            //                 padding: EdgeInsets.all(3),
            //                 decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color:/*widget.ordersListData!.status!*/rng >= 2 ?
            //                     HexColor("#087DA9")
            //                         :HexColor("#EBF0FF")),
            //                 child: Icon(
            //                   Icons.check,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //               ),
            //               Container(
            //                 height: 1,
            //                 width: MediaQuery.of(context).size.width / 5.5,
            //                 color: rng/*widget.ordersListData!.status!*/ >= 2 ?
            //                 HexColor("#087DA9")
            //                     :HexColor("#EBF0FF"),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           customText(getTranslated(context,"Arriving")!
            //               ,
            //               color: customTextColor.withOpacity(.5))
            //         ],
            //       ),
            //
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               Container(
            //                 padding: EdgeInsets.all(3),
            //                 decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: rng/*widget.ordersListData!.status!*/ >= 3 ?
            //                     HexColor("#087DA9")
            //                         :HexColor("#EBF0FF")
            //                 ),
            //                 child: Icon(
            //                   Icons.check,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           customText(getTranslated(context,"success",)!
            //               ,
            //               color: customTextColor.withOpacity(.5))
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HexColor("#087DA9")),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                customText(widget.ordersListData!.status!,
                    color: customTextColor.withOpacity(.5))
              ],
            ),

            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                customText(
                    getTranslated(context,"Product",)!
                    ,
                    color: customTextColor, fontWeight: FontWeight.bold),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) =>  Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: CartItem(
                    widget.ordersListData!.lineItems![index]
                  ),
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.ordersListData!.lineItems!.length,
                padding: EdgeInsets.all(0),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                customText(
                    getTranslated(context,"Shipping Details",)!
                    ,
                    color: customTextColor, fontWeight: FontWeight.bold),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: HexColor("#9098B1").withOpacity(.01),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: HexColor("#9098B1").withOpacity(.2))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /* Row(
                    children: [
                      customText(
                          getTranslated(context,"Date Shipping",)!
                          ,
                          color: HexColor("9098B1"), size: 12),
                      Spacer(),
                      customText(widget.ordersListData!., size: 12),
                    ],
                  ),*/
                  SizedBox(
                    height: 010,
                  ),
                  /*Row(
                    children: [
                      customText(
                          getTranslated(context,"Shipping",)!
                          ,
                          color: HexColor("9098B1"), size: 12),
                      Spacer(),
                      customText("POS Reggular", size: 12),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),*/
                  Row(
                    children: [
                      customText(
                          getTranslated(context,"Shipment.Num")!,
                          color: HexColor("9098B1"), size: 12),
                      Spacer(),
                      customText(widget.ordersListData!.number!, size: 12),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(

                    children: [
                      customText(
                          getTranslated(context,"Address")!
                          ,
                          color: HexColor("9098B1"), size: 12),
                      Spacer(),

                      /*widget.ordersListData!.shippingAddress==null?
                      Container():*/
                         Expanded(
                          child: customText(
                             widget.ordersListData!.shipping!.address1!,
                              max: 2,
                              overflow: TextOverflow.ellipsis,
                              size: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                customText(
                    getTranslated(context,"Payment Details")!
                    ,
                    color: customTextColor, fontWeight: FontWeight.bold),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: HexColor("#EBF0FF"))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        customText(
                            getTranslated(context,"Items")!,
                            color: HexColor("#9098B1"), size: 12),
                        customText(widget.ordersListData!.lineItems!.length.toString(),
                            color: HexColor("#9098B1"), size: 12),
                        const Spacer(),
                        customText("SAR ${widget.ordersListData!.total!}",
                            color: customTextColor, size: 12),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        customText(
                            getTranslated(context,"Shipping")!
                            ,
                            color: HexColor("#9098B1"), size: 12),
                        const Spacer(),
                        customText("SAR ${widget.ordersListData!.shippingTotal!}",
                            color: customTextColor, size: 12),
                      ],
                    ),
                  ),
                 /* Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        customText(
                            getTranslated(context,"Import charges")!,
                            color: HexColor("#9098B1"), size: 12),
                        const Spacer(),
                        customText("SAR200.86",
                            color: customTextColor, size: 12),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        customText(
                            getTranslated(context, "Discount",)!

                            ,color: HexColor("#9098B1"),
                            size: 12),
                        const Spacer(),
                        customText(
                            "SAR ${widget.ordersListData!.discountTotal!}"
                            ,color: customTextColor,
                            size: 12),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: List.generate(
                        150 ~/ 1.5,
                        (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : HexColor("#EBF0FF"),
                                height: 3,
                              ),
                            )),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        customText(
                            getTranslated(context,"Total Price")!
                            ,
                            color: customTextColor, size: 12),
                        const Spacer(),
                        customText(
                            "SAR ${
                                widget.ordersListData!.total!
                               /* (int.parse( "30"*/
                            /*widget.ordersListData!.total!*/
                            /*)+
                                   40*/
                            /*widget.ordersListData!.shippingCost!*/
                            /*)
                                    -
                                    int.parse("12"*/
                            /*widget.ordersListData!.discount!*/
                            /*)*/
                            }",
                            color: HexColor("#40BFFF"), size: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
   CartItem(this.itemsOrdersListData,{Key? key}) : super(key: key);
   LineItems? itemsOrdersListData;
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: HexColor("#EBF0FF")),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 100,
              width: 100,
              child: customCachedNetworkImage(
                 url: widget.itemsOrdersListData!.image!.src,
                context: context,
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Expanded(
                      flex: 7,
                      child: ExpandableText(
                        widget.itemsOrdersListData!.name!,
                        expandText: getTranslated(context,"show more")!,
                        collapseText: getTranslated(context,"show less")!,
                        expandOnTextTap: true,
                        maxLines: 2,
                        style: TextStyle(
                            color: customTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontFamily: "Poppins"),
                        linkColor: Colors.blue,

                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${getTranslated(context, "Items")} ${
                        widget.itemsOrdersListData!.quantity.toString()}"
                      ,style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: HexColor("#9098B1"),
                          fontSize: 12,
                          fontFamily: "Poppins"
                      ),)
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 90,
                  child: widget.itemsOrdersListData!.price == null ?
                  Container() :
                  Text(
                    widget.itemsOrdersListData!.price==null ?
                    "${widget.itemsOrdersListData!.price} SAR" :
                    "${widget.itemsOrdersListData!.price} SAR",
                    maxLines: 1,
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor("#40BFFF"),
                        fontFamily: "Poppins",
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                /*widget.itemsordersListData!.offer == null ?
                Container() :*/
               /* Row(
                  children: [
                    SizedBox(
                      child: Text(
                        "${40*/
                /*widget.itemsordersListData!.price!*/
                /*} SAR",
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: HexColor("#9098B1"),
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    SizedBox(
                      child: Text(
                        "${getOffer("10"*/
                /*widget.itemsordersListData!.offer!*//*,
                            "120"*/
                /*widget.itemsordersListData!.price!*//*)} %"
                        ,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: HexColor("#FB7181"),
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
  double getOffer(String offer, String price) {
    return ((int.parse(price) - int.parse(offer)) /
        int.parse(price)) * 100;
  }
}
