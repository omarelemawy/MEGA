import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gnon/screens/account/account_bloc/account_cubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/color_constans.dart';
import '../../../constants/themes.dart';
import '../../../localization/localization_constants.dart';
import '../account_bloc/account_state.dart';

class ReplacementPolicyScreen extends StatefulWidget {
  const ReplacementPolicyScreen({Key? key}) : super(key: key);

  @override
  _ReplacementPolicyScreenState createState() =>
      _ReplacementPolicyScreenState();
}

class _ReplacementPolicyScreenState extends State<ReplacementPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit()..getPrivacy(10431),
      child: BlocConsumer<AccountCubit, AccountState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var privacyModel = AccountCubit.get(context).privacyModel;
    return Scaffold(
        appBar: /*state is GetReplacementPolicyLoadingAccountState?*/
        AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: privacyModel==null?
          const Center(
              child:  SpinKitChasingDots(
                color: customColor,
                size: 40,
              )):
          customText( AccountCubit.get(context).privacyModel!.title!.rendered!,
            fontWeight: FontWeight.bold,),
          centerTitle: false,
        ),
        body: privacyModel==null?
        const Center(
            child:  SpinKitChasingDots(
              color: customColor,
              size: 40,
            )):
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              AccountCubit.get(context).privacyModel!.content!.rendered!,
              customStylesBuilder: (element) {
                if (element.classes.contains('foo')) {
                  return {'color': 'red'};
                }
                return null;
              },
              // render a custom widget
              customWidgetBuilder: (element) {
                if (element.attributes['foo'] == 'bar') {
                  return Container();
                }
                return null;
              },
              isSelectable: true,
              onErrorBuilder: (context, element, error) =>
                  ExpandableText(
                    AccountCubit.get(context).privacyModel!.content!.rendered!,
                    expandText: getTranslated(context, "show more",)!,
                    collapseText: getTranslated(context, "show less",)!,
                    expandOnTextTap: true,
                    maxLines: 4,
                    style: TextStyle(
                        color: HexColor("#9098B1"),
                        fontWeight: FontWeight.w300,
                        fontSize: 12
                    ),
                    linkColor: Colors.blue,
                  ),
              onLoadingBuilder: (context, element, loadingProgress) =>
                  CircularProgressIndicator(),
              renderMode: RenderMode.column,
              textStyle: TextStyle(fontSize: 14),
              webView: true,
            ),
          ),
        ),
      );
  },
),

    );
  }
}
