import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/screen/home/models/card_info_model.dart';

class GetCardCubit extends Cubit<PayCard>{
  GetCardCubit():super(const PayCard(name: '', cardNumber: '', expDate: '', cvv: '', country: ''));

  void getCard(PayCard card){
    emit(card);
  }
}