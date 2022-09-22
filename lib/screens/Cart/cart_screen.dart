import 'package:decorated_icon/decorated_icon.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/Cart/address_bloc/address_bloc.dart';
import 'package:gnon/screens/Cart/ship_to_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../models/cart_data_model.dart';
import '../../sharedPreferences.dart';
import '../auth/login/login_screen.dart';
import '../home/home_screen.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
   CartScreen(this.mycontext,this.phone,{Key? key}) : super(key: key);

  var mycontext;
   String phone;
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController couponTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AddressCubit()
        ..getCartData(),
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cartDataModel = AddressCubit
              .get(context)
              .cartDataModel;
          return  WillPopScope(child:  AddressCubit
              .get(context)
              .isLogin == true ?
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: customText(
                "سله التسوق"
                  /*getTranslated(context, "Your Cart",)!*/
                  ,
                  color: customTextColor, fontWeight: FontWeight.bold),
              centerTitle: false,
            ),
            body: state is GetLoadingCartDateState ?
            cartDataModel!.isEmpty ?
            const Center(
              child: SpinKitChasingDots(
                color: customColor,
                size: 40,
              ),
            ) :
            const Center(
              child: SpinKitChasingDots(
                color: customColor,
                size: 40,
              ),
            ) :
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AddressCubit
                  .get(context)
                  .cartModel == null ?
              const Center(
                child: SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                ),
              ) :
              SingleChildScrollView(
                child:  AddressCubit
                    .get(context)
                    .cartDataModel!
                    .isEmpty ?
                Container(
                  child: Center(
                    child: Column(

                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height/4,),
                        Image.asset("lib/images/cart_empty.png"),
                        SizedBox(height: 40,),
                        Text("سله التسوق فارغه",style:
                        TextStyle(color:
                        customColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),),
                      ],
                    ),
                  ),
                ) :
                Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CartItem(cartDataModel, index),
                          ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartDataModel!.length,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /*AddressCubit.get(context).cartDataModel!.isEmpty?
                  Container():*/
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.2,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (val) =>
                          val!.isEmpty ?
                          getTranslated(context, "please Enter Cupon",)!
                              : null,
                          controller: couponTextEditingController,
                          decoration: InputDecoration(
                              labelText: getTranslated(
                                context, "Enter Cupon Code",)!,
                              contentPadding: const EdgeInsets.all(10),
                              suffixIcon: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)
                                    )
                                ),
                                child: state is GetLoadingCouponCartDateState?
                                const Center(
                                  child:  SpinKitChasingDots(
                                    color: customColor,
                                    size: 40,
                                  ),
                                ): MaterialButton(onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    MySharedPreferences.getUserGetToken().then((value) {
                                      AddressCubit.get(context).
                                      checkCupounItemCart(
                                          value,
                                          couponTextEditingController.text
                                      );
                                    });
                                    couponTextEditingController.clear();
                                  }
                                },
                                  minWidth: 100,
                                  color: HexColor("#44c718"),
                                  child: Text(
                                    getTranslated(context, "Apply",)!
                                    , style: const TextStyle(color:
                                  Colors.white),
                                  ),),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /*AddressCubit.get(context).cartDataModel!.isEmpty?
                 Container(
                  height: 400,
                 child: Center(
                  child: Text(getTranslated(context, "No Orders")!,
                    style: TextStyle(
                    color: customColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                ),
              ):*/
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: HexColor("#EBF0FF"))
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                customText(
                                    getTranslated(context, "Items",)!
                                    , color: HexColor("#9098B1"),
                                    size: 12),
                                customText(
                                    AddressCubit.get(context).cartModel!.itemsCount.toString()
                                    , color: HexColor("#9098B1"),
                                    size: 12),
                                const Spacer(),
                                customText(
                                    "ر.س ${ AddressCubit.get(context).cartModel!.totals!.totalPrice}"
                                    , color: customTextColor,
                                    size: 12),
                              ],
                            ),
                          ),
                          /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          customText(getTranslated(context, "Shipping",)!
                              ,color: HexColor("#9098B1"),
                              size: 12),
                          const Spacer(),
                          customText("\$41.86",color: customTextColor,
                              size: 12),
                        ],
                      ),
                    ),*/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                customText(
                                    getTranslated(context, "Discount",)!

                                    , color: HexColor("#9098B1"),
                                    size: 12),
                                const Spacer(),
                                customText(
                                    "ر.س ${ AddressCubit.get(context).
                                    cartModel!.totals!.totalDiscount}"
                                    , color: customTextColor,
                                    size: 12),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: List.generate(150 ~/ 1.5, (index) =>
                                Expanded(
                                  child: Container(
                                    color: index % 2 == 0 ? Colors.transparent
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
                                    getTranslated(context, "Total Price",)!
                                    , color: customTextColor,
                                    size: 12),
                                const Spacer(),
                                customText(
                                    "ر.س ${
                                        AddressCubit.get(context).cartModel!.totals!.totalPrice!
                                    }"
                                    , color: HexColor("#40BFFF"),
                                    size: 12),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerFloat,
            /*bottomNavigationBar: connectWithUsWhatsApp(context,widget.phone),*/
            floatingActionButton: AddressCubit
                .get(context)
                .cartDataModel!
                .isEmpty ?
            Container() :
            customFloatingActionButton(
                context,
                text: getTranslated(context, "Check Out",)!,
                color: HexColor("#44c718")
                , onPress: () {
              MySharedPreferences().getUserId().then((value) {
                print(value);
              });
              pushNewScreen(
                context,
                screen: CheckOutScreen(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }),
          ) :

          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                title: customText(

                    getTranslated(context, "Your Cart",)!
                    ,
                    color: customTextColor, fontWeight: FontWeight.bold),
                centerTitle: false,
              ),
              body: Container(
                padding: const EdgeInsets.all(30),
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const SizedBox(
                        height: 10,
                      ),
                      customText(
                          getTranslated(context, "You Want To Login",)!
                          ,
                          color: customTextColor,
                          fontWeight: FontWeight.bold,
                          size: 16),
                      const SizedBox(
                        height: 60,
                      ),
                      Material(
                        elevation: 5,
                        child: Container(
                          width:
                          MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              color: HexColor("#087DA9"),
                              border: Border.all(
                                  color: customTextColor
                                      .withOpacity(.2)),
                              borderRadius:
                              BorderRadius.circular(4)),
                          child: MaterialButton(
                            onPressed: () {
                              print("object");
                              Navigator.pushAndRemoveUntil(widget.mycontext,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                      (route) => false);
                            },
                            child: customText(
                                getTranslated(context, "Sign In",)!
                                ,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
          ),
             onWillPop: () async {
            MySharedPreferences().getUserUserEmail().then((value) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder:
                      (context) =>
                      HomeScreen(
                         0,
                        email: value,
                      )), (route) => false);
            });
            return true;
          });
        },
      ),
    );
  }
}


