import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/screens/account/account_bloc/account_cubit.dart';
import 'package:gnon/screens/account/account_bloc/account_state.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/color_constans.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../models/language.dart';
import '../../sharedPreferences.dart';
import 'edit_profile_bottom_screen.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen(this.lang,{Key? key}) : super(key: key);
  String? lang;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AccountCubit()
        ..getProfile(widget.lang),
      child: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileData = AccountCubit
              .get(context)
              .profileData;
          return WillPopScope(
              onWillPop: () async {
                MySharedPreferences().getUserUserEmail().then((value) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) =>
                          HomeScreen
                            ( 3
                            , email: value,)),
                          (route) => false);
                });

                return await true;
              },
              child: Scaffold(
                key: _scaffoldKey,

                appBar: AppBar(
                  leading: IconButton(onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) =>
                            HomeScreen
                              ( 3
                              , email: "value",)),
                            (route) => false);

                  }, icon:
                  Icon(Icons.arrow_back_ios, size: 14,
                    color: HexColor("#9098B1"),)),
                  backgroundColor: Colors.white,
                  elevation: 1,
                  title: customText(getTranslated(context, "Profile",)!,
                    fontWeight: FontWeight.bold,),
                  centerTitle: false,
                ),
                body: profileData == null ?
                Container() :
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                /*final ImagePicker _picker = ImagePicker();
                        image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                        });*/
                              },
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: image == null ?
                                    customCachedNetworkImage(
                                      boxFit: BoxFit.cover,
                                      context: context,
                                      url: profileData.image,
                                    ) :
                                    Image.file(
                                      File(image!.path), fit: BoxFit.fill,),
                                  ),
                                  /*Icon(Icons.camera_alt_outlined,color: customColor,)*/
                                ],
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                customText(
                                    profileData.userName!,
                                    fontWeight: FontWeight.bold,
                                    size: 14),
                                SizedBox(height: 5,),
                                customText(profileData.email!,
                                    fontWeight: FontWeight.w100,
                                    color: HexColor("#9098B1"), size: 11)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20,),

                        ListTile(
                          onTap: () {
                            showMyBottomSheet(_scaffoldKey, 6);
                          },
                          contentPadding: EdgeInsets.symmetric(horizontal: 0,
                              vertical: 5),
                          leading: Icon(Icons.person_outline,
                            color: Colors.black,),
                          title: Row(
                            children: [
                              customText(
                                  getTranslated(context, "Name",)!
                                  , fontWeight: FontWeight.bold),
                              Spacer(),
                              Expanded(child:
                              customText(profileData.name!,
                                  color: HexColor("#9098B1"))),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_sharp,
                            color: HexColor("#9098B1"), size: 12,),
                        ),
                        /*ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                  leading: Icon(Icons.male,color: HexColor("#40BFFF"),),
                  title: Row(
                    children: [
                      customText(
                          getTranslated(context,"Gender",)!
                          ,fontWeight: FontWeight.bold),
                      Spacer(),
                      customText(profileData.data!.gender??"",color: HexColor("#9098B1")),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,color: HexColor("#9098B1"),size: 12,),
                  onTap: (){
                    showMyBottomSheet(_scaffoldKey,1);
                  },
                ),*/
                        /*ListTile(
                  onTap: (){
                    showMyBottomSheet(_scaffoldKey,2);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                  leading: Icon(Icons.date_range,color: HexColor("#BA6400"),),
                  title: Row(
                    children: [
                      customText(
                          getTranslated(context,"Birthday",)!
                          ,
                          fontWeight: FontWeight.bold),
                      Spacer(),
                      customText("17/11/2017",color: HexColor("#9098B1")),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,color: HexColor("#9098B1"),size: 12,),
                ),*/

                        ListTile(
                          onTap: () {
                            showMyBottomSheet(_scaffoldKey, 3);
                          },
                          contentPadding: EdgeInsets.symmetric(horizontal: 0,
                              vertical: 5),
                          leading: Icon(Icons.email_outlined,
                            color: Colors.black,),
                          title: Row(
                            children: [
                              Expanded(
                                child: customText(
                                    getTranslated(context, "Email",)!
                                    , fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Expanded(child: customText(
                                  profileData.email!, color: HexColor("#9098B1"))),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_sharp,
                            color: HexColor("#9098B1"), size: 12,),
                        ),

                        /* ListTile(
                  onTap: (){
                    showMyBottomSheet(_scaffoldKey,4);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                  leading: Icon(Icons.phone_iphone_rounded,color: HexColor("#BA6400"),),
                  title: Row(
                    children: [
                      customText(
                          getTranslated(context,"Phone Number",)!
                          ,
                          fontWeight: FontWeight.bold),
                      Spacer(),
                      customText("0101544444",color: HexColor("#9098B1")),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,color: HexColor("#9098B1"),size: 12,),
                ),*/

                        ListTile(
                          onTap: () {
                            showMyBottomSheet(_scaffoldKey, 5);
                          },
                          contentPadding: EdgeInsets.symmetric(horizontal: 0,
                              vertical: 5),
                          leading: Icon(Icons.lock_outline_rounded,
                            color: Colors.black/*HexColor("#44c718")*/,),
                          title: Row(
                            children: [
                              customText(
                                  getTranslated(context, "Change Password",)!
                                  , fontWeight: FontWeight.bold),
                              Spacer(),
                              customText("•••••••••••••••••",
                                  color: HexColor("#9098B1")),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_sharp,
                            color: HexColor("#9098B1"), size: 12,),
                        ),

                        ListTile(
                          title: customText(
                              getTranslated(
                                context,
                                "Language",
                              )!,
                              color: customTextColor,
                              fontWeight: FontWeight.w600),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0,
                              vertical: 5),
                          leading: Icon(
                            Icons.language,
                            color: Colors.black,
                          ),
                          trailing: DropdownButton<Language>(
                            dropdownColor: Colors.white,
                            underline: SizedBox(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: HexColor("#40BFFF"),
                            ),
                            onChanged: (Language? language) {
                              AccountCubit.get(context)
                                  .changeLanguage(language!, context);
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                  (e) =>
                                  DropdownMenuItem<Language>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          e.flag,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(e.name)
                                      ],
                                    ),
                                  ),
                            )
                                .toList(),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 60,),

                        /*state is UpdateProfileLoadingAccountState ?
                        const Center(
                          child: SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ) :
                        customFloatingActionButton(context,
                            onPress: () {
                              */
                        /*if(image!=null){
                         MySharedPreferences().getUserId().then((value) {
                           AccountCubit.get(context).updateProfile(
                               Localizations.localeOf(context).languageCode,
                               value,
                               context,
                               photo: image
                           );
                         });
                       }
                       else{
                         MySharedPreferences().getUserUserEmail().then((value){
                           Navigator.pushAndRemoveUntil(context,
                               MaterialPageRoute(builder: (context)=>
                                   HomeScreen
                                     (Localizations.localeOf(context).languageCode,3
                                     ,email: value,)),
                                   (route) => false);
                         });
                       }*/
                        /*
                            },
                            text: getTranslated(context, "Save All Data")
                        ),*/
                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
