import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:gnon/screens/home_data/category/category_screen.dart';
import 'package:gnon/screens/home_data/item_details_screen.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/color_constans.dart';
import '../../constants/widget.dart';
import '../../models/setting_model.dart';

class MyHomeCarouseSlider extends StatefulWidget {
   MyHomeCarouseSlider(this.myContext,{Key? key,this.items,
     this.height=300,
     this.margin=10.0,
     this.autoPlay=true}) : super(key: key);
   double? index=0;
   double? height;
   double? margin;
   var myContext;
   List<MySlider>? items;
   bool? autoPlay;
  @override
  _MyHomeCarouseSliderState createState() => _MyHomeCarouseSliderState();
}

class _MyHomeCarouseSliderState extends State<MyHomeCarouseSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: widget.height,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlay: widget.autoPlay!,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 1,
                onPageChanged:(i,h){
                  setState(() {
                    widget.index = i.toDouble();
                  });
                  print(""+i.toString());
                }
            ),
            items: widget.items!
                .map(
                  (items) => GestureDetector(
                onTap: () {
                  if(items.type=="section"){
                    Navigator.pushAndRemoveUntil(widget.myContext, MaterialPageRoute(builder:
                        (context)=>
                            CategoryScreen
                              (widget.myContext, int.parse(items.details!),
                                "", "011202")
                    ), (route) => false);
                  }
                  else if(items.type=="link") {
                    _launchUrl(items.details);
                  }
                  else if(items.type=="product") {
                    Navigator.pushAndRemoveUntil(widget.myContext, MaterialPageRoute(builder:
                        (context)=>
                        ItemDetailsScreen(widget.myContext,
                            int.parse(items.details!),
                            Localizations.localeOf(context).languageCode)

                    ), (route) => false);
                  }
                  else if(items.type=="offers") {
                    MySharedPreferences().getUserUserEmail().then((value){
                      Navigator.pushAndRemoveUntil(widget.myContext, MaterialPageRoute(builder:
                          (context)=>
                          HomeScreen(1,email:value,)

                      ), (route) => false);
                    });

                  }

                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: widget.margin!),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin:  EdgeInsets.all(widget.margin!),
                    child: ClipRRect(
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: widget.height,
                                decoration: const BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                child: customCachedNetworkImage(
                                  context: context,
                                  boxFit: BoxFit.fill,
                                  url: items.image,
                                ),
                              ),
                            ),
                           /* Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width/1.5,
                                child: Column(
                                  children: [
                                    customText(
                                      "$items",
                                      color:Colors.white,
                                      fontWeight: FontWeight.bold,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                          ],
                        )),
                  ),
                ),
              ),
            )
                .toList(),
          ),
          DotsIndicator(
            dotsCount: widget.items!.length,
            position: widget.index!,
            decorator: DotsDecorator(
              color: Colors.grey, // Inactive color
              activeColor: customColor,
            ),
          )
        ],
      ),
    );
  }
  void _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }
}


class MyProductCarouseSlider extends StatefulWidget {
  MyProductCarouseSlider({Key? key,this.items,
    this.height=300,
    this.margin=10.0,
    this.autoPlay=true}) : super(key: key);
  double? index=0;
  double? height;
  double? margin;
  List<String>? items;
  bool? autoPlay;
  @override
  _MyProductCarouseSliderState createState() => _MyProductCarouseSliderState();
}

class _MyProductCarouseSliderState extends State<MyProductCarouseSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: widget.height,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlay: widget.autoPlay!,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 1,
                onPageChanged:(i,h){
                  setState(() {
                    widget.index = i.toDouble();
                  });
                  print(""+i.toString());
                }
            ),
            items: widget.items!
                .map(
                  (items) => GestureDetector(
                onTap: () {
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoriesCoursesPageView(
                        courses: items,
                      ),
                    ),
                  );*/
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: widget.margin!),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin:  EdgeInsets.all(widget.margin!),
                    child: ClipRRect(
                      /*borderRadius: const BorderRadius.all(const Radius.circular(20.0)),*/
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              /* borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),*/
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: widget.height,
                                decoration: const BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                child: customCachedNetworkImage(
                                  context: context,
                                  boxFit: BoxFit.cover,
                                  url: items,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ).toList(),
          ),
          SizedBox(height: 20,),
          DotsIndicator(
            dotsCount: widget.items!.length,
            position: widget.index!,
            decorator: DotsDecorator(
              color: Colors.grey, // Inactive color
              activeColor: customColor,
            ),
          )
        ],
      ),
    );
  }
}