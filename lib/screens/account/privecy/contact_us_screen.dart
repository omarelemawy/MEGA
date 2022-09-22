import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/screens/account/account_bloc/account_cubit.dart';
import 'package:gnon/screens/account/account_bloc/account_state.dart';

import '../../../constants/color_constans.dart';
import '../../../constants/themes.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AccountCubit()..getSettings(),
  child: BlocConsumer<AccountCubit, AccountState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: customText("تواصل معنا",
          fontWeight: FontWeight.bold,),
        centerTitle: false,
      ),
      body: state is GetLoadingSettingsDataAccountState?
      const Center(
          child:  SpinKitChasingDots(
            color: customColor,
            size: 40,
          )) :
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(150))
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(120))
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90))
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(60))
                  ),
                ),
              ],
            ),

            Padding(
              padding:  EdgeInsets.only(
                left: MediaQuery.of(context).size.width/9,
                right: MediaQuery.of(context).size.width/9,

              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(150)),
                elevation: 20,
                shadowColor: Colors.green,
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.whatsapp,size: 30,color:Colors.red,),
                          SizedBox(width: 10,),
                          customText(
                            AccountCubit.get(context).
                            settingsModel!.data!.contactData!.whatsapp!
                            ,size: 20,)
                        ],
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.phone,size: 30,color: Colors.red,),
                          SizedBox(width: 10,),
                          customText(
                              AccountCubit.get(context).
                              settingsModel!.data!.contactData!.mobile!
                              ,size: 20)
                        ],
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.email,size: 30,color:Colors.red,),
                          SizedBox(width: 10,),
                          customText(
                              AccountCubit.get(context).
                              settingsModel!.data!.contactData!.email!
                          ,size: 20)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
),
);
  }
}
