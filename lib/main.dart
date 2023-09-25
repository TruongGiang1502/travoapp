import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/firebase_options.dart';
import 'package:travo_demo/route.dart';
import 'package:travo_demo/screen/splash_screen.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_bloc.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc()
        ),
        BlocProvider<ButtonColorBloc>(
          create: (BuildContext context) => ButtonColorBloc(),
        ),
        BlocProvider<LanguageBloc>(
          create: (BuildContext context) => LanguageBloc(),
        )
      ], 
      child: EasyLocalization(
        supportedLocales: const [
          Locale("en", "US"),
          Locale("vi", "VN"),
        ], 
        path: 'assets/translations',
        fallbackLocale: const Locale("en", "US"),
        child: const MyApp(),
      )

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ThemeBloc, ThemeData>(
        builder: ((context, theme) {
          return BlocConsumer<LanguageBloc, (String, String)>(
            listener: (context, locale) {
              context.setLocale(Locale(locale.$1, locale.$2));
            },
            builder: (
              (context, langCode) {
                
                context.setLocale(Locale(langCode.$1, langCode.$2));
                return MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  onGenerateRoute: (settings) => generateRoute(settings),
                  home: const SplashScreen()
                );
              }
            ),

          );
        }),
      );
  }
}

