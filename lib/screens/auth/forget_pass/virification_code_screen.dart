import 'package:flutter/material.dart';
import 'package:gnon/screens/auth/forget_pass/reset_pass.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constants/MediaButton.dart';
import '../../../constants/themes.dart';
import '../../../localization/localization_constants.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pinController=TextEditingController();
  int codeLength = 4;
  String? code;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                customText(getTranslated(context, "Verification Code")!
                    , fontWeight: FontWeight.w100,size: 16,color: HexColor("#9098B1")),
                const SizedBox(height: 20,),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: codeLength,
                  // onCompleted: (val) {
                  //   _timer!.cancel();
                  //   code = val;
                  //   setState(() {
                  //     loading = !loading;
                  //   });
                  //   PhoneAuthCredential phoneAuthCredential =
                  //   PhoneAuthProvider.credential(
                  //       verificationId: verificationId!,
                  //       smsCode: verificationCode!);
                  //   signInWithPhonAuthCredential(phoneAuthCredential);
                  // },
                  onChanged: (val) {
                    /*code = val;*/
                  },
                  validator:(v) {
                    if (v!.length < codeLength)
                      return  "من فضلك اكمل الكود";
                    /*else {
                      bool isNumeric = int.tryParse(code!) != null;
                      if (!isNumeric) return "برجاء ادخال الكود المرسل";
                    }*/
                    return null;
                  },
                  textStyle: TextStyle(color: Colors.black),
                  autoFocus: true,
                  appContext: context,
                ),

                const SizedBox(height: 20,),
                customButton((){
                  if (_formKey.currentState!.validate()) {
                    print("bbsdrbge");
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>ResetPassScreen()));
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
    );
  }
}
