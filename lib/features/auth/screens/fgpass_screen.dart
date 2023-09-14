import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_bloc.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_event.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_event.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  
  _changeTheme (BuildContext context){
    context.read<ThemeBloc>().add(ChangeThemeEvent());
  }

  _changeBtnColor (BuildContext context){
    context.read<ButtonColorBloc>().add(ButtonColorEvent());
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  String? emailValidator(String? email) {
    if (email!.isEmpty) {
      return 'Enter email';
    } else if (!isEmailValid(email)) {
      return 'Email is not valid';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions:  [
              BlocBuilder <ButtonColorBloc, Color>(
                builder: (
                  (context, color){
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _changeBtnColor(context);
                            _changeTheme(context);
                          }, 
                          icon: Icon(Icons.brightness_6, color: color,),
                          
                          
                        ),
                        IconButton(
                          onPressed: () {}, 
                          icon: Icon(Icons.translate, color: color,)
                        ),
                      ],
                    );
                  }
                ),
              )
            ],
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
                        "forgot_password".tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30, 
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5,),
                      Text("note_forgot".tr(), style: const TextStyle(color: Colors.white, fontSize: 12),)
                    ],
                  ),
            ),
            toolbarHeight: 30,
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextFormField(
                      controller: emailController,
                      validator: emailValidator,
                      decoration: InputDecoration(
                          labelText: "email".tr(),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    AuthButton(
                      onPressed: (){},
                      formKey: _formKey, 
                      text: "send".tr(),
                    ),

                  ],
                )),
          ),
        ));
  }
}
