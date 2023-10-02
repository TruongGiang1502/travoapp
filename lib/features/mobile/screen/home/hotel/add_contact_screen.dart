import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/auth_phonecode_cubit.dart';
import 'package:travo_demo/features/auth/utils/list_country.dart';
import 'package:travo_demo/features/auth/utils/validate.dart';
import 'package:travo_demo/features/mobile/screen/home/models/info_guest_model.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

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
    final size = MediaQuery.of(context).size;
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
                        value: countryname,
                        items: listCountry.map((ListCountry country) {
                          return DropdownMenuItem<String>(
                            value: country.countryName,
                            child: Text(country.countryName),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                            labelText: "country".tr(),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.flag_circle)),
                        onChanged: (value) {
                          countryname = value!;
                          context
                              .read<AuthPhoneCodeCubit>()
                              .changePhoneCode(value);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefix: SizedBox(
                            //color: Colors.red,
                            width: 50,
                            child: BlocBuilder<AuthPhoneCodeCubit, String>(
                                builder: (context, curPhoneCode) => Center(
                                        child: Text(
                                          '+$curPhoneCode',
                                          style: const TextStyle(fontSize: 18),
                                        )
                                      )
                                    ),
                          ),
                          labelText: "phone_number".tr(),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4))),
                          prefixIcon: const Icon(Icons.phone)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    CustomButton(
                        onPressed: () => Navigator.pop(
                              context, information()
                            ),
                        text: 'Done',
                        width: size.width)
                  ],
                )
              ),
          ),
        )
      );
  }
}
