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

  @override
  void dispose() {
    promoCodeController.dispose();
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
                    "Promo Code",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFieldCustom(
              controller: promoCodeController, 
              validator: Validator.checkNull, 
              labelText: 'Promo Code', 
              inputFormat: FilteringTextInputFormatter.singleLineFormatter, 
              keyboardType: TextInputType.text, 
            ),

            const SizedBox(height: 10,),
            CustomButton(
              onPressed: () => Navigator.pop(
                    context, promoCodeController.text
                  ),
              text: 'Done',
              width: 200)
          ],
        ),
      ),
    );
  }
}