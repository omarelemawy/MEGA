import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/MediaButton.dart';
import '../../../constants/color_constans.dart';
import '../../../constants/themes.dart';
import '../../../localization/localization_constants.dart';
import '../login/cubit_login/login_cubit.dart';
import '../login/cubit_login/login_state.dart';

class ResetPassScreen extends StatefulWidget {
   ResetPassScreen({Key? key,this.email}) : super(key: key);
  String? email;
  @override
  _ResetPassScreenState createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pinController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        builder:(context, state) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                centerTitle: false,

                leading: IconButton(onPressed: (){
                  Navigator.pop(context);

                },
                    icon: Icon(Icons.arrow_back_ios,color: HexColor("#9098B1"),size: 15,)),
              ),
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
                        Image.asset("lib/images/gnon-red-logo.png",height: 150,width: 150,),
                        const SizedBox(height: 20,),
                        customText("Reset PassWord"
                            , fontWeight: FontWeight.w100,size: 16,color: HexColor("#9098B1")),
                        const SizedBox(height: 40,),
                        TextFormField(
                          controller: pinController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your Email Is Not Correct ",)!
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              prefixIcon: const Icon(Icons.qr_code),
                              hintText: getTranslated(context, "Pin Code",)!,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),

                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: passController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your Email Is Not Correct ",)!
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              prefixIcon: const Icon(Icons.lock),
                              hintText: getTranslated(context, "Password",)!,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),

                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: confirmPassController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your Email Is Not Correct ",)!
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              prefixIcon: const Icon(Icons.lock),
                              hintText: getTranslated(context, "password confirmation",)!,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),

                        const SizedBox(height: 60,),
                        state is ResetPassLoadingLoginState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):
                        customButton((){
                          if (_formKey.currentState!.validate()) {
                            print("bbsdrbge");
                            if(confirmPassController.text==passController.text) {
                              LoginCubit.get(context).
                              resetPass(Localizations
                                      .localeOf(context)
                                      .languageCode,
                                  context,
                                  pinController.text,
                                  passController.text,
                                  confirmPassController.text,
                                  widget.email
                              );
                            }
                          }
                        },context,
                            getTranslated(context, "Confirm",)!
                            ,textColor: Colors.white,
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width
                        ),
                        const SizedBox(height: 15),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        listener: (context,state){
          if(state is ForgetPassErrorLoginState){
            _scaffoldKey.currentState!.
            showSnackBar(SnackBar(content: customText(state.error,color: Colors.white),
              backgroundColor: customColor,));
          }
        },
      ),
    );
  }
}
