import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'field_tile.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.title,
      this.controller,
      required this.onChanged,
      this.keyboardType,
      this.errorMessage,
      this.inputFormatters,
      this.prefixIcon,
      this.datePicker,
      this.readOnly})
      : super(key: key);

  final String title;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  String? labelText;
  TextInputType? keyboardType;
  String? errorMessage;
  List<TextInputFormatter>? inputFormatters;
  Widget? prefixIcon;
  VoidCallback? datePicker;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        FieldTitle(
          title: title,
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: customDecoration(context),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: readOnly ?? false,
                    controller: controller,
                    keyboardType: keyboardType ?? TextInputType.text,
                    inputFormatters: inputFormatters ?? [],
                    decoration: InputDecoration(
                        labelText: labelText,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 23, maxHeight: 20),
                        prefixIcon: prefixIcon,
                        border: InputBorder.none,
                        isCollapsed: true),
                    onChanged: onChanged,
                  ),
                ),
                if (datePicker != null)
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: datePicker!,
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                    ),
                    // color: Colors.orange,
                  )
                else
                  const SizedBox(
                    height: 20,
                  ),
              ],
            )),
        const SizedBox(
          height: 4,
        ),
        errorMessage == null
            ? Container()
            : Text(
                errorMessage ?? '',
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
      ],
    );
  }
}
