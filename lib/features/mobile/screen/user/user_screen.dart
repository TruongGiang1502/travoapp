import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travo_demo/features/mobile/manage_user/screens/setting_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/utils/show_dialog.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';
import 'package:travo_demo/utils/validate.dart';
import 'package:travo_demo/widgets/text_field_custom.dart';



class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  String? userEmail = FirebaseAuth.instance.currentUser?.email.toString();
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController countryController;
  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final countryFocus = FocusNode();

  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    countryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
    countryController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    countryFocus.dispose();
    super.dispose();
  }

  Future <void> upDateData(String name, String email)async{
    try{
      await FirebaseFirestore.instance.doc('/user/$email').update({'username': name});
      // ignore: use_build_context_synchronously
      ShowDialog.showSimpleDialog(context, 'Success', 'Update User Success');
    } catch(error){
      // ignore: use_build_context_synchronously
      ShowDialog.showSimpleDialog(context, 'Error', 'Update User Failed! Please try again\n Failed: ${error.toString()}');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions:  [
               Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
                      },
                      icon: const Icon(Icons.settings, color: Colors.white,),
                    )
                  ],
                ),
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
                        "user_title".tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
 
                    ],
                  ),
            ),
            
            toolbarHeight: 30,
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: 
            userEmail == null? 
            const Center(child: Text('Some error occured!'),) 
            : StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').doc(userEmail!).snapshots(),
              builder: (context, snapshotUser) {
                var snap = snapshotUser.data?.data();
                SnapUserModel userModel = SnapUserModel.fromSnap(snap);
                emailController.text = userModel.email!;
                phoneController.text = '+${userModel.phoneNumber!}';
                nameController.text = userModel.userName!;
                countryController.text = userModel.country!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFieldCustom(
                        controller: nameController,
                        focusNode: nameFocus, 
                        validator: Validator.checkNull, 
                        labelText: 'name'.tr(),
                        inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                        keyboardType: TextInputType.text,
                        suffix:  Icon(
                            Icons.edit,
                            color: greyColor,
                            size: 20,
                          )
                        ),
                      const SizedBox(height: 10,),
                      TextFieldCustom(
                        controller: emailController,
                        focusNode: emailFocus, 
                        validator: Validator.emailValidator, 
                        labelText: 'email'.tr(),
                        readOnly: true,
                        inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10,),
                      TextFieldCustom(
                        controller: countryController,
                        focusNode: countryFocus, 
                        validator: Validator.checkNull, 
                        labelText: 'country'.tr(),
                        readOnly: true, 
                        inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10,),
                      TextFieldCustom(
                        controller: phoneController, 
                        focusNode: phoneFocus,
                        validator: Validator.checkNull,
                        readOnly: true, 
                        labelText: 'phone_number'.tr(), 
                        inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(
                        onPressed: (){
                          upDateData(nameController.text,  emailController.text);
                        }, 
                        text: 'Save', 
                        width: 0.4
                      )
                    ],
                  ),
                );
              }
            ),
        )
    );
  }
}