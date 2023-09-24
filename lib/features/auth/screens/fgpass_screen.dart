import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/auth/screens/login_screen.dart';
import 'package:travo_demo/features/auth/utils/validate.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void resetPassWord(String email)async{
      await _auth.sendPasswordResetEmail(email: email);
    }
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
                      validator: Validator.emailValidator,
                      decoration: InputDecoration(
                          labelText: "email".tr(),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    AuthButton(
                      onPressed: (){
                        resetPassWord(emailController.text);
                        Navigator.pushAndRemoveUntil(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                          ), (route) => false
                          );
                      },
                      formKey: _formKey, 
                      text: "send".tr(),
                    ),

                  ],
                )),
          ),
        ));
  }
}
