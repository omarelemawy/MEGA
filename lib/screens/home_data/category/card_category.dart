
import 'package:flutter/material.dart';
import 'package:gnon/models/category_model.dart';

import '../../../constants/color_constans.dart';
import '../../../constants/widget.dart';
import 'category_screen.dart';

class CardCategory extends StatefulWidget {
  CardCategory(this.myContext,lang,this.phone,
      {Key? key,this.list,this.index}) : super(key: key);
  List<CategoryListModel>? list;
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
                (context)=>CategoryScreen(widget.myContext
                    ,widget.list![widget.index!].id!,
                    widget.list![widget.index!].name,
                   widget.phone))
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
                child: widget.list![widget.index!].image==null?
                    Container():
                customCachedNetworkImage(
                  boxFit: BoxFit.scaleDown,
                  context: context,
                  url: widget.list![widget.index!].image!.src,
                ),
              ),

            ],
          ),
          const SizedBox(height: 10,),
           SizedBox(
            width: 90,
            child: Center(
              child: Text(
                widget.list![widget.index!].name!,
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