import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/payment_options_card.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';


class CheckOutPayment extends StatelessWidget {
  const CheckOutPayment({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier <bool> isMiniMarketChosen = ValueNotifier(false);
    ValueNotifier <bool> isCardChosen = ValueNotifier(false);
    ValueNotifier <bool> isBankChosen = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PaymentOptionsCard(
            isChosen: isMiniMarketChosen, 
            iconUrl: 'images/checkout_icon/mini_market.svg', 
            text: 'Mini Market',
            onChanged: (){
              isCardChosen.value = false;
              isBankChosen.value = false;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          PaymentOptionsCard(
            isChosen: isCardChosen, 
            iconUrl: 'images/checkout_icon/credit_card.svg', 
            text: 'Credit / Debit Card',
            child: addCardBuider(''),
            onChanged: (){
              isMiniMarketChosen.value = false;
              isBankChosen.value = false;
            },
          ), 
          const SizedBox(
            height: 10,
          ),
          PaymentOptionsCard(
            isChosen: isBankChosen, 
            iconUrl: 'images/checkout_icon/bank_transfer.svg', 
            text: 'Bank Transfer',
            onChanged: (){
              isCardChosen.value = false;
              isMiniMarketChosen.value = false;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            onPressed: (){

            }, 
            text: 'Done', 
            width: 1
          )
        ],
      ),
    );
  }
}

Widget addCard(Widget? child){
  if(child == null){
    return const SizedBox();
  }
  return child;
}

Widget addCardBuider(String text){
  return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth * 0.9,
        decoration: BoxDecoration(
            color: linkWater,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            FloatingActionButton(
              heroTag: 'addCard_hero',
              onPressed: (){},
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            addCardtWidget(text),
          ],
        ),
      );
    });
}

Widget addCardtWidget(String text) {
    if(text==''){
      return Text(
        'Add Card',
        style: TextStyle(
            color: indigo,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      );
    }
    else {
      return Text(
        text,
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13),
      );
    }
  }