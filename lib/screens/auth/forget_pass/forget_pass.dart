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

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController=TextEditingController();

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
                        customText(getTranslated(context, "Fill Your Email to continue",)!,
                            fontWeight: FontWeight.w100,size: 16,color: HexColor("#9098B1")),
                        const SizedBox(height: 40,),
                        TextFormField(
                          controller: emailController,
                          validator: (val) =>val!.isEmpty?
                          getTranslated(context, " Oops! Your Email Is Not Correct ",)!
                              : null,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              prefixIcon: const Icon(Icons.mail_outline),
                              hintText: getTranslated(context, "Your Email",)!,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),


                        const SizedBox(height: 60,),
                        state is ForgetPassLoadingLoginState?
                        const Center(
                          child:  SpinKitChasingDots(
                            color: customColor,
                            size: 40,
                          ),
                        ):
                        customButton((){
                          if (_formKey.currentState!.validate()) {
                            print("bbsdrbge");
                            LoginCubit.get(context).
                            forgetPass(emailController.text,
                                Localizations.localeOf(context).languageCode,
                                context
                            );
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
