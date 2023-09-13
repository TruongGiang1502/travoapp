import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, String>{

  LanguageBloc(): super('vi'){
    on<LanguageChangeEvent>((event, emit) => _changeLocale(emit));
  } 

  _changeLocale (Emitter emit){
    emit(state == 'vi'? 'en': 'vi');
  }
}