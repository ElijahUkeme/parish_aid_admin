
import 'package:flutter/material.dart';

import 'custom_input_border.dart';

class CustomDatePicker extends StatefulWidget {
  final TextStyle? style;
  final String? hintText;
  final String? text;
  final void Function(String) onSelected;
  final DateTime lastDate;
  final DateTime? firstDate;
  final Color? color;

  const CustomDatePicker({
    Key? key,
    this.style,
    this.text,
    this.hintText,
    this.firstDate,
    this.color,
    required this.onSelected,
    required this.lastDate,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final controller = TextEditingController();
  TextStyle textFieldStyle = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );

  String? finalDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text != null) {
      controller.text = widget.text!;
    }
    return Container(
      height: 50.0,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: widget.style ?? textFieldStyle,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 24.0,
          ),
          hintText: widget.hintText,
          hintStyle: widget.style?.copyWith(
                color: Colors.black.withOpacity(0.7),
              ) ??
              textFieldStyle,
          suffixIcon: Icon(
            Icons.calendar_month,
            color: Colors.blue.shade900.withOpacity(0.8),
          ),
          border: CustomInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? Theme.of(context).primaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: CustomInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: CustomInputBorder(
            borderSide: BorderSide(
              color: widget.color ?? Theme.of(context).primaryColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          // prefix: const Padding(padding: EdgeInsets.all(8)),
        ),
        onTap: () async {
          final selectedDate = await selectDate();

          if (selectedDate != null) {
            widget.onSelected.call(
              '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
            );
          }
        },
      ),
    );
  }

  Future<DateTime?> selectDate() async {
    final date = showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(1990),
        lastDate: widget.lastDate,
        builder: ((context, child) {
          return Theme(
            data: ThemeData(
              colorScheme:  ColorScheme.light(
                  primary: Colors.blue.shade900.withOpacity(0.8),
                  onPrimary: Colors.white,
                  onSurface: Colors.black),
              primaryColor: Colors.blue.shade900.withOpacity(0.8),
            ),
            child: child!,
          );
        }));

    return date;
  }
}
