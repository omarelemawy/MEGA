
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../constants/color_constans.dart';
import '../../constants/utils.dart';
import '../../constants/widget.dart';
import '../../models/product_model.dart';
import 'package:http/http.dart' as http;

import 'explore_screen.dart';

class CoursesSearch extends SearchDelegate {
  CoursesSearch(this.productList,this.myContext)
      : super(
      searchFieldLabel: 'بحث',
      searchFieldStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontFamily: "Poppins")
  );
  List<ProductsModel> productList;
  var myContext;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
      future: getExploreItem(query),
      builder: (context,AsyncSnapshot snapshot) {
        if ( snapshot.hasData) {
          var data = snapshot.data as List<ProductsModel>;
          return (snapshot.data == null || snapshot.data.isEmpty)
              ? Container(
            child: Center(
              child: Text('بحث'),
            ),
          )
              : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: (data[i].images == null)
                          ? Container(
                        child: Icon(
                          Icons.image,
                          color: Colors.lightBlueAccent,
                        ),
                      )
                          : customCachedNetworkImage(
                        context: context,
                        url: data[i].images![0].src,
                      )),
                ),
                title: Text(data[i].name!),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ExploreScreen(context,query)
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: SpinKitChasingDots(
              color: customColor,
              size: 20,
            ),
          );
        }
      },
    );

    //   /*Column(
    //   children: [
    //    */
    //    /*   const Text("Authors", style: const TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.bold,
    //         fontFamily: "Poppins",
    //         fontSize: 17
    //     ),),
    //     SizedBox(
    //       height: 80,
    //       child: ListView.builder(
    //         itemCount: 12,
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (context, i) {
    //           return Column(
    //             children: [
    //               Container(
    //                 height: 50,
    //                 width: 50,
    //                 decoration: const BoxDecoration(
    //                   shape: BoxShape.circle,
    //                 ),
    //                 child: Center(
    //                     child: customCachedNetworkImage(
    //                       context: context,
    //                       url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ_g6RuUvDQCxONurbdUzvsp7VD86KLHGUXfd2apKsMCTQwJFR3Co9zgfjXlDVQmWezLU&usqp=CAU",
    //                     )),
    //               ),
    //               const Text("yrdt",style: TextStyle(
    //                 fontFamily: "Poppins",
    //               ),),
    //             ],
    //           );
    //         },
    //       ),
    //     ),*/
    //   /*
    //
    //     Expanded(
    //       child:ListView.builder(
    //         itemCount: productList.length,
    //         itemBuilder: (context, i) {
    //           return Row(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Container(
    //                   height: 80,
    //                   width: 80,
    //                   clipBehavior: Clip.antiAliasWithSaveLayer,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10)
    //                   ),
    //                   child: customCachedNetworkImage(
    //                     boxFit: BoxFit.cover,
    //                     context: context,
    //                     url: productList[i].images![0].src,
    //                   ),
    //                 ),
    //               ),
    //               Column(
    //                 children: [
    //                   Text(
    //                     productList[i].name!,
    //                     overflow: TextOverflow.ellipsis,
    //                     maxLines: 2,
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 13
    //                     ),),
    //                   SizedBox(height: 5,),
    //                   */
    //   /*Text(
    //                     productList[i].shortDescription!,
    //                     overflow: TextOverflow.ellipsis,
    //                     maxLines: 2,
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                         color: Colors.grey,
    //                         fontSize: 13
    //                     ),),*/
    //   /*
    //                 ],
    //               ),
    //             ],
    //
    //           );
    //         },
    //       )
    //     ),
    //
    //   ],
    // )*/;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
      future: getExploreItem(query),
      builder: (context,AsyncSnapshot snapshot) {
        if ( snapshot.hasData) {
          var data = snapshot.data as List<ProductsModel>;
          return (snapshot.data == null || snapshot.data.isEmpty)
              ? Container(
            child: Center(
              child: Text('بحث'),
            ),
          )
              : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: (data[i].images == null)
                          ? Container(
                        child: Icon(
                          Icons.image,
                          color: Colors.lightBlueAccent,
                        ),
                      )
                          : customCachedNetworkImage(
                        context: context,
                        url: data[i].images![0].src,
                      )),
                ),
                title: Text(data[i].name!),
                onTap: () {
                  pushNewScreen(
                    context,
                    screen:   ExploreScreen(myContext,query),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );

                 /* Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>
                  ), (route) => false);*/
                },
              );
            },
          );
        } else {
          return Center(
            child: SpinKitChasingDots(
              color: customColor,
              size: 20,
            ),
          );
        }
      },
    );
  }
}

Future<List<ProductsModel>?> getExploreItem
    (name)async{

  final response = await http.get(
    Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL+"&search=$name"),
  );
  print(response.body);
  Iterable l = json.decode(response.body);

  if(response.statusCode == 200)
  {
    return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
  }else{

  }
}
