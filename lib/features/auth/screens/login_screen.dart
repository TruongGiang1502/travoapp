import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/bloc_provider.dart';
import 'package:travo_demo/features/auth/screens/fgpass_screen.dart';
import 'package:travo_demo/features/auth/screens/signup_screen.dart';
import 'package:travo_demo/features/auth/services/firebase_auth_method.dart';
import 'package:travo_demo/features/auth/utils/validate.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/features/auth/widgets/media_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  ValueNotifier <bool> isChecked = ValueNotifier(false);
  ValueNotifier <bool> ispassToggle = ValueNotifier(false);

  void loginUser() async {
    await FirebaseAuthMethod().loginWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context
    );
    if(isChecked.value){
      _savedLoginInfo();
    }
  }

  _savedLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setBool('isLogin', isChecked.value);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                      validator: Validator.emailValidator,
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
                      validator: Validator.passwordValidator,
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
                        ValueListenableBuilder(
                          valueListenable: isChecked,
                          builder: (BuildContext context, bool value, Widget? child) {
                            return Checkbox(
                              value: isChecked.value, 
                              onChanged: (bool? newValue){
                                  isChecked.value = newValue!;
                              }
                            );
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

                    AuthButton(
                      onPressed: loginUser,
                      formKey: _formKey, 
                      text:  "Login".tr(),
                    ),

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
