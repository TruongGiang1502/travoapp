import 'package:flutter_bloc/flutter_bloc.dart';

class GetInfoCubit extends Cubit<String>{
  GetInfoCubit():super('');
  void getInfo (String info){
    emit(info);
  }
}