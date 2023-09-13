import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/bloc_provider.dart';
import 'package:travo_demo/features/auth/utils/list_country.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/features/auth/widgets/media_button.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_bloc.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_event.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_event.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  _changeTheme (BuildContext context){
    context.read<ThemeBloc>().add(ChangeThemeEvent());
  }

  _changeBtnColor (BuildContext context){
    context.read<ButtonColorBloc>().add(ButtonColorEvent());
  }

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;
  String curPhoneCode = '84';

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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isPassWordValid(String password) => password.length >= 8;

  @override
  Widget build(BuildContext context) {
    Color? textSpanColor =  Theme.of(context).textTheme.bodyLarge!.color;
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
                          icon:  Icon(Icons.brightness_6, color: color,),
                          
                          
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
                        "sign_up".tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("let_crt_acc".tr(), style: const TextStyle(color: Colors.white, fontSize: 14),)
                    ],
                  ),
            ),
            toolbarHeight: 30,
          
              // ),
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
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "name".tr(),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.account_circle_sharp)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   
                    DropdownButtonFormField(
                      value: 'Viet Nam',
                      items: listCountry.map((ListCountry country) {
                        return DropdownMenuItem<String>(
                          value: country.countryName,
                          child: Text(country.countryName),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: "country".tr(),
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.flag_circle)
                      ), 
                      onChanged: (value){
                        context.read<AuthPhoneCodeCubit>().changePhoneCode(value!);
                      }
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromARGB(255, 97, 97, 97)),
                              borderRadius: const  BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4)
                              )),
                              
                            child: BlocBuilder<AuthPhoneCodeCubit, String>(
                              builder: (context, curPhoneCode) => Center(
                                child: Text('+$curPhoneCode', style: const TextStyle(fontSize: 18),)
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          flex:4,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: "phone_number".tr(),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4)
                                  )
                                ),
                                prefixIcon: const Icon(Icons.phone)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(text: "textspan1".tr(), style: TextStyle(color: textSpanColor)),
                            TextSpan(text: "textspan2".tr(), style: const TextStyle(color: Colors.purple)),
                            TextSpan(text: "textspan3".tr(), style: TextStyle(color: textSpanColor)),
                            TextSpan(text: "textspan4".tr(), style: const TextStyle(color: Colors.purple)),
                            TextSpan(text: "textspan5".tr(), style: TextStyle(color: textSpanColor))
                          ]
                        ),
                      ),
                    ),
                    AuthButton(formKey: _formKey, text: "sign_up".tr(),),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("or_signup_with".tr()),
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
                  ],
                )),
          ),
        ));
  }
}
