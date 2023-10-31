// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:travo_demo/widgets/blocs/language_bloc/language_event.dart';

// class LanguageBloc extends Bloc<LanguageEvent, Locale>{

//   Locale locale = const Locale('en', 'US');
//   LanguageBloc(): super(const Locale('en', 'US')){
//     on<LanguageChangeEvent>((event, emit) => _changeLocale(emit));
//   } 

//   _changeLocale (Emitter emit){
//     emit(state.countryCode == 'US' ? const Locale ('vi', 'VN'): const Locale ('en', 'US'));
//   }
// }