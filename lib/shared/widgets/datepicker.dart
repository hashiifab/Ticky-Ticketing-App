import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QDatePicker extends StatefulWidget {
  final String label;
  final DateTime? value;
  final String? hint;
  final String? Function(String?)? validator;
  final Function(DateTime) onChanged;

  const QDatePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<QDatePicker> createState() => _QDatePickerState();
}

class _QDatePickerState extends State<QDatePicker> {
  DateTime? selectedValue;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    controller = TextEditingController(
      text: getInitialValue(),
    );
  }

  String getInitialValue() {
    if (widget.value != null) {
      return DateFormat("d MMM y").format(widget.value!); // Swiss style format
    }
    return "-";
  }

  String getFormattedValue() {
    if (selectedValue != null) {
      return DateFormat("d MMM y").format(selectedValue!); // Swiss style format
    }
    return "-";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFFFFB30F), // Accent color, minimalistic
                
                buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          selectedValue = pickedDate;
          controller.text = getFormattedValue();
          setState(() {});
          widget.onChanged(selectedValue!);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(selectedValue?.toString());
            }
            return null;
          },
          readOnly: true,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Color(0xff393e48), // Neutral text color
              fontSize: 16.0, // Clean and minimal text size
              fontWeight: FontWeight.w500, // Balanced weight
            ),
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black12), // Soft border
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFFB30F), // Accent color on focus
              ),
            ),
          ),
        ),
      ),
    );
  }
}
