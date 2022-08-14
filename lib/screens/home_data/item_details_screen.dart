
import 'package:decorated_icon/decorated_icon.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/account/view_dialog.dart';
import 'package:gnon/screens/home_data/home_bloc/home_cubit.dart';
import 'package:gnon/screens/home_data/home_bloc/home_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import '../../constants/color_constans.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../models/product_detail_model.dart';
import '../../sharedPreferences.dart';
import '../home/home_screen.dart';
import 'reviews/all_review_screen.dart';
import 'carouse_slider_home.dart';
import 'flash_sale.dart';


class ItemDetailsScreen extends StatefulWidget {
   ItemDetailsScreen(this.myContext,this.id,this.lang,{Key? key}) : super(key: key);
  int id;
  String? lang;
  var myContext;

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var ima="https://megamatgr.com/wp-content/uploads/2022/07/2cc434a0-e78c-4145-bb02-bb3910624bad-300x300.jpg";

  @override
  Widget build(BuildContext context) {
    ProductsModel pro=ProductsModel(
        id: 1,
        name: "omatejijs",
        /*thumbnail: Thumbnail(
            name: "namejksdi",
            url: ima
        ),*/
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
    List<ProductsModel> productListk=[
      pro,
      pro,
      pro,
      pro,
      pro,
    ];
    return BlocProvider(
      create: (context)=>HomeCubit()/*..getProdDetails(widget.lang,widget.id)*/,
      child: BlocConsumer<HomeCubit,HomeState>(
        builder: (context,state){
          ProductDetailsModel? productDetails = HomeCubit.get(context).productDetails;
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            var useId = await MySharedPreferences().getUserId();
            if (useId != null&& useId != "") {
              if (isLiked) {
                HomeCubit.get(context).makeDisLikeProduct(
                    HomeCubit.get(context).productDetails!.data!.product!.id,
                    useId,
                    Localizations.localeOf(context).languageCode,
                    context
                );
                print("isLiked");
                return !isLiked;
              } else {
                HomeCubit.get(context).makeLikeProduct(
                    HomeCubit.get(context).productDetails!.data!.product!.id,
                    useId,
                    Localizations.localeOf(context).languageCode,
                    context
                );
                return !isLiked;
              }
            }else{
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return deleteDialog(context);
                  });
              return isLiked;
            }
          }
          return WillPopScope(
              onWillPop: () async {
                MySharedPreferences().getUserUserEmail().then((value) {
                  Navigator.pushAndRemoveUntil(widget.myContext,
                      MaterialPageRoute(builder:
                          (context)=>HomeScreen(
                        Localizations.localeOf(context).languageCode,0,
                        email: value,
                      )), (route) => false);
                });
                return true;
              },
            child: Scaffold(
              floatingActionButton:
              state is AddToCartLoadingProductDetailsState?
              const Center(
                  child:  SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  )):
              customFloatingActionButton(
              context,text:
              getTranslated(context,  "Add To Cart",)!,
                  color: HexColor("#BA6400"),
                  onPress:
                      (){
                MySharedPreferences().getUserId().then((value) {
                  if(value==""||value==null){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return deleteDialog(context);
                        });
                  }
                  else {
                    /*HomeCubit.get(context).addToCart(
                      Localizations
                          .localeOf(context)
                          .languageCode,
                      value,
                      productDetails!.data!.product!.id,
                      productDetails.data!.product!.price,
                      context
                    );*/
                  }
                });

              }),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                title: state is GetLoadingProductDetailsState?
                const Center(
                    child:  SpinKitChasingDots(
                      color: customColor,
                      size: 40,
                    )):
               /* productDetails==null?
                    Container():*/
              customText(
              "Product Name will dispaly here ",
                    color: customColor,fontWeight: FontWeight.bold,
                    max: 1,overflow: TextOverflow.ellipsis
                ),
                centerTitle: false,

                leading: IconButton(onPressed: (){
                  MySharedPreferences().getUserUserEmail().then((value) {
                    Navigator.pushAndRemoveUntil(widget.myContext,
                        MaterialPageRoute(builder:
                        (context)=>HomeScreen(
                      Localizations.localeOf(context).languageCode,0,
                      email: value,
                    )), (route) => false);
                  });

                },
                    icon: Icon(Icons.arrow_back_ios,color: HexColor("#9098B1"),size: 15,)),
              ),
              body: /*state is GetLoadingProductDetailsState?
              const Center(
                  child:  SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  )):
              productDetails==null?
              Container():*/
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*HomeCubit.get(context).photos!.isNotEmpty?*/
                    MyProductCarouseSlider(items:
                    [
                      "https://megamatgr.com/wp-content/uploads/2022/07/0b923ea9-1953-4e4f-90f6-1d00df803bba-300x300.jpg",
                      "https://megamatgr.com/wp-content/uploads/2022/07/474d8aa5-5876-44b7-9cac-c1a26f4170f1-300x300.jpg",
                      "https://megamatgr.com/wp-content/uploads/2022/07/474d8aa5-5876-44b7-9cac-c1a26f4170f1-300x300.jpg"
                    ],
                      autoPlay: false,margin: 0,)/*:Container()*/,

                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 010,),
                        Expanded(
                            flex: 10,
                            child:
                            ExpandableText(
                             "Product Name will dispaly here "
                              /*productDetails.data!.product!.name!*/,
                              expandText: getTranslated(context,  "show more",)!,
                              collapseText:
                              getTranslated(context,  "show less",)!,
                              expandOnTextTap: true,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                              linkColor: Colors.blue,
                            )
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 1,
                          child: LikeButton(
                            /*onTap: onLikeButtonTapped,*/
                            size: 20,
                            isLiked: false /*productDetails.data!.product!.isLiked=="0"?
                            false:true*/,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            circleColor:
                            const CircleColor(start:  Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor:  Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              print(isLiked.toString());
                              return DecoratedIcon(
                                isLiked ? Icons.favorite : Icons.favorite_outline,
                                color: isLiked ? HexColor("#FB7181") :
                                Colors.white,
                                size: 20.0,
                                shadows: const[
                                  BoxShadow(
                                    blurRadius: 12.0,
                                    color: customColor,
                                  ),
                                  BoxShadow(
                                    blurRadius: 12.0,
                                    color: customColor,
                                    offset:  Offset(0, 6.0),
                                  ),
                                ],
                              )
                              /*Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration:const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: .5,
                                      ),
                                    ]),child: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_outline,
                                color: isLiked ? HexColor("#FB7181") : Colors
                                    .grey[300],
                                size: 25,
                              ),)*/;
                            },
                          ),
                        ),
                        const SizedBox(width: 010,),
                      ],
                    ),
                    const SizedBox(height: 7,),
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        RatingStars(
                          editable: false,
                          rating: 3 /*productDetails.data!.reviewTotal!*/,
                          color: Colors.amber,
                          iconSize: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        /*productDetails.data!.product!.price==null?
                        Container():*/ SizedBox(
                          width: 90,
                          child: Text(
                            /*productDetails.data!.product!.offer==null?
                            "${productDetails.data!.product!.price!} AED":*/
                            "${32} AED",
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
                       /* productDetails.data!.product!.offer==null?
                        Container():*/
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            SizedBox(
                              child:  Text(
                                "${120/*productDetails.data!.product!.price!*/} AED",
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
                              child:  Text(
                                "${/*getOffer(productDetails.data!.product!.offer!,
                                    productDetails.data!.product!.price!)*/120} % Off",
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

                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10,),
                        customText(
                            getTranslated(context,  "Details",)!
                            ,
                            fontWeight: FontWeight.bold,
                            color: customColor),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ExpandableText(
                       "The Nike Air Max 270 React ENG combines a full-length React foam midsole with a 270 Max Air unit for unrivaled comfort and a striking visual experience."
                        /*productDetails.data!.product!.description!*/,
                        expandText: getTranslated(context,  "show more",)!,
                        collapseText: getTranslated(context,  "show less",)!,
                        expandOnTextTap: true,
                        maxLines: 4,
                        style: TextStyle(
                            color: HexColor("#9098B1"),
                            fontWeight: FontWeight.w300,
                            fontSize: 12
                        ),
                        linkColor: Colors.blue,
                      ),
                    ),

                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        customText(
                            getTranslated(context,  "Review Product",)!
                            ,fontWeight: FontWeight.bold),
                        const Spacer(),
                        InkWell(
                          onTap: (){
                            pushNewScreen(
                              context,
                              screen: ViewAllReviews(
                                  /*productDetails.data!.reviews*/
                                /*,
                                 productDetails.data!.product!.id*/
                              ),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );

                          },
                          child: customText(
                              getTranslated(context,  "See More",)!
                              ,fontWeight:
                          FontWeight.bold,color: customColor,
                              size: 12),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),


                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        RatingStars(
                          editable: false,
                          rating:4/*productDetails.data!.reviewTotal!*/,
                          color: Colors.amber,
                          iconSize: 20,
                        ),
                        const SizedBox(width: 10,),
                        customText(4/*productDetails.data!.reviewTotal!*/.toString(),
                            size: 10),
                        const SizedBox(width: 2,),
                        customText("(${4/*productDetails.data!.reviews!.length*/} Review)",size: 10)

                      ],
                    ),

                    const SizedBox(height: 10,),
                    /*productDetails.data!.reviews!.isNotEmpty?*/
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration:  const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: customCachedNetworkImage(
                            boxFit: BoxFit.cover,
                            context: context,
                            url:"https://megamatgr.com/wp-content/uploads/2022/07/799f2653-dd7a-4c2a-a7c2-c82ccb605101-300x300.jpg"
                            /*productDetails.data!.reviews![0].user!.photo*/,
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          children: [
                            customText(
                                "omarElem[dsgvolm"/*productDetails.data!.reviews![0].user!.name!*/,
                                fontWeight: FontWeight.bold,
                                size: 12),
                            const SizedBox(height: 5,),
                            RatingStars(
                              editable: false,
                              rating: double.parse("3"
                                /*productDetails.data!.reviews![0].rate!*/),
                              color: Colors.amber,
                              iconSize: 18,
                            ),
                          ],
                        )
                      ],
                    )/*:
                    Container()*/,

                    /*productDetails.data!.reviews!.isNotEmpty?*/
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpandableText(
                            " sneakers up a little bit, not sure if the box was always this small but the 90s are and will always be one of my favorites."
                            /*productDetails.data!.reviews![0].comment!*/,
                            expandText: getTranslated(context,   "show more",)!,
                            collapseText: getTranslated(context,    "show less",)!,
                            expandOnTextTap: true,
                            maxLines: 5,
                            style: TextStyle(
                                color: HexColor("#9098B1"),
                                fontWeight: FontWeight.w300,
                                fontSize: 12
                            ),
                            linkColor: Colors.blue,
                          ),
                          /*const SizedBox(height: 10,),
                          customText("December 10, 2016",size: 10,color:HexColor("#9098B1")),*/
                        ],
                      ),
                    )/*:
                    Container()*/,

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: customText(
                          getTranslated(context,"You Might Also Like",)!
                          ,fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FlashSale(widget.myContext,productListk),
                    ),
                    const SizedBox(height: 80,)
                  ],
                ),
              ),

            ),
          );
        },
        listener: (context,state){},
      ),
    );
  }
  double getOffer(String offer,String price)
  {
    return ((int.parse(price)-int.parse(offer))/
        int.parse(price)) * 100;
  }
}
