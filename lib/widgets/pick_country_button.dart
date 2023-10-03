import 'package:flutter/material.dart';
import 'package:travo_demo/features/auth/utils/list_country.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class PickCountryButton extends StatelessWidget {
  final String countryName;
  final bool isChangePhoneCode;
  final Function(String?) onChanged;
  const PickCountryButton({super.key, this.isChangePhoneCode = false, required this.countryName,required this.onChanged});

  @override
  Widget build(BuildContext context) {

    return ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 16
        ),
        child: Center(
          child: DropdownButtonFormField(
            value: countryName,
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
            onChanged: onChanged
          )
        ),
      ),
    );
  }
}