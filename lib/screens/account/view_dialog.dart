import 'package:flutter/material.dart';
import 'package:gnon/screens/auth/login/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/color_constans.dart';
import '../../constants/themes.dart';
import '../../localization/localization_constants.dart';

Widget deleteDialog(context)
{
  return AlertDialog(
    title: Icon(
      Icons.login,
      color: customColor,
      size: 30,
    ),
    actions: [
      Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height/2.3,
        color: Colors.white,
        child: Column(
          children: [
            customText(
                getTranslated(context,  "Sign In",)!,
                fontWeight: FontWeight.bold, size: 18),
            const SizedBox(
              height: 10,
            ),
            customText(
                getTranslated(context,  "You Want To Login",)!
                ,
                color: customTextColor.withOpacity(.3),
                fontWeight: FontWeight.bold,
                size: 12),
            const SizedBox(
              height: 15,
            ),
            Material(
              elevation: 5,
              child: Container(
                width:
                MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: HexColor("#087DA9"),
                    border: Border.all(
                        color: customTextColor
                            .withOpacity(.2)),
                    borderRadius:
                    BorderRadius.circular(4)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=>LoginScreen()),
                            (route) => false);
                  },
                  child: customText(
                      getTranslated(context,  "Sign In",)!
                      ,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: customTextColor
                          .withOpacity(.2)),
                  borderRadius:
                  BorderRadius.circular(4)),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: customText(
                    getTranslated(context,  "Cancel",)!
                    ,
                    color:
                    customTextColor.withOpacity(.5),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      )
    ],
  );
}

