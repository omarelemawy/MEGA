import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_cubit.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_state.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/widget.dart';
import '../../../models/category_model.dart';
import 'card_category.dart';

class AllCategoryList extends StatefulWidget {
   AllCategoryList(this.myContext,this.lang,this.phone,
       {Key? key}) : super(key: key);
   String lang;
   var myContext;
   String phone;
  @override
  _AllCategoryListState createState() => _AllCategoryListState();
}

class _AllCategoryListState extends State<AllCategoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CategoryCubit()..
      getCat(widget.lang),
      child: BlocConsumer<CategoryCubit,CategoryState>(
        builder: (context,state){
          /*var categoryList = CategoryCubit.get(context).categoryList;*/
          Category category=Category(
            id: 1,
            name: "omar",
            photo: "https://www.gettyimages.com/gi-resources/images/500px/983794168.jpg"
          );
          List<Category> list =[
            category,
            category,
            category,
            category,
            category,
            category,
          ];
          return /*CategoryCubit.get(context).categoryList.isEmpty?
          const Scaffold(body:   Center(
            child:  SpinKitChasingDots(
              color: customColor,
              size: 40,
            ),
          ),):*/
          Scaffold(
            /*bottomNavigationBar: connectWithUsWhatsApp(context,widget.phone),*/
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: customText("Categories",
                  color: customColor,fontWeight: FontWeight.bold,
                  max: 1,overflow: TextOverflow.ellipsis
              ),
              centerTitle: false,

              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },
                  icon: Icon(Icons.arrow_back_ios,color: HexColor("#9098B1"),size: 15,)),
            ),
            body: categoresGridView(list, context),
          );
        },
        listener: (context,state){
          },
      ),
    );
  }
  categoresGridView(List<Category> list, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            mainAxisExtent:MediaQuery.of(context).size.height/5
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
        return  CardCategory(widget.myContext,widget.lang,widget.phone,list: list,index: index,);        },
      ),
    );
  }
}