class CartItem extends StatefulWidget {
  CartItem(this.cartDataModel,this.index,{Key? key}) : super(key: key);
  List<ItemsOfCart>? cartDataModel;
  int index;
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  var _itemCount=1;

  @override
  Widget build(BuildContext context) {
    print(widget.cartDataModel!.length);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: HexColor("#EBF0FF")),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 80,
              width: 80,
              child: customCachedNetworkImage(
                boxFit: BoxFit.fill,
                url: widget.cartDataModel![widget.index].images![0].src,
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
                      flex: 6,
                      child: ExpandableText(
                        widget.cartDataModel![widget.index].name!,
                        expandText: 'show more',
                        collapseText: 'show less',
                        expandOnTextTap: true,
                        maxLines: 2,
                        style: const TextStyle(
                            color: customTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        linkColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      flex: 1,
                      child: LikeButton(
                        size: 20,
                        isLiked: false,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        circleColor:
                        const CircleColor(start: Color(0xff00ddff),
                            end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          print(isLiked.toString());
                          return DecoratedIcon(
                            isLiked ? Icons.favorite : Icons.favorite_outline,
                            color: isLiked ? HexColor("#FB7181") :
                            Colors.grey,
                            size: 20.0,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              MySharedPreferences.getUserGetToken().then((value) {
                                print(value);
                                AddressCubit.get(context).deleteItemCart(
                                    Localizations
                                        .localeOf(context)
                                        .languageCode,
                                    value,
                                    widget.cartDataModel![widget.index].key
                                );
                              });
                            });
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: HexColor("#9098B1"),
                          ),
                        )),
                  ],
                ),

                /* Text(widget.index==0?
                getTranslated(context, "Hard Copy")!:
                getTranslated(context, "PDF")!
                  ,),*/
                const SizedBox(height: 20,),
                widget.cartDataModel![widget.index].prices!.salePrice == null ?
                Container() :
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    SizedBox(
                      child: Text(
                        "${widget.cartDataModel![widget.index].prices!
                            .regularPrice!} SAR",
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
                    const SizedBox(width: 10,),
                    SizedBox(
                      child: Text(
                        "${getOffer(widget.cartDataModel![widget.index].prices!
                            .salePrice!,
                            widget.cartDataModel![widget.index].prices!
                                .regularPrice!)} % Off",
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: HexColor("#FB7181"),
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 020,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    widget.cartDataModel![widget.index].prices!.regularPrice ==
                        null ?
                    Container() : SizedBox(
                      width: 90,
                      child: Text(
                        widget.cartDataModel![widget.index].prices!.salePrice ==
                            null ?
                        "${widget.cartDataModel![widget.index].prices!
                            .regularPrice!} SAR" :
                        "${widget.cartDataModel![widget.index].prices!
                            .salePrice} SAR",
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor("#EBF0FF"),),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: <Widget>[
                          InkWell(child: const Icon(Icons.remove),
                            onTap: () =>
                            widget.cartDataModel![widget.index].quantity
                                == 1 ? setState(() {
                              print("sdgdsgsdgeds");

                              MySharedPreferences.getUserGetToken().then((value) {
                                AddressCubit.get(context).deleteItemCart(
                                    Localizations
                                        .localeOf(context)
                                        .languageCode,
                                    value,
                                    widget.cartDataModel![widget.index].key
                                );
                              });
                            }) :
                            setState(() {
                              _itemCount =
                                  widget.cartDataModel![widget.index]
                                      .quantity! - 1;
                              MySharedPreferences.getUserGetToken().then((value) {
                                AddressCubit.get(context).addQuantityItem(
                                    Localizations
                                        .localeOf(context)
                                        .languageCode,
                                    value,
                                    widget.cartDataModel![widget.index].key,
                                    _itemCount
                                );
                              });
                            }),),
                          /*IconButton(icon:  Icon(Icons.remove),
                            onPressed: ()=>_itemCount !=0?setState(()=>_itemCount--):(){},),*/
                          const SizedBox(width: 5,),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 5,
                                  horizontal: 15),
                              decoration: BoxDecoration(
                                color: HexColor("#EBF0FF"),
                              ),
                              child: Text(widget.
                              cartDataModel![widget.index].
                              quantity.toString())),
                          const SizedBox(width: 5,),
                          InkWell(
                              child: const Icon(Icons.add, size: 20,),
                              onTap: () =>
                                  setState(() {
                                    print("$_itemCount  kbpodsbjdsopbijsbgopisdbgjio");
                                    _itemCount =
                                        widget.cartDataModel![widget.index]
                                            .quantity! + 1;
                                    print("$_itemCount  bibhjuhusgaudguagdua");
                                    MySharedPreferences.getUserGetToken().
                                    then((value) {
                                      AddressCubit.get(context)
                                          .addQuantityItem(
                                          Localizations
                                              .localeOf(context)
                                              .languageCode,
                                          value,
                                          widget.cartDataModel![widget.index]
                                              .key,
                                          _itemCount
                                      );
                                    });
                                  })),
                        ],
                      ),
                    ),

                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  String getOffer(String offer, String price) {
    return (((int.parse(price) - int.parse(offer)) /
        int.parse(price)) * 100).toStringAsFixed(1);
  }
}
