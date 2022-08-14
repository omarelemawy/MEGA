import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/models/order_data_model.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../constants/color_constans.dart';
import '../../../constants/themes.dart';
import '../../../constants/utils.dart';
import '../../../localization/localization_constants.dart';
import '../../../models/user_data.dart';
import '../../home/home_screen.dart';
import 'foloosi_screen.dart';

class SelectPaymentScreen extends StatefulWidget {
   SelectPaymentScreen({Key? key,this.orderData,this.addressId}) : super(key: key);
  OrderData? orderData;
  int? addressId;
   bool isLoading=false;
  @override
  _SelectPaymentScreenState createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    void getExploreItem
        (lang,orderId,userId,paymentMethod,addressId,email)
    async{
      setState(() {
        widget.isLoading= true;
      });
      print(orderId);
      print(userId);
      print(addressId);
      var response = await Dio().post(
          Utils.CreateOrders_URL,options:
      Options(headers: {
        "lang":lang,
        "Accept-Language":lang,
        "user":userId
      }),
          data: {
            "order_id":orderId,
            "payment_method":paymentMethod,
            "address_id":addressId,
          }
      );
      print(response.data);
      if(response.data["status"]=="success")
      {
        widget.isLoading= true;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>HomeScreen(
              lang,0,
              email: email,
            )
            ), (route) => false);

      }else{
        print("failed");
      }
    }



    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon:
        Icon(Icons.arrow_back_ios, size: 14, color: HexColor("#9098B1"),)),
        title: customText(
            getTranslated(context, "Payment Method",)!
            , fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
      ),
      body: widget.isLoading?
      const Center(
          child:SpinKitChasingDots(
            color: customColor,
            size: 40,
          )):Column(
        children: [
          ListTile(
              title: customText("foloosi",
                  color: customTextColor, fontWeight: FontWeight.w600),
              leading: Icon(
                Icons.credit_card,
                color: HexColor("#40BFFF"),
              ),
              onTap: () {
                getUserDate().then((value) async {
                  widget.orderData = OrderData(
                      orderId: widget.orderData!.orderId,
                      orderAmount: widget.orderData!.orderAmount,
                      orderDescription: widget.orderData!.orderDescription,
                      currencyCode: "AED",
                      country: widget.orderData!.country,
                      state: widget.orderData!.state,
                      customer: Customer(
                          name: value.name,
                          email: value.email,
                          mobile: value.phone,
                          city: widget.orderData!.state,
                          address: "",
                          code: value.countryCode
                      )
                  );
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) =>
                      FoloosiScreen(
                        orderData:
                        widget.orderData,
                        addressId: widget.addressId,
                        userId: value.id,
                      )
                  ));
                });
              }
          ),
          ListTile(
              title: customText("Cash",
                  color: customTextColor, fontWeight: FontWeight.w600),
              leading: Icon(
                Icons.money,
                color: HexColor("#40BFFF"),
              ),
              onTap: () {
                getUserDate().then((value) async {
                  getExploreItem(Localizations
                      .localeOf(context)
                      .languageCode
                      , widget.orderData!.orderId,
                      value.id,
                      "cash",
                      widget.addressId,
                     value.email);
                });
              }
          ),
        ],
      ),
    );
  }
}
