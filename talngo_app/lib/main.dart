import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Locale/language_cubit.dart';
import 'Locale/locale.dart';
import 'Routes/routes.dart';
import 'Screens/splash_Screen.dart';
import 'Theme/style.dart';

Future main()async{

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
);
 
  runApp(Phoenix(
    
      child: BlocProvider(
        create: (context) => LanguageCubit(),
        child: MyApp(),
      )));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        localizationsDelegates: [
          AppLocalizationsDelegate(),
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
          const Locale('id'),
          const Locale('fr'),
          const Locale('pt'),
          const Locale('es'),
          const Locale('it'),
          const Locale('sw'),
          const Locale('tr'),
        ],

        theme: appTheme,
        locale: locale,
        home: SplashScreen(),
        routes: PageRoutes().routes(),
      ),
    );
  }
}


