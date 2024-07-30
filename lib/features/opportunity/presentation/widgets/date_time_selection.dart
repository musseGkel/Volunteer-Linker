import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelection extends StatefulWidget {
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final Function(DateTime startDateTime, DateTime endDateTime)
      onDateTimeChanged;

  const DateTimeSelection({
    Key? key,
    this.startDateTime,
    this.endDateTime,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  _DateTimeSelectionState createState() => _DateTimeSelectionState();
}

class _DateTimeSelectionState extends State<DateTimeSelection> {
  late DateTime _startDateTime;
  late DateTime _endDateTime;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startDateTime = widget.startDateTime ?? DateTime.now();
    _endDateTime = widget.endDateTime ?? DateTime.now().add(const Duration(hours: 1));
  }

  Future<void> _selectDateTime({
    required DateTime initialDateTime,
    required bool isStart,
  }) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDateTime),
      );

      if (selectedTime != null) {
        final DateTime newDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (isStart) {
          // Check if the new start date-time is after the current end date-time
          if (newDateTime.isAfter(_endDateTime)) {
            setState(() {
              _errorMessage = 'Start date-time cannot be after end date-time.';
            });
            return;
          }
          setState(() {
            _startDateTime = newDateTime;
            _errorMessage = null;
          });
        } else {
          // Check if the new end date-time is before the current start date-time
          if (newDateTime.isBefore(_startDateTime)) {
            setState(() {
              _errorMessage = 'End date-time cannot be before start date-time.';
            });
            return;
          }
          setState(() {
            _endDateTime = newDateTime;
            _errorMessage = null;
          });
        }

        widget.onDateTimeChanged(_startDateTime, _endDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        Text(
            "Start Date & Time: ${DateFormat.yMMMd().add_jm().format(_startDateTime)}"),
        TextButton(
          onPressed: () =>
              _selectDateTime(initialDateTime: _startDateTime, isStart: true),
          child: const Text("Select Start Date & Time"),
        ),
        const SizedBox(height: 16),
        Text(
            "End Date & Time: ${DateFormat.yMMMd().add_jm().format(_endDateTime)}"),
        TextButton(
          onPressed: () =>
              _selectDateTime(initialDateTime: _endDateTime, isStart: false),
          child: const Text("Select End Date & Time"),
        ),
      ],
    );
  }
}
