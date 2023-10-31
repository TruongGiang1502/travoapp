import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/auth/widgets/auth_button.dart';
import 'package:travo_demo/features/mobile/screen/home/models/card_info_model.dart';
import 'package:travo_demo/utils/validate.dart';
import 'package:travo_demo/widgets/pick_country_button.dart';
import 'package:travo_demo/widgets/text_field_custom.dart';

class AddCardScreen extends StatefulWidget {
  static const routeName = '/add_card_screen';
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expDateController = TextEditingController();
  final cvvController = TextEditingController();

  String countryname = 'Viet Nam';

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  PayCard cardInfo(){
    final cardInfo = PayCard(
      name: nameController.text, 
      cardNumber: cardNumberController.text, 
      expDate: expDateController.text, 
      cvv: cvvController.text, 
      country: countryname
    );
    return cardInfo;
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
                    "addcard".tr(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldCustom(
                  controller: nameController,
                  validator: Validator.checkNull,
                  labelText: "name".tr(), 
                  inputFormat: FilteringTextInputFormatter.singleLineFormatter,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20,),
                TextFieldCustom(
                  controller: cardNumberController,
                  validator: Validator.checkNull,
                  labelText: "cardnum".tr(), 
                  inputFormat: FilteringTextInputFormatter.digitsOnly,
                  lengthInput: 20,
                  keyboardType: TextInputType.number,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset('images/checkout_icon/card_num_icon.svg'),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFieldCustom(
                        controller: expDateController,
                        validator: Validator.checkNull,
                        labelText: "expdate".tr(), 
                        inputFormat: FilteringTextInputFormatter.singleLineFormatter,
                        lengthInput: 5,
                        keyboardType: TextInputType.datetime,

                      )
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFieldCustom(
                        controller: cvvController,
                        validator: Validator.checkNull,
                        labelText: 'CVV', 
                        inputFormat: FilteringTextInputFormatter.digitsOnly,
                        lengthInput: 3,
                        keyboardType: TextInputType.number,
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                PickCountryButton(
                  countryName: countryname,
                  onChanged: (value){
                    countryname = value!;
                  },
                ),
                const SizedBox(height: 20,),
                AuthButton(
                  formKey: formKey,
                  onPressed: (){
                    Navigator.pop(context, cardInfo());
                  }, 
                  text: "addcard".tr(), 
                  width: 1
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}