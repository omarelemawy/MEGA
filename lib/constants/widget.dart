import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gnon/constants/themes.dart';

import '../localization/localization_constants.dart';
import 'color_constans.dart';

Widget connectWithUsWhatsApp(context,phone){
  return Container(color:
  Colors.black,
    height: 30,
    child: Row(
      children: [
        const SizedBox(width: 50,),
        const Icon(FontAwesomeIcons.whatsapp,color: Colors.white,),
        const SizedBox(width: 5,),
         Text(getTranslated(context, " Contact Us On whats app - ",)!
          ,
          style: TextStyle(
              color: Colors.white
          ),),
        InkWell(
          onTap: (){
            whatsAppOpen(phone);
          },
          child:  Text(
            getTranslated(context, "Click here",)!
            ,
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline
            ),),
        ),
      ],
    ),
  );
}
void whatsAppOpen(phone) async {
  await FlutterLaunch.launchWhatsapp(phone: phone, message: "Hello");
}

customCachedNetworkImage({String? url, BuildContext? context, BoxFit? boxFit}) {
  try {
    if (url == null || url == '') {
      return Container();
    } else {
      return Container(
        width: MediaQuery.of(context!).size.width,
        child: (Uri.parse(url).isAbsolute)
            ? CachedNetworkImage(
          imageUrl: url,
          fit: (boxFit) ?? BoxFit.contain,
          placeholder: (context, url) => Center(
            child: SpinKitChasingDots(
              color: customColor,
              size: 20,
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        )
            : Icon(
          Icons.image,
          color: customColor,
        ),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

Widget customFloatingActionButton(context,{Function()? onPress,String? text,Color color=customColor})
{
  return FloatingActionButton.extended(
      backgroundColor: color,
      shape: RoundedRectangleBorder(),
      onPressed: onPress,
      label: Container(
        width: MediaQuery.of(context).size.width/1.2,
        child: Center(child: customText(text!,color: Colors.white,
            fontWeight: FontWeight.bold)),
      ));
}

