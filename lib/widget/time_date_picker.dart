import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimeDatePicker({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      onTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Date Picker
        Expanded(
          child: TextFormField(
            readOnly: true,
            onTap: () => _pickDate(context),
            decoration: const InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              suffixIcon: Icon(Icons.calendar_today, size: 18),
            ),
            controller: TextEditingController(
              text: DateFormat('yyyy-MM-dd').format(selectedDate),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Time Picker
        Expanded(
          child: TextFormField(
            readOnly: true,
            onTap: () => _pickTime(context),
            decoration: const InputDecoration(
              labelText: 'Time',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              suffixIcon: Icon(Icons.access_time, size: 18),
            ),
            controller: TextEditingController(
              text: selectedTime.format(context),
            ),
          ),
        ),
      ],
    );
  }
}
