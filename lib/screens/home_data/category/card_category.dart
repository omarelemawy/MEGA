
import 'package:flutter/material.dart';
import 'package:gnon/models/category_model.dart';

import '../../../constants/color_constans.dart';
import '../../../constants/widget.dart';
import 'category_screen.dart';

class CardCategory extends StatefulWidget {
  CardCategory(this.myContext,lang,this.phone,
      {Key? key,this.list,this.index}) : super(key: key);
  List<Category>? list;
  String? lang;
  String? phone;
  var myContext;
  int? index;
  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.push(widget.myContext,
            MaterialPageRoute(builder:
                (context)=>CategoryScreen(widget.myContext,Localizations.localeOf(context).languageCode
                    /*,widget.list![widget.index!].id!,
                    widget.list![widget.index!].name,*/
                   , widget.phone))
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: customCachedNetworkImage(
                  boxFit: BoxFit.cover,
                  context: context,
                  url: "https://megamatgr.com/wp-content/uploads/2022/07/%D8%A7%D9%84%D8%B9%D9%86%D8%A7%D9%8A%D8%A9-%D8%A7%D9%84%D8%B4%D8%AE%D8%B5%D9%8A%D8%A9-1.png",
                ),
              ),

            ],
          ),
          const SizedBox(height: 10,),
           SizedBox(
            width: 90,
            child: Center(
              child: Text(
                /*widget.list![widget.index!].name!*/"Category  Name ",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}