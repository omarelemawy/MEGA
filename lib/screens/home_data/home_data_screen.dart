
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/Cart/cart_screen.dart';
import 'package:gnon/screens/home_data/carouse_slider_home.dart';
import 'package:gnon/screens/home_data/you_may_like.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../sharedPreferences.dart';
import '../explore/coursesSearch.dart';
import '../home/home_screen.dart';
import 'category/all_category_list.dart';
import 'category/category_screen.dart';
import 'category_list.dart';
import 'flash_sale.dart';
import 'home_bloc/home_cubit.dart';
import 'home_bloc/home_state.dart';
import 'item_details_screen.dart';



class HomeDataScreen extends StatefulWidget {
   HomeDataScreen(this.myContext,
       this.phone,this.favList,{Key? key}) : super(key: key);
   var myContext;

   String phone;
   List favList;

  @override
  _HomeDataScreenState createState() => _HomeDataScreenState();
}

class _HomeDataScreenState extends State<HomeDataScreen> {
  double index=0;
  TextEditingController searchController=TextEditingController();
  var _formKey=GlobalKey<FormState>();
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getCat()..
      getProduct()
      ..getSettings()
        ..getProOffer()
        ..getproductsYouMayLike()..getCartData(),
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context,state){
          var categoryList = HomeCubit.get(context).categoryList;
          var productList = HomeCubit.get(context).productList;
          var settingsModel = HomeCubit.get(context).settingsModel;
          var productsOfferList = HomeCubit.get(context).productsOfferList;
          var productsYouMayLikeHome = HomeCubit.get(context).productsYouMayLikeHome;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 3,
                          child: TextField(
                            obscureText: true,
                            focusNode: this.passwordFocusNode,
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    /*settingsModel==null?
                    const Center(
                        child: SpinKitChasingDots(
                          color: customColor,
                          size: 40,
                        )):*/
                    Container(
                    decoration: BoxDecoration(
                      /*image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            settingsModel.data!.homeBg!,
                          )
                      )*/
                  ),
                    child:Column(
                    children: [
                      const SizedBox(height: 10,),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex:8,
                              child: productList.isEmpty?
                              const Center(
                                  child:  SpinKitChasingDots(
                                    color: customColor,
                                    size: 40,
                                  )):
                              Form(
                                  key: _formKey,
                                  child:
                                   productList.isEmpty?
                              const Center(
                                child:  SpinKitChasingDots(
                                  color: customColor,
                                  size: 40,
                                )):
                                  InkWell(
                                    onTap: () {
                                      showSearch(
                                        context: context,
                                        delegate: CoursesSearch(productList
                                            ,widget.myContext),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius
                                            .circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Icon(Icons.search,
                                            color: Colors.black,),
                                          SizedBox(width: 20,),
                                          Text(
                                            "بحث",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "Poppins",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ),



                            Expanded(
                              flex:1,
                              child:
                              HomeCubit.get(context).isLogin!?
                              InkWell(
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen:
                                    CartScreen(widget.myContext,"0101012121"),
                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child:
                                HomeCubit.get(context).cartDataModel==null?
                                Container():
                                HomeCubit.get(context).cartDataModel!.length==0?
                                const Icon(CupertinoIcons.cart):
                                Badge(
                                  toAnimate: true,
                                  animationType: BadgeAnimationType.slide,
                                  shape: BadgeShape.circle,
                                  badgeColor: Colors.red,
                                  child: const Icon(CupertinoIcons.cart),
                                  borderRadius: BorderRadius.circular(10),
                                  badgeContent:
                                  customText(
                                      HomeCubit.get(context).cartDataModel!.
                                      length.toString()
                                      ,color: Colors.white,size: 14),
                                ),
                              ):
                              InkWell(
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen:
                                    CartScreen(widget.myContext,"0101012121"),
                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child:
                                const Icon(CupertinoIcons.cart),
                              ),
                            ),
                            const SizedBox(width: 10,)
                          ],
                        ),
                      ),
                      settingsModel==null?
                      const Center(
                          child: SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          )):
                      settingsModel.data!.slider!.isEmpty?
                      Container():
                      MyHomeCarouseSlider(widget.myContext,
                           items: settingsModel.data!.slider),
                       Row(
                        children: [
                           SizedBox(width: 10,),
                          customText( "التصنيفات"
                          /*getTranslated(context, "More Category",)!*/
                              ,color: customColor,
                              fontWeight: FontWeight.bold,size: 14),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              print(Localizations.localeOf(context).languageCode);
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context)=>AllCategoryList(
                                  widget.myContext,
                                  Localizations.localeOf(context).languageCode,
                                  "01015449367"
                              )));
                            },
                            child: customText(
                              "المزيد"  /*getTranslated(context, "See More",)!*/
                                ,color: customColor,
                                fontWeight: FontWeight.w500,size: 12),
                          ),
                          const SizedBox(width: 10,)
                        ],
                      ),
                       const SizedBox(height: 5,),
                       categoryList.isEmpty?
                       const Center(
                          child:  const SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          )):
                       HomeCategooriesBody(widget.myContext
                          ,categoryList,
                           "01015449367"
                       ),
                    ],
                  )

                ),


                    settingsModel==null?
                    const Center(
                        child: SpinKitChasingDots(
                          color: customColor,
                          size: 40,
                        )):
                    settingsModel.data!.homeAd!.image==""?
                        Container():
                    SizedBox(
                      child:
                      GestureDetector(
                        onTap: (){
                          if(settingsModel.data!.homeAd!.type=="section"){
                            Navigator.pushAndRemoveUntil(widget.myContext, MaterialPageRoute(builder:
                                (context)=>
                                CategoryScreen
                                  (widget.myContext,
                                    int.parse(settingsModel.data!.homeAd!.details!),
                                    "", "011202")
                            ), (route) => false);
                          }
                          else if(settingsModel.data!.homeAd!.type=="link") {
                            _launchUrl(settingsModel.data!.homeAd!.details);
                          }
                          else if(settingsModel.data!.homeAd!.type=="product") {
                            Navigator.pushAndRemoveUntil(widget.myContext, MaterialPageRoute(builder:
                                (context)=>
                                ItemDetailsScreen(widget.myContext,
                                    int.parse(settingsModel.data!.homeAd!.details!),
                                    Localizations.localeOf(context).languageCode)

                            ), (route) => false);
                          }
                          else if(settingsModel.data!.homeAd!.type=="offers") {
                            MySharedPreferences().getUserUserEmail().then((value){
                              Navigator.pushAndRemoveUntil(widget.myContext,
                                  MaterialPageRoute(builder:
                                  (context)=>
                                  HomeScreen(1,email:value,)

                              ), (route) => false);
                            });

                          }
                        /*  _launchUrl(settingsModel.data!.homeAd!.details);*/
                        },
                        child: Container(
                          height: 150,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: customCachedNetworkImage(
                            boxFit: BoxFit.fill,
                            context: context,
                            url:settingsModel.data!.homeAd!.image
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [

                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              customText(
                                "تخفيضات"  /*getTranslated(context, "Flash Sale",)!*/
                                  ,color: customColor,
                                  fontWeight: FontWeight.bold,size: 14),
                            ],
                          ),

                          const SizedBox(height: 5,),
                          HomeCubit.get(context).productsOfferList.isEmpty?
                          const Center(
                              child:  SpinKitChasingDots(
                                color: customColor,
                                size: 40,
                              )):
                          FlashSale(
                              widget.myContext,
                              productsOfferList,
                              widget.favList
                          ),

                          Row(
                            children: [
                              customText(
                                  getTranslated(context,  "You May Like",)!
                                  ,color: HexColor("#50555C"),
                                  fontWeight: FontWeight.bold,size: 14),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          productsYouMayLikeHome.isEmpty?
                          const Center(
                              child:  SpinKitChasingDots(
                                color: customColor,
                                size: 40,
                              )):
                          YouMayLikeHome(
                            widget.myContext,
                            productsYouMayLikeHome,
                            physics: const NeverScrollableScrollPhysics(),
                            favList: HomeCubit.get(context).favList,

                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
  void _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }
}
