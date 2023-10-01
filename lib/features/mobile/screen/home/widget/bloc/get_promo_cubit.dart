import 'package:flutter_bloc/flutter_bloc.dart';

class GetPromoCodeCubit extends Cubit<String>{
  GetPromoCodeCubit():super('');
  void getPromoCode (String promoCode){
    emit(promoCode);
  }
}