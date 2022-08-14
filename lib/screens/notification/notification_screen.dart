import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/widget.dart';
import 'package:gnon/screens/notification/notif_bloc/notification_cubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/color_constans.dart';
import '../../constants/themes.dart';
import '../../localization/localization_constants.dart';

class NotificationScreen extends StatefulWidget {
   NotificationScreen(this.lang,{Key? key}) : super(key: key);
   String? lang;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => NotificationCubit()..getNotifData(widget.lang),
  child: BlocConsumer<NotificationCubit, NotificationState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var notificationList = NotificationCubit.get(context).notificationList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:
        Icon(Icons.arrow_back_ios,size: 14,color: HexColor("#9098B1"),)),
        elevation: 1,
        centerTitle: false,
        title: customText(
            getTranslated(context, "Notifications",)!,
            max: 1,overflow: TextOverflow.ellipsis,
            color: customColor,
            fontWeight: FontWeight.bold
        ),
      ),
      body: notificationList!.isEmpty?
      const Center(
        child:  SpinKitChasingDots(
          color: customColor,
          size: 40,
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               /* Container(
                  height: 48,
                  width: 48,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: customCachedNetworkImage(url:
                      "https://i0.wp.com/www.aljadeed.com/wp-content/uploads/2021/03/Image-Compressor-Online-%D9%85%D9%88%D9%82%D8%B9-%D9%84%D8%AE%D9%81%D8%B6-%D8%AD%D8%AC%D9%85-%D8%A7%D9%84%D8%B5%D9%88%D8%B1-%D8%A7%D9%88%D9%86-%D9%84%D8%A7%D9%8A%D9%86-%D8%A8%D8%AF%D9%88%D9%86-%D8%AA%D9%82%D9%84%D9%8A%D9%84-%D8%A7%D9%84%D8%AC%D9%88%D8%AF%D8%A9.jpg"
                      ,context:context,
                    boxFit: BoxFit.fill
                  ),
                ),*/
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(notificationList[index].text!,fontWeight: FontWeight.bold),
                     /* SizedBox(height: 5,),
                      customText(notificationList[index].text!,
                          fontWeight: FontWeight.w500,size: 10,color: customTextColor.withOpacity(.4)),*/
                      SizedBox(height: 5,),
                      customText(notificationList[index].date!,fontWeight: FontWeight.w200,size: 11),
                    ],
                  ),
                )
              ],
            ),
          );
        },itemCount: notificationList.length,padding: EdgeInsets.zero,),
      ),
    );
  },
),
);
  }
}
