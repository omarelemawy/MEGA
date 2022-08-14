import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gnon/constants/themes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

import '../../../constants/widget.dart';
import '../../../localization/localization_constants.dart';
import '../../../models/product_detail_model.dart';
import '../../../models/user_data.dart';
import '../../account/view_dialog.dart';
import 'add_review_screen.dart';

class ViewAllReviews extends StatefulWidget {
   ViewAllReviews(/*this.reviews,this.product,*/{Key? key}) : super(key: key);
   /*int? product;*/
  /*List<Reviews>? reviews;*/

  @override
  _ViewAllReviewsState createState() => _ViewAllReviewsState();
}

class _ViewAllReviewsState extends State<ViewAllReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:customFloatingActionButton(context,
          color: HexColor("#BA6400"),
          text: getTranslated(context, "Write Review",)!
         ,onPress:
           (){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=>
                AddReviewScreen(
                     /* widget.product*/
                    /*value.email*/
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
        title: customText(" ${getTranslated(context, "Reviews")}     "
            " ${10/*widget.reviews!.length*/} ",fontWeight: FontWeight.bold),
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
                           url: "https://megamatgr.com/wp-content/uploads/2022/07/2a1762b4-853e-4b2b-ba74-892b591cf27e-300x300.jpg"
                           /*widget.reviews![index].user!.photo*/,
                         ),
                       ),
                       SizedBox(width: 15,),
                       Column(
                         children: [
                           customText("mohamed"
                               /*widget.reviews![index].user!.name!*/,
                               fontWeight: FontWeight.bold,
                               size: 12),
                           SizedBox(height: 5,),
                           RatingStars(
                             editable: false,
                             rating: double.parse("4"/*widget.reviews![index].rate!*/),
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
                         ExpandableText(
                            "air max are always very comfortable fit, clean and just perfect in "
                           /*widget.reviews![index].comment!*/,
                           expandText: getTranslated(context, "show more",)!
                           ,
                           collapseText: getTranslated(context, "show less",)!
                           ,
                           expandOnTextTap: true,
                           maxLines: 5,
                           style: TextStyle(
                               color: HexColor("#9098B1"),
                               fontWeight: FontWeight.w300,
                               fontSize: 12
                           ),
                           linkColor: Colors.blue,
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
            itemCount: 10/*widget.reviews!.length*/),
      ),
    );
  }
}
