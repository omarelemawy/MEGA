import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/home_data/favorite_list/bloc/fav_cubit.dart';
import 'package:gnon/screens/home_data/favorite_list/bloc/fav_state.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/color_constans.dart';
import '../../../constants/themes.dart';
import '../../../constants/widget.dart';
import '../../../localization/localization_constants.dart';
import '../../../sharedPreferences.dart';
import '../../home/home_screen.dart';
import '../item_details_screen.dart';

class FavoriteListScreen extends StatefulWidget {
   FavoriteListScreen(this.lang,this.myContext,{Key? key})
       : super(key: key);
   String lang;
   var myContext;
  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  var ima="https://megamatgr.com/wp-content/uploads/2022/07/2cc434a0-e78c-4145-bb02-bb3910624bad-300x300.jpg";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => FavCubit()/*..getProdFav(widget.lang)*/,
  child: BlocConsumer<FavCubit, FavState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    /*var productList = FavCubit.get(context).productList;*/
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
        elevation: 1,
        title: customText(
            getTranslated(context, "Favorite List",)!,
            color: HexColor("#50555C"),fontWeight: FontWeight.bold,
            max: 1,overflow: TextOverflow.ellipsis
        ),
        centerTitle: false,
        /*leading: IconButton(onPressed: (){
          Navigator.pushAndRemoveUntil(widget.myContext,
              MaterialPageRoute(builder:
                  (context)=>HomeScreen(
                Localizations.localeOf(context).languageCode,0,
                email: "",
              )), (route) => false);
          MySharedPreferences().getUserUserEmail().then((value) {

          });
        },
            icon: Icon(Icons.arrow_back_ios,color: HexColor("#9098B1"),size: 15,)),*/
      ),
      body:
      /*state is GetLoadingFavState?const
      Center(
        child:  SpinKitChasingDots(
          color: customColor,
          size: 40,
        ),
      ):
      FavCubit.get(context).productList.isEmpty?
          const Center(
            child: Text(
              "No Fav Data",
              style: TextStyle(
                color: customColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ):*/
        categoresGridView(productListk, context),
    );
  },
),
);
  }
  categoresGridView(List<ProductsModel> list, BuildContext context) {
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
    List<ProductsModel> productListk=[
      pro,
      pro,
      pro,
      pro,
      pro,
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: productListk.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisExtent:MediaQuery.of(context).size.height/4
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
            },
            child: CardFavorite(widget.myContext,list: productListk,index: index,),
          );
        },
      ),
    );
  }
}
class CardFavorite extends StatefulWidget {
  CardFavorite(this.myContext,{Key? key,this.list,this.index}) : super(key: key);
  List<ProductsModel>? list;
  var myContext;
  int? index;
  @override
  _CardFavoriteState createState() => _CardFavoriteState();
}

class _CardFavoriteState extends State<CardFavorite> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
            ItemDetailsScreen(
              widget.myContext,
             widget. list![widget.index!].id!,
              Localizations.localeOf(context).languageCode
            )),(_)=>false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 145,
                width: MediaQuery.of(context).size.width/2.1,
                child: customCachedNetworkImage(
                  boxFit: BoxFit.cover,
                  context: context,
                  url: widget.list![widget.index!].photos![0].url,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(onPressed: (){
                  MySharedPreferences().getUserId().then((value) {
                    FavCubit.get(context).makeDisLikeProduct(
                        widget.list![widget.index!].id!,
                        value,
                        Localizations.localeOf(context).languageCode
                    );
                  });

                    print("isLiked");
                }, icon:
                const DecoratedIcon(
                Icons.delete_outline ,
                  color: Colors.white,
                  size: 20.0,
                  shadows: const[
                    BoxShadow(
                      blurRadius: 12.0,
                      color: customColor,
                    ),
                    BoxShadow(
                      blurRadius: 12.0,
                      color: customColor,
                      offset:  Offset(0, 6.0),
                    ),
                  ],
                )),
              ),
            ],
          ),
          const SizedBox(height: 5,),
           SizedBox(
            width: 90,
            child:  Text(
              widget.list![widget.index!].name!,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: customTextColor,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: widget.list![widget.index!].price == null ?
            Container() :
            Text(
              widget.list![widget.index!].offer == null ?
              widget.list![widget.index!].price! :
              widget.list![widget.index!].offer!,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis
              ),
            ),
          ),
          const SizedBox(height: 5,),
          widget.list![widget.index!].offer == null ?
          Container() :
          Row(
            children: [
              SizedBox(
                child: Text(
                  widget.list![widget.index!].price!,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: HexColor("#9098B1"),
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      decoration: TextDecoration.lineThrough
                  ),
                ),
              ),
              const SizedBox(width: 8,),
              SizedBox(
                child: Text(
                  "${getOffer(widget.list![widget.index!].offer!,
                      widget.list![widget.index!].price!)} % Off"
                  ,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: HexColor("#FB7181"),
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  double getOffer(String offer, String price) {
    return ((int.parse(price) - int.parse(offer)) /
        int.parse(price)) * 100;
  }
}

