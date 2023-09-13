import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/bloc_provider.dart';
import 'package:travo_demo/features/auth/screens/fgpass_screen.dart';
import 'package:travo_demo/features/auth/screens/signup_screen.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/features/auth/widgets/media_button.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_bloc.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_event.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_bloc.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_event.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;
  bool isChecked = false;

  _changeTheme (BuildContext context){
    context.read<ThemeBloc>().add(ChangeThemeEvent());
  }

  _changeBtnColor (BuildContext context){
    context.read<ButtonColorBloc>().add(ButtonColorEvent());
  }

  _changeLocale (BuildContext context){
    context.read<LanguageBloc>().add(LanguageChangeEvent());
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

  String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Enter Password';
    } else if (password.length < 8) {
      return 'Password must have at least 8 character';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isPassWordValid(String password) => password.length >= 8;

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
                          icon: 
                             Icon(Icons.brightness_6, color: color,),
                          
                          
                        ),
                        IconButton(
                          onPressed: () {
                            _changeLocale(context);
                          }, 
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
                        "Login".tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("hi_wc".tr(), style: const TextStyle(color: Colors.white, fontSize: 14),)
                    ],
                  ),
            ),
            
            toolbarHeight: 30,
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                      height: 20,
                    ),

                    TextFormField(
                      controller: passwordController,
                      validator: passwordValidator,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                          labelText: "password".tr(),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(
                              passToggle? Icons.visibility : Icons.visibility_off
                            ),
                          )
                        ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Checkbox(
                          value: isChecked, 
                          onChanged: (bool? newValue){
                            setState(() {
                              isChecked = newValue!;
                            });
                          }
                        ),
                        Text("remember_me".tr(), style: const TextStyle(fontSize: 15),),
                        const Spacer(),
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPasswordScreen()));
                          }, 
                          child: Text("forgot_password".tr())
                        ),
                      ],
                    ),

                    AuthButton(formKey: _formKey, text:  "Login".tr(),),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("or_login_with".tr()),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MediaLoginButton(
                            onPressed: () {},
                            backgroundColor: Colors.white,
                            iconUrl: 'images/google_icon.svg',
                            text: ' Google',
                            textColor: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MediaLoginButton(
                            onPressed: () {},
                            backgroundColor: Colors.blue[900],
                            iconUrl: 'images/facebook_icon.svg',
                            text: ' Facebook',
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("not_account".tr()),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(
                                create: (context) => AuthPhoneCodeCubit(),
                                child: const SignupScreen(),
                              )));
                            }, 
                            child: Text("sign_up".tr())
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      );
  }
}
