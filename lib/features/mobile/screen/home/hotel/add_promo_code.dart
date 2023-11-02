import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/validate.dart';
import 'package:travo_demo/widgets/text_field_custom.dart';

class AddPromoCodeScreen extends StatefulWidget {
  static const routeName = '/add_promocode_screen';
  const AddPromoCodeScreen({super.key});

  @override
  State<AddPromoCodeScreen> createState() => _AddPromoCodeScreenState();
}

class _AddPromoCodeScreenState extends State<AddPromoCodeScreen> {
  final promoCodeController = TextEditingController();
  final promoCodeFocus = FocusNode();

  @override
  void dispose() {
    promoCodeController.dispose();
    promoCodeFocus.dispose();
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
                    "promocode".tr(),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFieldCustom(
              controller: promoCodeController,
              focusNode: promoCodeFocus, 
              validator: Validator.checkNull, 
              labelText: "promocode".tr(), 
              inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
              keyboardType: TextInputType.text, 
            ),

            const SizedBox(height: 10,),
            CustomButton(
              onPressed: () => Navigator.pop(
                    context, promoCodeController.text
                  ),
              text: "done".tr(),
              width: 200)
          ],
        ),
      ),
    );
  }
}