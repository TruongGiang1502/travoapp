import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/auth_phonecode_cubit.dart';
import 'package:travo_demo/features/auth/screens/fgpass_screen.dart';
import 'package:travo_demo/features/auth/screens/login_screen.dart';
import 'package:travo_demo/features/auth/screens/signup_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_card_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_contact_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_promo_code.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/detail_hotel_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/result_hotel_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/select_room_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_card_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_info_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_paytype_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_promo_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/time_check_cubit.dart';
import 'package:travo_demo/features/mobile/screen/main_screen.dart';
import 'package:travo_demo/screen/onboard/onboard_screen_main.dart';

Route <dynamic> generateRoute (RouteSettings settings){
  switch (settings.name){
    case OnboardScreenMain.routeName:
      return MaterialPageRoute(builder: (context) => const OnboardScreenMain());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());

    case SignupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AuthPhoneCodeCubit(),
          child: const SignupScreen(),
        )
      );

    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MainScreen());

    case ResultHotelScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ResultHotelScreen());

    case DetailHotelScreen.routeName:
      final snapInfoandId = settings.arguments as (SnapHotelModel, String);
      return MaterialPageRoute(builder: (context) => DetailHotelScreen(snapInfo: snapInfoandId.$1, snapId: snapInfoandId.$2));

    case SelectRoomScreen.routeName:
      final streamsnap = settings.arguments as Stream<QuerySnapshot<Map<String, dynamic>>>;
      return MaterialPageRoute(builder: (context) => SelectRoomScreen(streamsnap: streamsnap));

    case CheckOutScreen.routeName:
      final snapInfo = settings.arguments as (SnapRoomModel, String);
      return MaterialPageRoute(builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create:(context) => GetInfoCubit(),),
          BlocProvider(create:(context) => GetPromoCodeCubit()),
          BlocProvider(create: (context) => GetCardCubit()),
          BlocProvider(create: (context) => TimeCheckinCubit()),
          BlocProvider(create: (context) => TimeCheckoutCubit()),
          BlocProvider(create: (context) => PayTypeCubit()),
        ],
        child:CheckOutScreen(snapInfo: snapInfo.$1, roomID: snapInfo.$2,) ,
      ));

    case AddContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AuthPhoneCodeCubit(),
          child: const AddContactScreen()
        )
      );

    case AddPromoCodeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AddPromoCodeScreen());

    case AddCardScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AddCardScreen());
      
    default:
      return MaterialPageRoute(builder: (context) => const CircularProgressIndicator());
  }
}