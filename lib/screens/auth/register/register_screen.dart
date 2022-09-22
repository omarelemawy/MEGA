import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/localization/localization_constants.dart';
import 'package:gnon/screens/auth/login/login_screen.dart';
import 'package:gnon/screens/auth/register/cubit_register/register_cubit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:random_password_generator/random_password_generator.dart';
import '../../../constants/MediaButton.dart';
import '../../../constants/color_constans.dart';
import '../../../constants/themes.dart';
import '../../home/home_screen.dart';
import 'cubit_register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword=true;
  bool obscureConfirmPassword=true;
  String? phoneNumber;
  String? myGender="male";
  String countryCode="+20";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (BuildContext context, state)
        {
          if(state is ErrorRegisterState){
            _scaffoldKey.currentState!.
            showSnackBar(SnackBar(content: customText(state.error,color: Colors.white),
              backgroundColor: customColor,));
          }
        },
        builder: (BuildContext context, Object? state) {


         /* String? checkPhoneError(){
            if(state is ErrorRegisterState){
              return state.errorPhone!.isNotEmpty?state.errorPhone!:null;
            }
          }
          String? checkEmailError(){
            if(state is ErrorRegisterState){
              return state.errorEmail!.isNotEmpty?state.errorEmail!:null;
            }
          }
          String? checkPassError(){
            if(state is ErrorRegisterState){
              return state.errorPass!.isNotEmpty?state.errorPass!:null;
            }
          }*/


          return Scaffold(
            key: _scaffoldKey,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50,),
                      Image.asset("lib/images/gnon-red-logo.png",height: 80 ,),
                      const SizedBox(height: 30,),
                      customText(
                          getTranslated(context, "Let’s Get Started",)!,
                          fontWeight: FontWeight.bold,
                          size: 16),
                      const SizedBox(height: 8,),
                      customText(
                          getTranslated(context, "Create an new account",)!
                          ,
                          fontWeight: FontWeight.w100,size: 12,color: HexColor("#9098B1")),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: nameController,
                        validator: (val) =>val!.isEmpty?
                        getTranslated(context, " Oops! Your Name Is Not Correct ",)!
                            : null,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            prefixIcon:  Icon(Icons.person_outline),
                            hintText: "اسم المستخدم"/*getTranslated(context, "Full Name",)!*/
                            ,border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if(val!.isEmpty) {
                            return getTranslated(context, " Oops! Your Email Is Not Correct ",);
                          }/*else{
                            if(state is ErrorRegisterState){
                              return state.errorEmail!.isNotEmpty?state.errorEmail:null;
                            }
                          }*/
                          return null;
                        },
                        decoration: InputDecoration(
                           /* errorText: checkEmailError(),*/
                            contentPadding: const EdgeInsets.all(10),
                            labelStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            prefixIcon:  Icon(Icons.email_outlined),
                            hintText: getTranslated(context, "Your Email",)!,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return getTranslated(context,
                              " Oops! Your Phone Is Not Correct ",);
                          }/*else if(phoneController.text.length < 11){
                                  return "The Phone Number Must be 11 Character";
                                }*/else{
                            return null;
                          }
                        },
                        onChanged: (val) {
                          phoneNumber = val;
                        },
                        decoration: InputDecoration(
                            /*errorText: checkPhoneError(),*/
                            contentPadding: const EdgeInsets.all(10),
                            labelStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            prefixIcon:  Icon(Icons.phone),
                            hintText: getTranslated(context, "Your Phone",)!,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        /*textFormInputDecoration(
                            Icons.phone,

                            getTranslated(context, "Your Phone",)!,
                            error: checkPhoneError()
                        ),*/
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 2,
                      //       child: CountryCodePicker(
                      //         onChanged: (print) {
                      //           countryCode = print.toString();
                      //         },
                      //         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      //         initialSelection: 'EG',
                      //         favorite: ['+20', 'EG'],
                      //         // optional. Shows only country name and flag
                      //         showCountryOnly: false,
                      //         // optional. Shows only country name and flag when popup is closed.
                      //         showOnlyCountryWhenClosed: false,
                      //         // optional. aligns the flag and the Text left
                      //         alignLeft: false,
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 3,
                      //       child: TextFormField(
                      //         controller: phoneController,
                      //         keyboardType: TextInputType.number,
                      //         style: const TextStyle(color: Colors.black),
                      //         validator: (val) {
                      //           if(val!.isEmpty) {
                      //             return getTranslated(context,
                      //               " Oops! Your Phone Is Not Correct ",);
                      //           }/*else if(phoneController.text.length < 11){
                      //             return "The Phone Number Must be 11 Character";
                      //           }*/else{
                      //             return null;
                      //           }
                      //         },
                      //         onChanged: (val) {
                      //           phoneNumber = val;
                      //         },
                      //         decoration: textFormInputDecoration(
                      //           Icons.phone,
                      //
                      //           getTranslated(context, "Your Phone",)!,
                      //           error: checkPhoneError()
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),


                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: passController,
                        validator: (val) {
                          final password = RandomPasswordGenerator();
                          double passwordstrength = password.
                          checkPassword( password: passController.text);
                           print(passController.text);
                            print(passwordstrength);
                          if(val!.isEmpty) {
                            return getTranslated(context," Oops! Your Password Is Not Correct ",);
                          }else  if (passwordstrength < 0.1){
                            return "This password is weak!";
                          }
                          return null;
                        },
                        obscureText:obscurePassword,
                        decoration: textFormInputDecorationForPassword
                          (Icons.visibility_off,
                            getTranslated(context,"Password",)!
                            ,(){
                              setState(() {
                                obscurePassword= !obscurePassword;
                              });
                            },obscurePassword,
                          /*error: checkPassError()*/
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(onPressed: (){
                            final password = RandomPasswordGenerator();
                            String newPassword = password.randomPassword(
                                letters: true,uppercase: true,numbers: true,
                                specialChar: true,
                                passwordLength: 6
                            );
                            passController.text =newPassword;
                            confirmPassController.text =newPassword;
                          },
                          child: customText(getTranslated(context, "Generate Strong Password")!,
                              color: customColor,
                            decoration:  TextDecoration.underline
                          ),),
                        ],
                      ),

                      TextFormField(
                        controller: confirmPassController,
                        validator: (val) {
                          if(val!.isEmpty) {
                           return getTranslated(context,
                              " Oops! Your Confirm Password Is Not Correct ",);
                          }/*else{
                            if(state is ErrorRegisterState){
                               return state.errorPass!.isNotEmpty?state.errorPass:null;
                            }
                          }*/
                          return null;
                        },
                        obscureText:obscureConfirmPassword,
                        decoration: textFormInputDecorationForPassword
                          (Icons.visibility_off,
                            getTranslated(context,"Confirm Password",)!
                            ,(){
                              setState(() {
                                obscureConfirmPassword= !obscureConfirmPassword;
                              });
                            },obscureConfirmPassword),
                      ),

                      const SizedBox(height: 10,),
                      /*GenderPickerWithImage(
                        verticalAlignedText: false,
                        selectedGender: Gender.Male,
                        selectedGenderTextStyle: const TextStyle(
                            color: customColor, fontWeight: FontWeight.bold),
                        unSelectedGenderTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                        onChanged: (Gender? gender) {
                          myGender=gender==Gender.Male?"male":"female";
                          print(gender);
                        },
                        equallyAligned: true,
                        animationDuration: const Duration(milliseconds: 300),
                        isCircular: true,
                        // default : true,
                        opacityOfGradient: 0.4,
                        padding: const EdgeInsets.all(3),
                        size: 50, //default : 40
                      ),*/
                      const SizedBox(height: 20,),
                     state is LoadingRegisterState?
                     const Center(
                       child:  SpinKitChasingDots(
                         color: customColor,
                         size: 40,
                       ),
                     ):
                      customButton((){
                        if (_formKey.currentState!.validate()) {
                          if(confirmPassController.text==passController.text){
                            RegisterCubit.get(context).getToken
                              (nameController.text,
                                phoneController.text,
                                countryCode.substring(1),
                                emailController.text,
                                passController.text,
                                Localizations.localeOf(context).languageCode,
                                context,
                                myGender);
                          }else{
                            _scaffoldKey.
                            currentState!.
                            showSnackBar(SnackBar(content:
                            customText("Please Check Confirm PassWord",color: Colors.white),
                              backgroundColor: customColor,));
                          }
                        }
                      },
                          context,
                          getTranslated(context,"Sign Up",)!
                          ,textColor: Colors.white,
                          height: MediaQuery.of(context).size.height / 16,
                          width: MediaQuery.of(context).size.width
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              getTranslated(context,"have a account?",)!
                              ,
                              color: Colors.grey),
                          const SizedBox(width: 5,),
                          InkWell(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context)=>const LoginScreen()),
                                      (route) => false);
                            },
                            child: customText(
                                getTranslated(context,"Sign In",)!
                                ,
                                color: HexColor("#FF000A")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
      },),
    );
  }
}
