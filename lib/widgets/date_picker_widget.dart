import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DatePickerWidget {
  final DateTime initialDate;
  final DateTime firstDate;

  DatePickerWidget({
    required this.initialDate,
    required this.firstDate,
  });

  Future pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: firstDate.add(Duration(days: 14)));

    return picked ?? initialDate;
  }
}
