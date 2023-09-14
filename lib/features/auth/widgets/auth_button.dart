import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function onPressed; 
  final GlobalKey<FormState> formKey;
  final String text;
  const AuthButton({super.key, required this.formKey, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width*0.75,
      decoration:BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(143, 103, 232, 1),
            Color.fromRGBO(99, 87, 204, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(50)
      ),
      child: ElevatedButton(
          onPressed: (){
            if(formKey.currentState!.validate()){
              onPressed();
            }
          },
          //  formKey.currentState!.validate()? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0
          ),
          child: Text(text)
        ),
    );
  }
}