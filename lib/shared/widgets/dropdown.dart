import 'package:flutter/material.dart';

class QDropdownField extends StatefulWidget {
  final String label;
  final String? hint;
  final List<Map<String, dynamic>> items;
  final String? Function(Map<String, dynamic>? value)? validator;
  final dynamic value;
  final bool emptyMode;
  final Function(dynamic value, String? label) onChanged;

  const QDropdownField({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.emptyMode = true,
    this.hint,
  }) : super(key: key);

  @override
  State<QDropdownField> createState() => _QDropdownFieldState();
}

class _QDropdownFieldState extends State<QDropdownField> {
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic>? selectedValue;

  @override
  void initState() {
    super.initState();

    items = [];
    if (widget.emptyMode) {
      items.add({
        "label": "-",
        "value": "-",
      });
      selectedValue = {
        "label": "-",
        "value": "-",
      };
    }

    // Menambahkan lebih banyak item untuk contoh
    for (var item in widget.items) {
      items.add(item);
    }

    var values = widget.items.where((i) => i["value"] == widget.value).toList();
    if (values.isNotEmpty) {
      selectedValue = values.first;
    }
  }

  Map<String, dynamic>? get currentValue {
    if (widget.emptyMode) {
      var foundItems =
          items.where((i) => i["value"] == selectedValue?["value"]).toList();
      if (foundItems.isNotEmpty) {
        return foundItems.first;
      }

      return {
        "label": "-",
        "value": "-",
      };
    }
    return items.first;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: false,
      validator: (value) {
        if (widget.validator != null) {
          if (widget.emptyMode && selectedValue?["value"] == "-") {
            return widget.validator!(null);
          }
          return widget.validator!(selectedValue);
        }
        return null;
      },
      enabled: true,
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: widget.label,
            errorText: field.errorText,
            helperText: widget.hint,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFFB30F),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: false,
              child: SizedBox(
                child: DropdownButton<Map<String, dynamic>>(
                  isExpanded: true,
                  value: currentValue,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 24.0,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  dropdownColor: const Color.fromARGB(255, 255, 253, 253),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (Map<String, dynamic>? newValue) {
                    if (widget.emptyMode && newValue?["value"] == "-") {
                      selectedValue = {
                        "label": "-",
                        "value": "-",
                      };
                    } else {
                      selectedValue = newValue!;
                    }
                    setState(() {});

                    var label = selectedValue!["label"];
                    var value = selectedValue!["value"];
                    widget.onChanged(value, label);
                  },
                  items: [
                    // Menambahkan item separator sebagai dropdown item yang berbeda
                    ...items.expand((item) {
                      return [
                        DropdownMenuItem<Map<String, dynamic>>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item["label"],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Menambahkan divider di antara item, kecuali item terakhir
                        if (items.indexOf(item) < items.length - 1)
                          DropdownMenuItem<Map<String, dynamic>>(
                            enabled: false,
                            value: null, // Memberikan item kosong untuk divider
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                              height: 1,
                            ),
                          ),
                      ];
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
