import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/screens/auth/login/cubit_login/login_cubit.dart';
import 'package:gnon/screens/auth/register/register_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../constants/MediaButton.dart';
import '../../../constants/themes.dart';
import '../../../localization/localization_constants.dart';
import '../../../main.dart';
import '../../../models/language.dart';
import '../../../models/user_data.dart';
import '../../../sharedPreferences.dart';
import '../../home/home_screen.dart';
import '../forget_pass/forget_pass.dart';
import 'cubit_login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool obscurePassword=true;
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);

    MyApp.setLocale(context, _locale);
    MySharedPreferences.saveAppLang(_locale.toString());
    UserDateModel.appLang = await MySharedPreferences.getAppLang();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        builder:(context, state) =>
            Scaffold(
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
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*PopupMenuButton(
                            icon: Icon(
                              Icons.language,
                              color: HexColor("#40BFFF"),
                            ),
                            itemBuilder: (context){
                              return Language.languageList()
                                  .map<PopupMenuItem<Language>>(
                                    (e) => PopupMenuItem<Language>(
                                  value: e,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        e.flag,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      Text(e.name)
                                    ],
                                  ),
                                ),
                              ).toList();
                            },
                            onSelected:(Language value){
                              _changeLanguage(value);
                            }
                        ),*/

                        const Spacer(),
                        TextButton(onPressed: ()async{
                         await MySharedPreferences.saveUserUserEmail("");
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                              (context)=> HomeScreen(Localizations.localeOf(context).languageCode,0,
                                email: "",)), (route) => false);
                        }, child: customText(getTranslated(context, 'skip')!)),
                      ],
                    ),
                    Image.asset("lib/images/gnon-red-logo.png",height: 80,),
                    const SizedBox(height: 30,),
                    customText(getTranslated(context, "Welcome  to MEGA Store",)!,
                        fontWeight: FontWeight.bold,
                        size: 16),
                    const SizedBox(height: 10,),
                    customText(getTranslated(context, "Sign in to continue",)!,
                        fontWeight: FontWeight.w100,size: 12,color: HexColor("#9098B1")),
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
                    const SizedBox(height: 20,),

                    TextFormField(
                      controller: passController,
                      validator: (val) =>val!.isEmpty?
                      getTranslated(context, " Oops! Your Password Is Not Correct ",)!
                          : null,
                      obscureText:obscurePassword,
                      decoration: textFormInputDecorationForPassword
                        (Icons.visibility_off,getTranslated(context, "Password",)!
                          ,(){
                            setState(() {
                              obscurePassword= !obscurePassword;
                            });
                          },obscurePassword),
                    ),

                    const SizedBox(height: 20,),
                    state is LoadingLoginState?
                     const Center(
                       child:  SpinKitChasingDots(
                         color: customColor,
                         size: 40,
                       ),
                     ):
                    customButton((){
                      if (_formKey.currentState!.validate()) {
                        print("bbsdrbge");
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                            (context)=>HomeScreen("en",0,email: email,)), (route) => false);
                       /* LoginCubit.get(context).
                        loginWithEmail(emailController.text,
                            passController.text,
                            Localizations.localeOf(context).languageCode,
                            context
                        );*/
                      }
                       },context,
                        getTranslated(context, "Sign In",)!
                        ,textColor: Colors.white,
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * .3,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                            getTranslated(context, "OR",)!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey
                            )
                        ),
                        const SizedBox(width: 5),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * .3,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                     InkWell(
                      onTap: () {
                        setState(() {
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            Image.asset("lib/images/Google.png"),
                            const SizedBox(width: 80,),
                            Text(
                                getTranslated(context, "Login with Google",)!
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        /*setState(() async{
                     AccessToken? result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
                          if (result!.userId.isNotEmpty) {
                            // you are logged
                            final String accessToken = result.token;
                          } else {
                            print(result.token);
                            print(result.userId);
                          }
                        });*/
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.blueAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 80,),
                            Text(getTranslated(context, "Login with FaceBook",)!
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: SignInWithAppleButton(
                        text: getTranslated(context, "Sign in with Apple",)!
                        ,
                        onPressed: () {

                        },
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>ForgetPassScreen()));
                      },
                      child: customText(getTranslated(context, "Forgot Password?")!
                          ,
                          color: HexColor("#FF000A")),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(getTranslated(context, "Don’t have a account?")!,
                            color: Colors.grey),
                        const SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                                (context)=>const RegisterScreen()), (route) => false);
                          },
                          child: customText(getTranslated(context, "Register")!,
                              color: HexColor("#FF000A")),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
        listener: (context,state){
          if(state is ErrorLoginState){
            _scaffoldKey.currentState!.
            showSnackBar(SnackBar(content: customText(state.error,color: Colors.white),
              backgroundColor: customColor,));
          }
        },
      ),
    );
  }
}
