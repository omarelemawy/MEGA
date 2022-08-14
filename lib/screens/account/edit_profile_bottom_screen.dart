import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/themes.dart';
import 'package:gnon/constants/widget.dart';
import 'package:gnon/screens/account/account_bloc/account_cubit.dart';
import 'package:gnon/screens/account/account_bloc/account_state.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:intl/intl.dart';

import '../../constants/color_constans.dart';
import '../../localization/localization_constants.dart';

class EditProfileBottomScreen extends StatefulWidget {
   EditProfileBottomScreen(this.selectEdit,{Key? key}) : super(key: key);
   int selectEdit;

  @override
  _EditProfileBottomScreenState createState() => _EditProfileBottomScreenState();
}

class _EditProfileBottomScreenState extends State<EditProfileBottomScreen> {
  String? selectedGender;
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController oldPassController=TextEditingController();
  TextEditingController newPassController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();

  bool obscureOldPassword=true;
  bool obscureNewPassword=true;
  bool obscureNewConfirmPassword=true;
  String? date=DateFormat.yMMMMd().format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {

          Widget editGender(){
            return Container(
              height: 300,
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          isExpanded: true,

                          hint: Text(
                            getTranslated(context," Select Your Gender",)! ,
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 50,
                          buttonPadding: const EdgeInsets.only(left: 20, right: 10),

                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          items: [
                            getTranslated(context,"Male",)! ,
                            getTranslated(context,"Female",)!,
                          ].map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return getTranslated(context,"Please select Gender",)!;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            selectedGender = value.toString();
                          },
                          onSaved: (value) {
                            selectedGender = value.toString();
                          },
                        ),


                        const SizedBox(height: 15),

                        state is UpdateProfileLoadingAccountState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):

                        customFloatingActionButton(
                            context,
                            text:getTranslated(context,"Save",)!,
                            onPress: () {
                              Navigator.pop(context);
                              /*if (_formKey.currentState!.validate()) {
                                MySharedPreferences().getUserId().then((value) {
                                  AccountCubit.get(context).updateProfile(
                                    Localizations.localeOf(context).languageCode,
                                    value,
                                      context,
                                    gender: selectedGender
                                  );
                                });
                              }*/
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          Widget editBirthDay(){
            return Container(
              height: MediaQuery.of(context).size.height/2,
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height/2.8,
                            child:CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime newDateTime) {
                                  var format = DateFormat.yMMMMd().format(newDateTime);
                                 date =format;
                              },
                              use24hFormat: false,
                              minuteInterval: 1,
                            ),
                          ),
                          const SizedBox(height: 15),
                          state is UpdateProfileLoadingAccountState?
                          const Center(
                            child:  SpinKitChasingDots(
                              color: customColor,
                              size: 40,
                            ),
                          ):

                          customFloatingActionButton(
                              context,
                              text:getTranslated(context,"Save",)!,
                              onPress: () {
                                print(date);
                                Navigator.pop(context);
                                /*if (_formKey.currentState!.validate()) {
                                  MySharedPreferences().getUserId().then((value) {
                                    AccountCubit.get(context).updateProfile(
                                        Localizations.localeOf(context).languageCode,
                                        value,
                                        context,
                                        date: date
                                    );
                                  });
                                }*/
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          Widget editEmail(){
            return Container(
              height: 300,
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, "Please select Email"):null,
                          decoration:  InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: getTranslated(context, "Email"),
                              prefixIcon:Icon(Icons.mail_outline,
                                color: Colors.grey,)
                          ),
                        ),
                        const SizedBox(height: 30),

                        state is UpdateProfileLoadingAccountState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):

                        customFloatingActionButton(
                            context,
                            text:getTranslated(context,"Save",)!,
                            onPress: () {
                              Navigator.pop(context);
                             /* if (_formKey.currentState!.validate()) {
                                MySharedPreferences().getUserId().then((value) {
                                  AccountCubit.get(context).updateProfile(
                                      Localizations.localeOf(context).languageCode,
                                      value,
                                      context,
                                      email: emailController.text
                                  );
                                });
                              }*/
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          Widget editName(){
            return Container(
              height: 300,
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, "Please select Name"):null,
                          decoration:  InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: getTranslated(context, "Name"),
                              prefixIcon:Icon(Icons.person_outline,
                                color: Colors.grey,)
                          ),
                        ),
                        const SizedBox(height: 30),

                        state is UpdateProfileLoadingAccountState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):

                        customFloatingActionButton(
                            context,
                            text:getTranslated(context,"Save",)!,
                            onPress: () {
                              Navigator.pop(context);
                              /*if (_formKey.currentState!.validate()) {
                                MySharedPreferences().getUserId().then((value) {
                                  AccountCubit.get(context).updateProfile(
                                      Localizations.localeOf(context).languageCode,
                                      value,
                                      context,
                                      phone: nameController.text
                                  );
                                });
                              }*/
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          Widget editPhone(){
            return Container(
              height: 300,
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          validator: (val) =>val!.isEmpty?
                               getTranslated(context, "Please select Phone"):null,
                          decoration:  InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: getTranslated(context, "Phone Number"),
                              prefixIcon:Icon(Icons.phone_iphone_rounded,
                                color: Colors.grey,)
                          ),
                        ),
                        const SizedBox(height: 30),
                        state is UpdateProfileLoadingAccountState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):

                        customFloatingActionButton(
                            context,
                            text:getTranslated(context,"Save",)!,
                            onPress: () {
                              Navigator.pop(context);
                             /* if (_formKey.currentState!.validate()) {
                                MySharedPreferences().getUserId().then((value) {
                                  AccountCubit.get(context).updateProfile(
                                      Localizations.localeOf(context).languageCode,
                                      value,
                                      context,
                                      phone: phoneController.text
                                  );
                                });
                              }*/
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          Widget editPass(){
            return Container(
              height: 400,
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                      /*  TextFormField(
                          controller: oldPassController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your Old Password Is Empty ") : null,
                          obscureText:obscureOldPassword,
                          decoration: textFormInputDecorationForPassword
                            (Icons.visibility_off,getTranslated(context, "Old Password")!
                              ,(){
                                setState(() {
                                  obscureOldPassword= !obscureOldPassword;
                                });
                              },obscureOldPassword),
                        ),*/
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: newPassController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your New Password Is Not Empty ") : null,
                          obscureText:obscureNewPassword,
                          decoration: textFormInputDecorationForPassword
                            (Icons.visibility_off,
                              getTranslated(context, "New Password ")!,(){
                                setState(() {
                                  obscureNewPassword= !obscureNewPassword;
                                });
                              },obscureNewPassword),
                        ),
                        const SizedBox(height: 10),

                        TextFormField(
                          controller: confirmPassController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your New Password Confirm Is Not Empty "): null,
                          obscureText:obscureNewConfirmPassword,
                          decoration: textFormInputDecorationForPassword
                            (Icons.visibility_off,getTranslated(context, "New Password Confirm")!,(){
                            setState(() {
                              obscureNewConfirmPassword= !obscureNewConfirmPassword;
                            });
                          },obscureNewConfirmPassword),
                        ),

                        const SizedBox(height: 30),
                        state is UpdateProfileLoadingAccountState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):

                        customFloatingActionButton(
                            context,
                            text:getTranslated(context,"Save",)!,
                            onPress: () {
                              Navigator.pop(context);
                              /*if (_formKey.currentState!.validate()) {
                                if(newPassController.text==confirmPassController.text) {
                                  MySharedPreferences().getUserId().then((
                                      value) {
                                    AccountCubit.get(context).updateProfile(
                                        Localizations
                                            .localeOf(context)
                                            .languageCode,
                                        value,
                                        context,
                                        pass: newPassController.text
                                    );
                                  });
                                }
                              }*/
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          Widget yourData() {
            switch (widget.selectEdit) {
              case 2:
                return editBirthDay();
                break;
              case 3:
                return editEmail();
                break;
              case 4:
                return editPhone();
                break;
              case 5:
                return editPass();
                break;
              case 6:
                return editName();
                break;
              default :
                return editGender();
                break;
            }
          }

          return yourData();
        },
      ),
    );
  }
  

}

void showMyBottomSheet(scaffoldKey,selectEdit)
{
  scaffoldKey.currentState!.showBottomSheet(
    enableDrag: false,
        (BuildContext context) {
      return EditProfileBottomScreen(selectEdit);
    },
  );
}

