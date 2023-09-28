import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/utils/list_country.dart';

class AuthPhoneCodeCubit extends Cubit<String>{
  AuthPhoneCodeCubit() : super('84');
  void changePhoneCode(String value){
    emit(listCountry.firstWhere((element) => element.countryName == value).phoneCode);
  }
}