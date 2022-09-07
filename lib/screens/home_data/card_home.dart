import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/home_data/home_bloc/home_cubit.dart';
import 'package:gnon/screens/home_data/home_bloc/home_state.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';

import '../../constants/color_constans.dart';
import '../../constants/widget.dart';
import '../account/view_dialog.dart';
import 'item_details_screen.dart';

class CardHome extends StatefulWidget {
  CardHome(this.myContext,{Key? key, this.list, this.index}) : super(key: key);
  var myContext;
  List<ProductsModel>? list;
  int? index;

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            var useId = await MySharedPreferences().getUserId();
            if (useId != null&& useId != "") {
              if (isLiked) {
                HomeCubit.get(context).makeDisLikeProduct(
                    widget.list![widget.index!].id!,
                    useId,
                    Localizations.localeOf(context).languageCode,
                    context
                );
                print("isLiked");
                return !isLiked;
              } else {
                print("isNotLiked");
                HomeCubit.get(context).makeLikeProduct(
                  widget.list![widget.index!].id!,
                  useId,
                  Localizations.localeOf(context).languageCode,context
                );
                return !isLiked;
              }
            }else{
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return deleteDialog(context);
                  });
              return isLiked;
            }
          }
          return InkWell(
            onTap: () {
              Navigator.push(widget.myContext, MaterialPageRoute(builder: (context) =>
                  ItemDetailsScreen(
                    widget.myContext,
                    widget.list![widget.index!].id!,
                    Localizations
                        .localeOf(context)
                        .languageCode,))/*,(_)=>false*/);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Stack(
                  children: [
                    widget.list![widget.index!].photos!.isEmpty ?
                    Container(
                      height: MediaQuery.of(context).size.height/3,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2.1,
                      child: Image.asset("lib/images/gnon-red-logo.png"),
                    ) :
                    Container(
                      height:MediaQuery.of(context).size.height/5.5,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2.1,
                      child: customCachedNetworkImage(
                        boxFit: BoxFit.cover,
                        context: context,
                        url: widget.list![widget.index!].photos![0].url,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LikeButton(
                          /*onTap: onLikeButtonTapped,*/
                          size: 20,
                          isLiked: false
                          /*widget.list![widget.index!].isLiked=="0"?false:true*/,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          circleColor:
                          const CircleColor(start:  Color(0xff00ddff),
                              end: Color(0xff0099cc)),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor:  Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            print(isLiked.toString());
                            return DecoratedIcon(
                              isLiked ? Icons.favorite : Icons.favorite_outline,
                              color: isLiked ? HexColor("#FB7181") :
                              Colors.white,
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
                            )
                              /*Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration:const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: .5,
                                    ),
                                  ]),child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_outline,
                              color: isLiked ? HexColor("#FB7181") : Colors
                                  .grey[300],
                              size: 25,
                            ),)*/;
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5,),
                SizedBox(
                  width: 90,
                  child: widget.list![widget.index!].name == null ?
                  Container() :
                  Text(
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
                const SizedBox(height: 7,),


                SizedBox(
                  width: 90,
                  child: widget.list![widget.index!].price == null ?
                  Container() :
                  Text(
                    widget.list![widget.index!].offer == null ?
                    "${widget.list![widget.index!].price!} SAR" :
                    "${widget.list![widget.index!].offer!} SAR",
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
                        "${widget.list![widget.index!].price!} SAR",
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
        },
      ),
    );
  }

  double getOffer(String offer, String price) {
    return ((int.parse(price) - int.parse(offer)) /
        int.parse(price)) * 100;
  }
}


/*IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,
              color: Colors.white,shadows: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: customColor,
                ),
                BoxShadow(
                  blurRadius: 12.0,
                  color: customTextColor,
                  offset: Offset(0, 6.0),
                ),
              ],)),*/
/*countBuilder: (int? count, bool isLiked, String text) {
                    var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "love",
                        style: TextStyle(color: color),
                      );
                    } else
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    return result;
                  },*/
