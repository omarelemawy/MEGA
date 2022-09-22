import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_cubit.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_state.dart';
import 'package:gnon/screens/home_data/you_may_like.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../constants/color_constans.dart';
import '../../../localization/localization_constants.dart';
import '../../../sharedPreferences.dart';
import '../../home/home_screen.dart';


class CategoryScreen extends StatefulWidget {
   CategoryScreen(this.myContext,this.id,this.name,
       this.phone,
       {Key? key}) : super(key: key);

   var myContext;
   String? name;
   String? phone;
   int id;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  int isSelected = 1;

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      getTranslated(context, "High Rated ",)!,
      getTranslated(context, "Lowest Rated ",)!,
      getTranslated(context, "High Price ",)!,
      getTranslated(context, "Lowest Price ",)!,
      getTranslated(context, "Recently Added ",)!,
    ];
    return BlocProvider(
        create: (context) => CategoryCubit()..getProCat( widget.
        id),
        child: BlocConsumer<CategoryCubit, CategoryState>(
          builder: (context, state) {
            var categoryProductList = CategoryCubit
                .get(context)
                .categoryProductList;
            return WillPopScope(
              onWillPop: () async {
                MySharedPreferences().getUserUserEmail().then((value) {
                  Navigator.pushAndRemoveUntil(widget.myContext,
                      MaterialPageRoute(builder:
                          (context) =>
                          HomeScreen(0,
                            email: value,
                          )), (route) => false);
                });
                return true;
              },
              child: Scaffold(
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
                                    height: 1,
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
                  leading: IconButton(onPressed: () {
                    MySharedPreferences().getUserUserEmail().then((value) {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              HomeScreen( 0
                                , email: value,)), (route) => false);
                    });
                  },
                      icon:
                      Icon(
                        Icons.arrow_back_ios, size: 14,
                        color: HexColor("#9098B1"),)),
                  elevation: 1,
                  centerTitle: false,
                  title: customText(
                      widget.name!
                      ,
                      max: 1, overflow: TextOverflow.ellipsis,
                      color: HexColor("#50555C"),
                      fontWeight: FontWeight.bold
                  ),
                ),
                body: state is GetLoadingProductCategoryState ?
                const Center(
                  child: SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: categoryProductList.isEmpty?
                  Center(child:


                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/4,),
                      Image.asset("lib/images/no_product.png"),
                      SizedBox(height: 40,),
                      Text("انتظر عروضنا قريبا",style:
                      TextStyle(color:
                      customColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),),
                    ],
                  )):
                  YouMayLikeHome(widget.myContext, categoryProductList),
                ),
              ),
            );
          },
          listener: (context, state) {},
        )
    );
  }
}
