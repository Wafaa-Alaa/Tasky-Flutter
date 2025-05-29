import 'package:flutter/material.dart';

class CustomeTextFieled extends StatelessWidget {
  CustomeTextFieled({super.key,required this.title,required this.hintText,required this.controller, this.validator,this.maxLins=1
  });
  final String title;
  final String hintText;
  final int? maxLins;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        title!,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          fontSize: 20,
        ),
      ),
          SizedBox(height: 8,),
          TextFormField(
          decoration: InputDecoration(
          hintText: hintText,
          ),
          maxLines: maxLins,
          validator: (String? value)=>validator!=null ?validator!(value):null,
          controller:controller,
          ),
        ],
      );
  }
}
