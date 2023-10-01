import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

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
      appBar: AppBar(
        title: const Text('Add promo code'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            TextField(
              controller: promoCodeController,
              decoration: const InputDecoration(
                  labelText: 'Promo Code',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)),
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