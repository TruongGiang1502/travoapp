import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(_lightTheme){
    on<ChangeThemeEvent>((event, emit) => _changeTheme(emit));
  }

  void _changeTheme (Emitter emit){
    emit(state.brightness == Brightness.dark? _lightTheme : _darkTheme);
  } 
  
  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}