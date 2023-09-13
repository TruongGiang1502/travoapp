import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_event.dart';

class ButtonColorBloc extends Bloc<ColorEvent, Color> {
  ButtonColorBloc():super(Colors.black){
    on<ButtonColorEvent>((event, emit) => _changeColor(emit));
  }
  
  _changeColor(Emitter emit){
    emit(state == Colors.black? Colors.white : Colors.black);
  }

}
