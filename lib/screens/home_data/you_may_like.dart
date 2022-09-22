import 'package:flutter/material.dart';
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/home_data/card_home.dart';

class YouMayLikeHome extends StatefulWidget {
   YouMayLikeHome(this.myContext,this.listProduct,{Key? key,this.physics,this.favList}) : super(key: key);
   List<ProductsModel> listProduct;
   List? favList;
  ScrollPhysics? physics;
  var myContext;
  @override
  _YouMayLikeHomeState createState() => _YouMayLikeHomeState();
}

class _YouMayLikeHomeState extends State<YouMayLikeHome> {
  @override
  Widget build(BuildContext context) {
    return categoresGridView(widget.listProduct, context);
  }
  categoresGridView(listProduct, BuildContext context) {
    return GridView.builder(
      itemCount: widget.listProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
          mainAxisExtent:MediaQuery.of(context).size.height/3.2
      ),
      scrollDirection: Axis.vertical,
      physics: widget.physics,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return CardHome(widget.myContext,
          list: listProduct,
          index: index,
          favList:widget.favList ,);
      },
    );
  }
}
