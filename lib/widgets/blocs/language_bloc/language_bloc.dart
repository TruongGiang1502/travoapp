import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, (String, String)>{

  LanguageBloc(): super(('en', 'US')){
    on<LanguageChangeEvent>((event, emit) => _changeLocale(emit));
  } 

  _changeLocale (Emitter emit){
    emit(state == ('en', 'US') ? ('vi', 'VN'): ('en', 'US'));
  }
}