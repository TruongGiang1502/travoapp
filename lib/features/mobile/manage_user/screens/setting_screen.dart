import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/utils/show_dialog.dart';
import 'package:travo_demo/features/mobile/widget/setting_options.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_event.dart';

void _changeTheme (BuildContext context){
  context.read<ThemeBloc>().add(ChangeThemeEvent());
}

void _changeLanguage(BuildContext context){
  if(context.locale == const Locale('en', 'US')){
    context.setLocale(const Locale('vi', 'VN'));
  }
  else{
    context.setLocale(const Locale('en', 'US'));
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage('images/auth_background_appbar.png'),
                      fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "setting".tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                  ),
            ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 10,),
          SettingOption(
            onPressed: (){
              _changeLanguage(context);
            }, 
            icon: Icons.translate, 
            text: 'lan'.tr(),
            color: Colors.black,
          ),
          SettingOption(
            onPressed: (){
              _changeTheme(context);  
            }, 
            icon: Icons.brightness_6, 
            text: 'Brightness',
            color: Colors.black,
          ),
          SettingOption(
            onPressed: (){
              ShowDialog.showLogoutConfirmationDialog(context);
            }, 
            icon: Icons.logout, 
            text: 'logout'.tr(),
            color: Colors.red,
          ),
          
        ],
      ),
    );
  }
}