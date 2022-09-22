import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gnon/constants/themes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

import '../../../constants/widget.dart';
import '../../../localization/localization_constants.dart';
import '../../../models/product_detail_model.dart';
import '../../../models/review_product.dart';
import '../../../models/user_data.dart';
import '../../account/view_dialog.dart';
import 'add_review_screen.dart';

class ViewAllReviews extends StatefulWidget {
   ViewAllReviews(this.reviews,this.product,{Key? key}) : super(key: key);
   int? product;
  List<ReviewProductModel>? reviews;

  @override
  _ViewAllReviewsState createState() => _ViewAllReviewsState();
}

class _ViewAllReviewsState extends State<ViewAllReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:customFloatingActionButton(context,
          color: HexColor("#44c718"),
          text: "اضف مراجعه"/*getTranslated(context, "Write Review",)!*/
         ,onPress:
           (){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=>
                AddReviewScreen(
                      widget.product,

                )));
            /*getUserDate().then((value) {
              if(value.email==""||value.email==null) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return deleteDialog(context);
                    });
              }else{
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>
                    AddReviewScreen(
                       1 */
            /* widget.product*/
            /*,
                        value.email
                    )));
              }
            });*/

      }),
      /*FloatingActionButton.extended(
        backgroundColor: customColor,
        shape: RoundedRectangleBorder(),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=>
                AddReviewScreen()));
              },
          label: Container(
        width: MediaQuery.of(context).size.width/1.2,
        child: Center(child: customText("Write Review",color: Colors.white,
            fontWeight: FontWeight.bold)),
      )),*/
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:
        const Icon(Icons.arrow_back_ios,size: 14,)),
        title: customText(" ${widget.reviews!.length} "" ${getTranslated(context, "Reviews")}     "
            ,fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 80),
        child: ListView.separated(itemBuilder:
            (context,index){
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   Row(
                     children: [
                       SizedBox(width: 10,),
                       Container(
                         height: 50,
                         width: 50,
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         decoration:  BoxDecoration(
                           shape: BoxShape.circle,
                         ),
                         child: customCachedNetworkImage(
                           boxFit: BoxFit.cover,
                           context: context,
                           url:widget.reviews![index].reviewerAvatarUrls!.s96,
                         ),
                       ),
                       SizedBox(width: 15,),
                       Column(
                         children: [
                           customText(widget.reviews![index].reviewer!,
                               fontWeight: FontWeight.bold,
                               size: 12),
                           SizedBox(height: 5,),
                           RatingStars(
                             editable: false,
                             rating: widget.reviews![index].rating!.toDouble(),
                             color: Colors.amber,
                             iconSize: 18,
                           ),
                         ],
                       )
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.all(10),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         HtmlWidget(
                           widget.reviews![index].review!,

                           // all other parameters are optional, a few notable params:

                           // specify custom styling for an element
                           // see supported inline styling below
                           customStylesBuilder: (element) {
                             if (element.classes.contains('foo')) {
                               return {'color': 'red'};
                             }

                             return null;
                           },
                           // render a custom widget
                           customWidgetBuilder: (element) {
                             if (element.attributes['foo'] == 'bar') {
                               return Container();
                             }
                             return null;
                           },
                           // turn on selectable if required (it's disabled by default)
                           isSelectable: true,

                           // these callbacks are called when a complicated element is loading
                           // or failed to render allowing the app to render progress indicator
                           // and fallback widget
                           onErrorBuilder: (context, element, error) =>
                               ExpandableText(
                                 widget.reviews![index].review!,
                                 expandText: getTranslated(context, "show more",)!,
                                 collapseText: getTranslated(context, "show less",)!,
                                 expandOnTextTap: true,
                                 maxLines: 4,
                                 style: TextStyle(
                                     color: HexColor("#9098B1"),
                                     fontWeight: FontWeight.w300,
                                     fontSize: 12
                                 ),
                                 linkColor: Colors.blue,
                               ),
                           onLoadingBuilder: (context, element, loadingProgress) =>
                               CircularProgressIndicator(),
                           // this callback will be triggered when user taps a link

                           // select the render mode for HTML body
                           // by default, a simple `Column` is rendered
                           // consider using `ListView` or `SliverList` for better performance
                           renderMode: RenderMode.column,

                           // set the default styling for text
                           textStyle: TextStyle(fontSize: 14),

                           // turn on `webView` if you need IFRAME support (it's disabled by default)
                           webView: true,
                         ),

                         SizedBox(height: 10,),
                         /*customText("December 10, 2016",size: 10,color:HexColor("#9098B1")),*/
                       ],
                     ),
                   ),
                 ],
               ),
             );
            },
            separatorBuilder: (context,index){
            return const SizedBox(height: 2,);
            },
            itemCount: widget.reviews!.length),
      ),
    );
  }
}
