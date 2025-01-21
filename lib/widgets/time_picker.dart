import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class TimePicker extends StatelessWidget {
  final int value;
  final Function(int) onChanged;

  const TimePicker({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: value,
      minValue: 0,
      maxValue: 59,
      onChanged: onChanged,
    );
  }
}
