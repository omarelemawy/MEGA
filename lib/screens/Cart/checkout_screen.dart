import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/color_constans.dart';
import '../../constants/themes.dart';
import '../../constants/widget.dart';
import '../../localization/localization_constants.dart';
import '../../sharedPreferences.dart';
import 'address_bloc/address_bloc.dart';


class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}
final _formKey = GlobalKey<FormState>();
TextEditingController firstNameEditingController = TextEditingController();
TextEditingController lastNameEditingController = TextEditingController();
TextEditingController phoneEditingController = TextEditingController();
TextEditingController addressEditingController = TextEditingController();
TextEditingController cityEditingController = TextEditingController();
TextEditingController stateEditingController = TextEditingController();

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: BlocConsumer<AddressCubit, AddressState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 1,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon:
          Icon(Icons.arrow_back_ios, size: 14, color: HexColor("#9098B1"),)),
          title: customText(
              "Check Out"
              , fontWeight: FontWeight.bold),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
        state is GetLoadingSubmitCheckOutState ?
        const SpinKitChasingDots(
          color: customColor,
          size: 40,
        ) :
        customFloatingActionButton(context,
            color: HexColor("#44c718")
            , onPress: () {
              if (_formKey.currentState!.validate()) {
                  MySharedPreferences().getUserUserEmail().then((value){
                    MySharedPreferences.getUserGetToken().then((value1) {
                      print(value1);
                      AddressCubit.get(context).submitCheckOut(
                        value1,
                        firstNameEditingController.text,
                        lastNameEditingController.text,
                        value,
                        addressEditingController.text,
                        cityEditingController.text,
                        stateEditingController.text,
                        phoneEditingController.text,
                        context,
                      ).then((value) {
                        firstNameEditingController.clear();
                        lastNameEditingController.clear();
                        phoneEditingController.clear();
                        addressEditingController.clear();
                        cityEditingController.clear();
                        stateEditingController.clear();
                      });
                    });
                  });

              }
            }, text:
            getTranslated(context, "Submit",)!
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: firstNameEditingController,
                    decoration: InputDecoration(
                      labelText: getTranslated(context,"First Name",)!
                      ,
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                          context, "Please Enter First Name",)!
                        ;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: lastNameEditingController,
                    decoration: InputDecoration(
                        labelText:"الاسم التاني" /*getTranslated(context,"Last Name",)!*/
                        ,
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                          context, "Please Enter Last Name",)!
                        ;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneEditingController,
                    decoration: InputDecoration(
                        labelText: "رقم الجوال"/*getTranslated(context,"Email",)!*/
                        ,
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {

                        if(value!.isEmpty ){
                          return "من فضلك ادخل رقم الجوال"/*getTranslated(
                            context, "Please Enter Email",)!*/;
                        }
                        /*else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").
                        hasMatch(value)){
                          return "Please Enter Correct Email";
                        }*/
                        else {
                          return null;
                        }
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addressEditingController,
                    decoration: InputDecoration(
                        labelText:" رقم الشارع" /*getTranslated(context,"Full Address",)!*/,
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                          context, "Please Enter Full Address",)!
                        ;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: cityEditingController,
                    decoration: InputDecoration(
                        labelText:"مدينه / محافظه" /*getTranslated(context,"City",)!*/
                        ,
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                          context, "Please Enter City",)!
                        ;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: stateEditingController,
                    decoration: InputDecoration(
                        labelText: getTranslated(context,"State",)!
                        ,
                        labelStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(
                          context, "Please Enter State",)!
                        ;
                      }
                      return null;
                    },
                  ),



                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      );
  },
),
    );
  }
}
