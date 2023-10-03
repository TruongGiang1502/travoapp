import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/providers/auth_phonecode_cubit.dart';
import 'package:travo_demo/features/auth/utils/list_country.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class PickCountryButton extends StatelessWidget {
  final bool isChangePhoneCode;
  const PickCountryButton({super.key, this.isChangePhoneCode = false});

  @override
  Widget build(BuildContext context) {
    String countryname = 'Viet Nam';
    return ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 16
        ),
        child: Center(
          child: DropdownButtonFormField(
            value: countryname,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
            items: listCountry.map((ListCountry country) {
              return DropdownMenuItem<String>(
                value: country.countryName,
                child: Text(country.countryName),
              );
            }).toList(),
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Country',
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: (value){
              countryname = value!;
              isChangePhoneCode
                ?context.read<AuthPhoneCodeCubit>().changePhoneCode(value)
                :(){};
            }
          )
        ),
      ),
    );
  }
}