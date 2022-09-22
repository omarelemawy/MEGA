
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/screens/explore/explore_bloc/explore_cubit.dart';
import 'package:gnon/screens/explore/explore_bloc/explore_state.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/color_constans.dart';
import '../../constants/themes.dart';
import '../../localization/localization_constants.dart';
import '../../models/product_model.dart';
import '../home_data/you_may_like.dart';

class ExploreScreen extends StatefulWidget {
   ExploreScreen(this.myContext,this.name,{Key? key}) : super(key: key);
   String name;
   var myContext;
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  var _scaffoldKey=GlobalKey<ScaffoldState>();
  int isSelected=1;
  TextEditingController searchController=TextEditingController ();
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
      create: (context)=>ExploreCubit()..getExplore(widget.name),
      child: BlocConsumer<ExploreCubit,ExploreState>(
        builder: (context,state){
          var productList = ExploreCubit.get(context).productList;

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: customText(
                  getTranslated(context,  "Search Results ",)!,
                  color: HexColor("#000000"),fontWeight: FontWeight.bold,
                  max: 1,overflow: TextOverflow.ellipsis
              ),
              centerTitle: false,

              leading: IconButton(onPressed: (){
                MySharedPreferences().getUserUserEmail().then((value) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder:
                          (context)=>HomeScreen(
                        0,
                        email: value,
                      )), (route) => false);
                });
              },
                  icon: Icon(Icons.arrow_back_ios,color: HexColor("#9098B1"),size: 15,)),

              actions: [
                IconButton(onPressed: (){
                  _scaffoldKey.currentState!.showBottomSheet(
                        (BuildContext context) {
                      return Container(
                        height: 250,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(itemBuilder: (context,index){

                            return  GestureDetector(
                              onTap: (){
                                isSelected=index;
                                Navigator.pop(context);
                                print(list[index]);
                              },
                              child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: customText(list[index],
                                          fontWeight: FontWeight.bold,size: 14),
                                    ),
                                    Spacer(),
                                    isSelected==index?Icon(Icons.check_box)
                                        :Icon(Icons.check_box_outline_blank)
                                  ],
                                ),
                              ),
                            );
                          },itemCount: 5,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                height: 0,
                                color: Colors.black,
                              );
                            },),
                        ),
                      );
                    },
                  );
                }, icon: Icon(CupertinoIcons.slider_horizontal_3),),
                SizedBox(width: 10,),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: state is GetLoadingExploreState?
              const Center(
                child:  SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                ),
              ):
              YouMayLikeHome(context,productList),
            ),
          );
        },
        listener: (context,state){

        },
      ),
    );
  }
}
