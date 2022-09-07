import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import 'category/card_category.dart';

class HomeCategooriesBody extends StatelessWidget {

  HomeCategooriesBody(this.myContext,
      this.categoryList,
      this.lang,
      this.phone,
      {
    Key? key,
  }) : super(key: key);
  var myContext;
  String? lang;
  List<CategoryListModel> categoryList;
  String phone;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
          height: 140,
          child: categoresGridView(categoryList, context),
    );
  }

  categoresGridView(List<CategoryListModel> list, BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return CardCategory(myContext,lang,phone,list: list, index: index,);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 10,);
      },);
  }
}
