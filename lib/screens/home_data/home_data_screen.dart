
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/Cart/cart_screen.dart';
import 'package:gnon/screens/explore/explore_screen.dart';
import 'package:gnon/screens/home_data/carouse_slider_home.dart';
import 'package:gnon/screens/home_data/you_may_like.dart';
import 'package:gnon/screens/notification/notification_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:searchfield/searchfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../models/product_model.dart';
import '../../models/setting_model.dart';
import 'category/all_category_list.dart';
import 'category_list.dart';
import 'favorite_list/favorite_list_screen.dart';
import 'flash_sale.dart';
import 'home_bloc/home_cubit.dart';
import 'home_bloc/home_state.dart';

class HomeDataScreen extends StatefulWidget {
   HomeDataScreen(this.myContext,this.lang,this.phone,{Key? key}) : super(key: key);
   var myContext;
   String lang;
   String phone;

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
    print(widget.lang+"lllll");
    return BlocProvider(
      create: (context)=>HomeCubit()..getCat(widget.lang)..
      getProduct(widget.lang)..getSettings(widget.lang)..getProOffer(widget.lang),
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context,state){
          var categoryList = HomeCubit.get(context).categoryList;
          var productList = HomeCubit.get(context).ProductList;
          var settingsModel = HomeCubit.get(context).settingsModel;
          var ima="https://megamatgr.com/wp-content/uploads/2022/07/2cc434a0-e78c-4145-bb02-bb3910624bad-300x300.jpg";
          ProductsModel pro=ProductsModel(
              id: 1,
              name: "omatejijs",
              thumbnail: Thumbnail(
                name: "namejksdi",
                url: ima
              ),
              photos: [
                Photo(
                  name: "jgsiojg",
                  url: ima
                ),
                Photo(
                  name: "jgsiojg",
                  url: ima
                ),
                Photo(
                  name: "jgsiojg",
                  url: ima
                ),
                Photo(
                  name: "jgsiojg",
                  url: ima
                ),
              ],
            price: "1000",
            offer: "223",
            isLiked: "1"
          );
         var image="https://megamatgr.com/wp-content/uploads/2022/07/%D8%A7%D9%84%D8%B9%D9%86%D8%A7%D9%8A%D8%A9-%D8%A7%D9%84%D8%B4%D8%AE%D8%B5%D9%8A%D8%A9-530-%C3%97-260-px-530-%C3%97-260-px.png";
          List<MySlider>? slider=[
            MySlider(
              link: "",
              image: image
            ),
            MySlider(
              link: "",
              image: image
            ),
            MySlider(
              link: "",
              image: image
            ),
            MySlider(
              link: "",
              image: image
            ),
          ];
          List<ProductsModel> productListk=[
            pro,
            pro,
            pro,
            pro,
            pro,
          ];
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
                    /*decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            settingsModel.data!.homeBg!,
                          )
                      )
                  ),*/
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
                              child: Form(
                                  key: _formKey,
                                  child: productListk.isEmpty?
                                  const Center(
                                      child:  SpinKitChasingDots(
                                        color: customColor,
                                        size: 40,
                                      )):
                                  SearchField(
                                    suggestions: productListk.map((e) =>
                                        SearchFieldListItem(e.name!)).toList(),
                                    suggestionState: Suggestion.expand ,
                                    controller: searchController,
                                    textInputAction: TextInputAction.next,
                                    hint: getTranslated(context, "Search Product",)!
                                    ,
                                    onSubmit: (c){
                                      Navigator.push(widget.myContext,
                                          MaterialPageRoute(builder:
                                              (context)=> ExploreScreen(
                                              widget.myContext,
                                              widget.lang,c)));
                                    },
                                    hasOverlay: true,
                                    searchStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                    validator: (x) {
                                      if (productListk.contains(x) || x!.isEmpty) {
                                        return getTranslated(context, "Please Enter a valid Product",)!;
                                      }
                                      return null;
                                    },
                                    searchInputDecoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search,color: Colors.black,),
                                      fillColor: HexColor("#F3F3F3"),
                                      suffix: InkWell(onTap: (){
                                      setState(() {
                                        searchController.clear();
                                        FocusScope.of(context).requestFocus(this.passwordFocusNode);
                                        print("objectververvbe");
                                      });
                                      },child: Icon(Icons.cancel,color: customColor,)),
                                      filled: true,

                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:  BorderSide(color: customColor, width: 1.0),
                                      ),

                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    maxSuggestionsInViewPort: 6,

                                    onSuggestionTap: (x){
                                      Navigator.push(widget.myContext,
                                          MaterialPageRoute(builder:
                                              (context)=> ExploreScreen(
                                              widget.myContext,
                                              widget.lang,x.searchKey)));
                                    },
                                  )
                              ),
                            ),
                           /* Expanded(
                              flex:1,
                              child: IconButton(onPressed: (){
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context)=>FavoriteListScreen(
                                        Localizations.localeOf(context).languageCode,
                                        widget.myContext
                                    ),), (route) => false);

                              }, icon: const Icon(Icons.shopping_cart_outlined)),
                            ),
                            settingsModel==null?
                            Container():*/
                            Expanded(
                              flex:1,
                              child: InkWell(
                                onTap: (){
                                  pushNewScreen(
                                    context,
                                    screen:  CartScreen(context,widget.lang,"0101012121"),
                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child:/*settingsModel.data!.notificationsNumber==0?
                                const Icon(Icons.notifications_active_outlined):*/
                                Badge(
                                  toAnimate: true,
                                  animationType: BadgeAnimationType.slide,
                                  shape: BadgeShape.circle,
                                  badgeColor: Colors.red,
                                  child: const Icon(CupertinoIcons.cart),
                                  borderRadius: BorderRadius.circular(10),
                                  badgeContent:
                                  customText(
                                      "1",color: Colors.white,size: 14),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,)
                          ],
                        ),
                      ),
                       MyHomeCarouseSlider(items: slider),
                       Row(
                        children: [
                          const SizedBox(width: 10,),
                          customText(getTranslated(context, "More Category",)!
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
                                getTranslated(context, "See More",)!
                                ,color: customColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w200,size: 12),
                          ),
                          const SizedBox(width: 10,)
                        ],
                      ),
                       const SizedBox(height: 5,),
                       /*categoryList.isEmpty?
                       const Center(
                          child:  const SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          )):*/
                       HomeCategooriesBody(widget.myContext
                          ,categoryList,widget.lang,
                           "01015449367"
                       ),
                    ],
                  )

                ),


                    /*settingsModel==null?
                    const Center(
                        child: SpinKitChasingDots(
                          color: customColor,
                          size: 40,
                        )):*/
                    SizedBox(
                      child:
                      GestureDetector(
                        onTap: (){
                          /*_launchUrl(settingsModel.data!.homeBanner!.link);*/
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
                            url: "https://megamatgr.com/wp-content/uploads/2022/07/Untitled-design-73.png",
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
                                  getTranslated(context, "Flash Sale",)!
                                  ,color: customColor,
                                  fontWeight: FontWeight.bold,size: 14),
                            ],
                          ),

                          const SizedBox(height: 5,),
                          FlashSale(
                              widget.myContext,
                              productListk
                          ),

                          Row(
                            children: [
                              customText(
                                  getTranslated(context,  "You May Like",)!
                                  ,color: customColor,
                                  fontWeight: FontWeight.bold,size: 14),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          /*productList.isEmpty?
                          const Center(
                              child:  SpinKitChasingDots(
                                color: customColor,
                                size: 40,
                              )):*/

                          YouMayLikeHome(
                            widget.myContext,
                            productListk,
                            physics: const NeverScrollableScrollPhysics(),)
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
