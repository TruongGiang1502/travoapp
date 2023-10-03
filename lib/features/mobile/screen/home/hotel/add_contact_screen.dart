import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/auth_phonecode_cubit.dart';
import 'package:travo_demo/features/auth/utils/list_country.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/utils/validate.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:travo_demo/widgets/pick_country_button.dart';
import 'package:travo_demo/widgets/text_field_custom.dart';

class AddContactScreen extends StatefulWidget {
  static const routeName = '/add_contact_screen';
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

  String countryname = 'Viet Nam';

  InfoGuest information() {
    final phoneCode = listCountry.firstWhere((element) => element.countryName == countryname).phoneCode;
    final infoGuest = InfoGuest(
      name: nameController.text, 
      email: emailController.text, 
      phoneNumber: phoneCode + phoneController.text
    );
    return infoGuest;
    
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Contact",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldCustom(
                      controller: nameController,
                      validator: Validator.checkNull, 
                      labelText: "name".tr(), 
                      inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PickCountryButton(
                      countryName: countryname,
                      isChangePhoneCode: true,
                      onChanged: (value){
                        countryname = value!;
                        context.read<AuthPhoneCodeCubit>().changePhoneCode(value);
                      }
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AuthPhoneCodeCubit, String>(
                      builder: (context, curPhoneCode) {
                        return TextFieldCustom(
                          controller: phoneController, 
                          validator: Validator.checkNull, 
                          labelText: 'Phone Number', 
                          inputFormat: FilteringTextInputFormatter.digitsOnly, 
                          keyboardType: TextInputType.number, 
                          prefixText: '+$curPhoneCode | ',
                        );
                      }
                    ),
                    
                    const SizedBox(
                      height: 20,
                    ),
                    
                    TextFieldCustom(
                      controller: emailController,
                      validator: Validator.emailValidator, 
                      labelText: "email".tr(), 
                      inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthButton(
                      formKey: _formKey, 
                      text: 'Done', 
                      onPressed: () => 
                        Navigator.pop(
                          context, information()
                        ),
                      width: 1,
                    ),
                  ],
                )
              ),
          ),
        )
      );
  }
}
