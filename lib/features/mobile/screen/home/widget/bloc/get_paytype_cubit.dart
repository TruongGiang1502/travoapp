import 'package:flutter_bloc/flutter_bloc.dart';

class PayTypeCubit extends Cubit<String>{
  PayTypeCubit():super('');

  void getTypeCubit(String type){
    emit(type);
  }
}