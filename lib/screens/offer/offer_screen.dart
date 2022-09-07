
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/screens/offer/offer_bloc/offer_cubit.dart';
import 'package:gnon/screens/offer/offer_bloc/offer_state.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/color_constans.dart';
import '../../constants/themes.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../models/product_model.dart';
import '../home_data/you_may_like.dart';

class OfferScreen extends StatefulWidget {
   OfferScreen(this.myContext,this.lang,this.phone,{Key? key}) : super(key: key);
  String lang;
  var myContext;
   String phone;
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>OfferCubit()/*..getProOffer(widget.lang)*/,
      child: BlocConsumer<OfferCubit,OfferState>(
        builder: (context,state){
          var productsOfferList = OfferCubit.get(context).productsOfferList;
          var ima="https://megamatgr.com/wp-content/uploads/2022/07/2cc434a0-e78c-4145-bb02-bb3910624bad-300x300.jpg";
          var ima1="https://megamatgr.com/wp-content/uploads/2022/07/0289ab0c-ad6b-45d7-a818-18c64bbaeffe-300x300.jpeg";
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
                    url: ima1
                ),
                Photo(
                    name: "jgsiojg",
                    url: ima
                ),
                Photo(
                    name: "jgsiojg",
                    url: ima1
                ),
              ],
              price: "1000",
              offer: "223",
              isLiked: "1"
          );
          List<ProductsModel> productListk=[
            pro,
            pro,
            pro,
            pro,
            pro,
          ];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              /*leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:
              Icon(Icons.arrow_back_ios,size: 14,color: HexColor("#9098B1"),)),*/
              elevation: 1,
              centerTitle: false,
              title: customText(
                  getTranslated(context, "Offers",)!,
                  max: 1,
                  overflow: TextOverflow.ellipsis,
                  color: HexColor("#50555C"),
                  fontWeight: FontWeight.bold
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state is GetLoadingProductsOfferState?
              const Center(
                child:  SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                ),
              ):
                YouMayLikeHome(widget.myContext,productListk),
            ),
          );
        },
        listener: (context,state){},
      ),
    );
  }
}
