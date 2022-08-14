import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/constants/widget.dart';
import 'package:gnon/models/address_model.dart';
import 'package:gnon/models/order_data_model.dart';
import 'package:gnon/screens/Cart/add_address_screen.dart';
import 'package:gnon/screens/Cart/payment/select_payment_screen.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../localization/localization_constants.dart';
import '../home/home_screen.dart';
import 'address_bloc/address_bloc.dart';
import 'edit_address_screen.dart';

class ShipToScreen extends StatefulWidget {
   ShipToScreen(this.lang,{Key? key,this.withFloatingActionButton,this.orderData})
       : super(key: key);
  bool? withFloatingActionButton=true;
  String? lang;
  OrderData? orderData;
  @override
  _ShipToScreenState createState() => _ShipToScreenState();
}

class _ShipToScreenState extends State<ShipToScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AddressCubit()/*..getMyAddress(widget.lang)*/,
  child: BlocConsumer<AddressCubit, AddressState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    /*var addressList = AddressCubit.get(context).addressList;*/
    Country country=Country(
      id: 1,
      name: "Cairo",
    );
    Address address=Address(
        id: 1,
        country: country,
        city: country,
        governorate: country,
        postalCode: "124554",
        phone: "01015449367",
      address: "10 mohamed Mahmoud st."

    );
    List<Address>addressList =[
      address,
      address,
      address,
      address
    ];

    Widget deleteDialog(id)
    {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height:
                MediaQuery.of(context).size.height /
                    4,
              ),

              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#FB7181").withOpacity(.2),
                        blurRadius: 5.0,
                      ),
                    ]),
                child: Icon(
                  Icons.error,
                  color: HexColor("#FB7181"),
                  size: 50,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              customText(
                  getTranslated(context,  "Confirmation",)!
                  ,
                  fontWeight: FontWeight.bold, size: 18),
              const SizedBox(
                height: 10,
              ),
              customText(
                  getTranslated(context,  "Are you sure wanna delete address",)!,
                  color: customTextColor.withOpacity(.3),
                  fontWeight: FontWeight.bold,
                  size: 12),
              const SizedBox(
                height: 15,
              ),
              state is DeleteLoadingAddressState?
              const Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                ),
              ):
              Material(
                elevation: 5,
                child: Container(
                  width:
                  MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: HexColor("#087DA9"),
                      border: Border.all(
                          color: customTextColor
                              .withOpacity(.2)),
                      borderRadius:
                      BorderRadius.circular(4)),
                  child:
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      /*MySharedPreferences().getUserId().then((value) {
                        AddressCubit.get(context).deleteAddress(context,
                            id,value,widget.withFloatingActionButton);
                      });*/
                    },
                    child: customText(
                        getTranslated(context,  "Delete",)!,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: customTextColor
                            .withOpacity(.2)),
                    borderRadius:
                    BorderRadius.circular(4)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: customText(
                      getTranslated(context,  "Cancel",)!
                      ,
                      color:
                      customTextColor.withOpacity(.5),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget shipItem(List<Address>addressList,int  index) {

      return GestureDetector(
        onTap: () {
          setState(() {
            selected = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: selected == index
                      ? HexColor("#40BFFF").withOpacity(.05)
                      : HexColor("#9098B1").withOpacity(.01),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: selected == index
                      ? HexColor("#40BFFF")
                      : HexColor("#9098B1").withOpacity(.2))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(addressList[index].address!, fontWeight: FontWeight.bold),
              const SizedBox(
                height: 10,
              ),
              customText(
                  addressList[index].address!,
                  color: HexColor("9098B1"),
                  size: 12),
              const SizedBox(
                height: 10,
              ),
              customText(addressList[index].country!.name!, size: 12, color: HexColor("#9098B1")),
              const SizedBox(
                height: 10,
              ),
              customText(addressList[index].phone!, size: 12, color: HexColor("#9098B1")),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>EditAddressScreen(
                          Localizations.localeOf(context).languageCode,
                              addressList[index].id!,
                            withFloatingActionButton: widget.withFloatingActionButton,
                      )));
                    },
                    color: HexColor("#50555C"),
                    child: customText(
                        getTranslated(context,  "Edit",)!,
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return deleteDialog(addressList[index].id);
                            });
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: HexColor("#50555C").withOpacity(.5),
                      ))
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton:
      widget.withFloatingActionButton!?
      customFloatingActionButton(context, onPress: () {
        print(addressList[selected].id);
        print(widget.orderData!.orderId);


        widget.orderData=OrderData(
          orderId: widget.orderData!.orderId,
          orderAmount: widget.orderData!.orderAmount,
          orderDescription: widget.orderData!.orderDescription,
          currencyCode: "AED",
          country: "ARE",
          state: addressList[selected].city!.name,
          address: Address(
            address: addressList[selected].address
              ),
          customColor: "",
          customerUniqueReference: ""
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>
                SelectPaymentScreen(
                 orderData: widget.orderData,
                 addressId: addressList[selected].id,
                )));
      }, text:
      getTranslated(context,  "Next",)!,
      color: HexColor("#BA6400")):
      Container(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              MySharedPreferences().getUserUserEmail().then((value){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                    (context)=> HomeScreen(
                  Localizations.localeOf(context).languageCode,0,
                  email: value,
                )
                ), (route) => false);
              });

            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: HexColor("#9098B1"),
              size: 15,
            )),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        title: customText(
            getTranslated(context,  "Ship To",)!,
            color: customTextColor, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: AddAddressScreen(Localizations.localeOf(context).languageCode,
                  widget.orderData,
                  withFloatingActionButton: widget.withFloatingActionButton,

                  ),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              icon: Icon(
                Icons.add,
                color: HexColor("#40BFFF"),
              ))
        ],
      ),
      body:
      /*state is GetLoadingGetAddressListState?
      const Center(
        child: SpinKitChasingDots(
          color: customColor,
          size: 40,
        ),
      ):*/
      Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 80, left: 10, right: 10),
        child:
        /*addressList!.isEmpty?
            Center(
              child: Text(
              getTranslated(context, "You Don't have Address Yet")!
                ,style: TextStyle(color: customColor,fontSize: 18,
                  fontWeight: FontWeight.bold),),
            ):*/
        ListView.builder(
          itemBuilder: (context, index) {
            return shipItem(addressList,index);
          },
          itemCount: addressList.length,
        ),
      ),
    );
  },
),
);
  }
}
