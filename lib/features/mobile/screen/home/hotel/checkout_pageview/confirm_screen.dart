import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_info_cubit.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInfoCubit, List <InfoGuest>>(
        builder: (context, info) {
          return Center(
            child: Text('${info.length}')
          );
        }
      );
  }
}