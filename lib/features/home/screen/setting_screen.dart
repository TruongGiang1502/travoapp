import 'package:flutter/material.dart';
import 'package:travo_demo/features/home/utils/show_dialog.dart';
import 'package:travo_demo/features/home/widget/setting_options.dart';


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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Setting",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      //Text("hi_wc".tr(), style: const TextStyle(color: Colors.white, fontSize: 14),)
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
              ShowDialog.showLogoutConfirmationDialog(context);
            }, 
            icon: Icons.logout, 
            text: 'Logout',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}