import 'package:flutter/material.dart';
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/home_data/card_home.dart';

class FlashSale extends StatefulWidget {
   FlashSale(this.myContext,this.list,{Key? key}) : super(key: key);
   var myContext;
  List<ProductsModel> list;
  @override
  _FlashSaleState createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3.4,
      child: categoresGridView(widget.list, context),
    );
  }
  categoresGridView(List<ProductsModel> list, BuildContext context) {
    return ListView.separated(
      itemCount: list.length <6?list.length:6,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return  CardHome(widget.myContext,list: list,index: index,);
      }, separatorBuilder: (BuildContext context, int index) {
      return SizedBox(width: 10,);
    },);

  }
}