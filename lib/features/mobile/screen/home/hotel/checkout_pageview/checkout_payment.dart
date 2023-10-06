import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_card_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/card_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_card_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_paytype_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/payment_options_card.dart';
import 'package:travo_demo/features/mobile/utils/show_dialog.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';

class CheckOutPayment extends StatelessWidget {
  final VoidCallback onPressed;
  const CheckOutPayment({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isCashChosen = ValueNotifier(false);
    ValueNotifier<bool> isCardChosen = ValueNotifier(false);
    ValueNotifier<bool> isBankChosen = ValueNotifier(false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PaymentOptionsCard(
            isChosen: isCashChosen,
            iconUrl: 'images/checkout_icon/mini_market.svg',
            text: 'Cash at Hotel',
            onChanged: () {
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
            child: addCardBuider(),
            onChanged: () {
              isCashChosen.value = false;
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
            onChanged: () {
              isCardChosen.value = false;
              isCashChosen.value = false;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<GetCardCubit, PayCard>(
            builder: (context, cardInfo) {
              return CustomButton(
                onPressed: (){
                  goToConfirmPage(
                    context: context, 
                    onPressed: onPressed, 
                    isCash: isCashChosen.value, 
                    isCard: isCardChosen.value, 
                    isBank: isBankChosen.value, 
                    cardInfo: cardInfo
                  );
                }, 
                text: 'Done', 
                width: 1
              );
            }
          )
        ],
      ),
    );
  }
}

Widget addCard(Widget? child) {
  if (child == null) {
    return const SizedBox();
  }
  return child;
}

Widget addCardBuider() {
  return LayoutBuilder(builder: (context, constraint) {
    return Container(
      width: constraint.maxWidth * 0.9,
      decoration: BoxDecoration(
          color: linkWater, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          FloatingActionButton(
            heroTag: 'addCard_hero',
            onPressed: () {
              gotoGetCardScreen(context);
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          BlocBuilder<GetCardCubit, PayCard>(builder: (context, cardInfo) {
            return addCardtWidget(cardInfo);
          }),
        ],
      ),
    );
  });
}

Widget addCardtWidget(PayCard cardInfo) {
  if (cardInfo.name == '') {
    return Text(
      'Add Card',
      style:
          TextStyle(color: indigo, fontWeight: FontWeight.bold, fontSize: 18),
    );
  } else {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardInfo.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text('${cardInfo.cardNumber} (${cardInfo.country})',
              style: const TextStyle(color: Colors.black, fontSize: 12)),
        ],
      ),
    );
  }
}

void gotoGetCardScreen(BuildContext context) async {
  final cardInfo = await Navigator.pushNamed(context, AddCardScreen.routeName);
  if (cardInfo != null && cardInfo is PayCard) {
    // ignore: use_build_context_synchronously
    context.read<GetCardCubit>().getCard(cardInfo);
  }
}

void goToConfirmPage(
    {required BuildContext context,
    required VoidCallback onPressed,
    required bool isCash,
    required bool isCard,
    required bool isBank,
    required PayCard cardInfo }) {
  if(isCash){
    context.read<PayTypeCubit>().getTypeCubit('cash');
  }    
  else if(isCard){
    if(cardInfo.name == ''){
      ShowDialog.showSimpleDialog(
        context, 
        'No card', 
        'You should have add your card information ' 
        'if you want to use "Card Payment" method. Or you can chose the another payment method'
      );
      return;
    }
    context.read<PayTypeCubit>().getTypeCubit('card');
  }
  else if(isBank){
    context.read<PayTypeCubit>().getTypeCubit('bank');
  }
  else{
    ShowDialog.showSimpleDialog(
      context, 
      'No payment method', 
      'You should have chose a payment method' 
    );
    return;
  } 
  onPressed();
}
