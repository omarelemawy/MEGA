

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gnon/screens/auth/login/login_screen.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:gnon/sharedPreferences.dart';
import 'localization/app_localization.dart';


String? language;
String? locale1;
Locale? _locale;
String? email;

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  language = await MySharedPreferences.getAppLang();
  if(language!=null){
    locale1=language;
  }
  if(language!=null) {
    _locale = Locale(language!);
  }
   email=await MySharedPreferences().getUserUserEmail();
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
// /*
//   final fcmToken = await FirebaseMessaging.instance.
//   getToken(vapidKey:
//   "BGaisRobnHwY0N2eyGD_rx6gHCz7cScyuUlVtBufcELzeLiKymnsWsw5jlQIStu7q5A2EIPjv-oa6MqEdlq2ors");*/
//  /* await FirebaseMessaging.instance.setAutoInitEnabled(true);*/
//   FirebaseMessaging.onBackgroundMessage((message)async{
//     print(message);
//   });
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   print('User granted permission: ${settings.authorizationStatus}');
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      supportedLocales: const [
        Locale('ar', 'EG'),
      ],
      locale: _locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if(_locale!=null&&_locale!.languageCode.split("_")[0]==
            supportedLocales.first.languageCode){
          return supportedLocales.first;
        }
        else if(_locale!=null&&
            _locale!.languageCode.split("_")[0]==supportedLocales.last.languageCode){
          return supportedLocales.first;
        }
        else {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode) {
              return deviceLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MaterialApp(
            supportedLocales: const [
              Locale('ar', 'EG'),
             /* Locale('en', 'US'),*/
            ],
            locale: _locale,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              if(language==null){
                for (var locale in supportedLocales) {
                  if (locale.languageCode == deviceLocale!.languageCode) {
                    print("oijoioihio");
                    language= deviceLocale.toString();
                    locale1=deviceLocale.toString();
                    print(locale1);
                  }
                }
                language==null?locale1=supportedLocales.first.languageCode:locale1=language;
                supportedLocales.first;
              }

              if(_locale!=null&&_locale!.languageCode.split("_")[0]==
                  supportedLocales.first.languageCode){
                print("llldvvddvdl22222");
                return supportedLocales.first;
              }
              else if(_locale!=null&&
                  _locale!.languageCode.split("_")[0]==supportedLocales.last.languageCode){
                print("llldvvddvdll3333");
                return supportedLocales.first;
              }
              else {
                for (var locale in supportedLocales) {
                  if (locale.languageCode == deviceLocale!.languageCode) {
                    return supportedLocales.first;
                  }
                }
              }
              print("llldvvddvdll4444");
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
            ),
            home: email==null?LoginScreen():email==""?LoginScreen():FirstScreen(email)
        ),
    );
  }
}

//import io.flutter.embedding.android.FlutterActivity
//
//
//class Application : FlutterApplication(), PluginRegistrantCallback {
//    // ...
//    @Override
//    fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
//    }
//
//    @Override
//    fun registerWith(registry: PluginRegistry?) {
//        GeneratedPluginRegistrant.registerWith(registry)
//    } // ...zz
//}*/
//class MainActivity: FlutterActivity() {}
