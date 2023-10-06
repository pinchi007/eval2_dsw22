import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPassWordFaild;
  final String? hintText;
  final String? labelText;
  final FormFieldSetter<String>? onSave;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType?  inputType;



  const FormContainerWidget({super.key,

    this.controller,
    this.isPassWordFaild,
    this.hintText,
    this.labelText,
    this.onSave,
    this.fieldKey,
    this.inputType,
    this.onFieldSubmitted,
    this.validator,

  });



  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration (
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPassWordFaild == true ? _obscureText : false,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child:
            widget.isPassWordFaild==true ? Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: _obscureText == false ? Colors.blue : Colors.grey,
            ):Text(""),
          )
        ),


      ),
    );

  }
}