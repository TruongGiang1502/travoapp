import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';


class GetInfoCubit extends Cubit<List<InfoGuest>>{
  GetInfoCubit():super([]);

  void getInfo (InfoGuest info){
    state.add(info);
    emit(List.from(state));
  }

  void removeInfo (InfoGuest info){
    state.remove(info);
    emit(List.from(state));
  }
}