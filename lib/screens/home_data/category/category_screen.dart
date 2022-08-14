import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_cubit.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_state.dart';
import 'package:gnon/screens/home_data/you_may_like.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/widget.dart';
import '../../../localization/localization_constants.dart';
import '../../../models/product_model.dart';
import '../../../sharedPreferences.dart';

class CategoryScreen extends StatefulWidget {
   CategoryScreen(this.myContext,this.lang,/*this.id,this.name,*/
       this.phone,
       {Key? key}) : super(key: key);
   String? lang;
   var myContext;
   /*String? name;*/
   String? phone;
   /*int id;*/

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _scaffoldKey=GlobalKey<ScaffoldState>();
  int isSelected=1;
  @override
  Widget build(BuildContext context) {
    List<String> list=[
      getTranslated(context,  "High Rated ",)!,
      getTranslated(context,  "Lowest Rated ",)!,
      getTranslated(context,  "High Price ",)!,
      getTranslated(context,  "Lowest Price ",)!,
      getTranslated(context,  "Recently Added ",)!,
    ];
    return BlocProvider(
      create: (context)=>CategoryCubit(),/*..getProCat(widget.lang,widget.id),*/
      child: BlocConsumer<CategoryCubit,CategoryState>(
        builder: (context, state) {
          /*var categoryProductList = CategoryCubit.get(context).categoryProductList;*/
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
          List<ProductsModel> productListk=[
            pro,
            pro,
            pro,
            pro,
            pro,
          ];
        return  Scaffold(
          key: _scaffoldKey,
          /*bottomNavigationBar: connectWithUsWhatsApp(context,widget.phone),*/
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                _scaffoldKey.currentState!.showBottomSheet(
                      (BuildContext context) {
                    return Container(
                      height: 250,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                isSelected = index;
                                Navigator.pop(context);
                                print(list[index]);
                              },
                              child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: customText(list[index],
                                          fontWeight: FontWeight.bold,
                                          size: 14),
                                    ),
                                    Spacer(),
                                    isSelected == index ?
                                    Icon(
                                        Icons.check_box)
                                        : Icon(
                                        Icons.check_box_outline_blank),
                                    SizedBox(width: 30,),
                                  ],
                                ),
                              ),
                            );
                          }, itemCount: 5,
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return Container(
                              height:1,
                              color: Colors.black,
                            );
                          },),
                      ),
                    );
                  },
                );
              },
                icon: Icon(CupertinoIcons.slider_horizontal_3),),
              SizedBox(width: 10,),
            ],
            backgroundColor: Colors.white,
            /*leading: IconButton(onPressed: () {

              MySharedPreferences().getUserUserEmail().then((value) {
                Navigator.pushAndRemoveUntil(widget.myContext, MaterialPageRoute(builder:
                    (context)=>HomeScreen(Localizations.localeOf(context).languageCode,0
                  ,email: value,)), (route) => false);
              });
            },
                icon:
            Icon(
              Icons.arrow_back_ios, size: 14, color: HexColor("#9098B1"),)),*/
            elevation: 1,
            centerTitle: false,
            title: customText(
                "moaomo"/*widget.name!*/
                ,
                max: 1, overflow: TextOverflow.ellipsis,
                color: customColor,
                fontWeight: FontWeight.bold
            ),
          ),
          body: /*state is GetLoadingProductCategoryState?
          const Center(
            child:  SpinKitChasingDots(
              color: customColor,
              size: 40,
            ),
          ):*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: /*categoryProductList.isEmpty?
                Center(child: Text("No Product",style:
                TextStyle(color: customColor,fontWeight: FontWeight.bold,fontSize: 18),)):*/
            YouMayLikeHome(widget.myContext,productListk),
          ),
        );


          /*WillPopScope(
          *//*onWillPop: () async {
            MySharedPreferences().getUserUserEmail().then((value) {
              Navigator.pushAndRemoveUntil(widget.myContext,
                  MaterialPageRoute(builder:
                      (context)=>HomeScreen(
                    Localizations.localeOf(context).languageCode,0,
                    email: value,
                  )), (route) => false);
            });
            return true;
          },*//*
          child:
        )*/
        },
        listener: (context,state){},
      )
    );
  }
}
