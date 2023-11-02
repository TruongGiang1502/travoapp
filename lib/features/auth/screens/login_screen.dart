import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travo_demo/features/auth/screens/fgpass_screen.dart';
import 'package:travo_demo/features/auth/screens/signup_screen.dart';
import 'package:travo_demo/features/auth/services/firebase_auth_method.dart';
import 'package:travo_demo/utils/color.dart';
import 'package:travo_demo/utils/validate.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/features/auth/widgets/media_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_demo/widgets/text_field_custom.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  ValueNotifier <bool> passToggle = ValueNotifier(true);

  ValueNotifier <bool> isChecked = ValueNotifier(false);

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
    emailFocus.dispose();
    passwordFocus.dispose();
    passToggle.dispose();
    isChecked.dispose();
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
                    TextFieldCustom(
                      controller: emailController,
                      focusNode: emailFocus, 
                      validator: Validator.emailValidator, 
                      labelText: "email".tr(), 
                      inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                      keyboardType: TextInputType.text
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: passToggle,
                      builder: (context, isHide, child) {
                        return TextFieldCustom(
                          controller: passwordController,
                          focusNode: passwordFocus, 
                          validator: Validator.passwordValidator,
                          obscureText: isHide, 
                          labelText: "password".tr(), 
                          inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                          keyboardType: TextInputType.text,
                          suffix: InkWell(
                                onTap: () {
                                  passToggle.value = !isHide;
                                },
                                child: Icon(
                                  isHide? Icons.visibility : Icons.visibility_off
                                ),
                              ),
                        );
                      }
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: isChecked,
                          builder: (BuildContext context, bool value, Widget? child) {
                            return Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                side: BorderSide.none,
                                value: value,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                checkColor: indigo,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return linkWater!;
                                  }
                                ),
                                onChanged: (index) {
                                  isChecked.value = index!;
                                }
                              ),
                            );
                          }
                        ),
                        Text("remember_me".tr(), style: const TextStyle(fontSize: 15),),
                        const Spacer(),
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                          }, 
                          child: Text(
                            "forgot_password".tr(),
                            style: TextStyle(
                              color: indigo
                            ),
                          )
                        ),
                      ],
                    ),

                    AuthButton(
                      onPressed: loginUser,
                      formKey: _formKey, 
                      text:  "Login".tr(),
                      width: 0.75,
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
                              Navigator.pushNamed(context, SignupScreen.routeName);
                            }, 
                            child: Text(
                              "sign_up".tr(),
                              style: TextStyle(
                                color: indigo
                              ),
                            )
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
