import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
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

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void notChange(){}

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
                    "Add Card",
                    style: TextStyle(
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
                  labelText: 'Name', 
                  inputFormat: FilteringTextInputFormatter.singleLineFormatter,
                  keyboardType: TextInputType.name,
                  prefix: null,
                ),
                const SizedBox(height: 20,),
                TextFieldCustom(
                  controller: cardNumberController,
                  validator: Validator.checkNull,
                  labelText: 'Card Number', 
                  inputFormat: FilteringTextInputFormatter.digitsOnly,
                  lengthInput: 20,
                  keyboardType: TextInputType.number,
                  prefix: Padding(
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
                        labelText: 'Exp. Date', 
                        inputFormat: FilteringTextInputFormatter.singleLineFormatter,
                        lengthInput: 5,
                        keyboardType: TextInputType.datetime,
                        prefix: null,
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
                        prefix: null,
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                const PickCountryButton(),
                const SizedBox(height: 20,),
                CustomButton(
                  onPressed: (){}, 
                  text: 'Add Card', 
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