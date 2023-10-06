import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCheckinCubit extends Cubit<DateTime>{
  TimeCheckinCubit():super(DateTime.now());
  void getCheckinTime(DateTime time){
    emit(time);
  }
}

class TimeCheckoutCubit extends Cubit<DateTime>{
  TimeCheckoutCubit():super(DateTime.now());
  void getCheckoutTime(DateTime time){
    emit(time);
  }
}