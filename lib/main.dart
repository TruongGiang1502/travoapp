import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/screen/splash_screen.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_bloc.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';


void main() async{
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
       //const MyApp()
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
          return BlocBuilder<LanguageBloc, String>(
            builder: (
              (context, langCode) {
                
                return MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: Locale(langCode),
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  home: const SplashScreen()
                );
              }
            ),
          );
        }),
      );
  }
}

