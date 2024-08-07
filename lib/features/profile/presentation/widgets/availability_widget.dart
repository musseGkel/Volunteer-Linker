import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/keyword_constants.dart';

import '../../../../constants/app_colors.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/widgets/common_button.dart';
import '../bloc/profile_bloc/profile_bloc.dart';

class AvailabilityWidget extends StatefulWidget {
  final bool editMode;
  const AvailabilityWidget({super.key, this.editMode = false});

  @override
  _AvailabilityWidgetState createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  late Map<String, List<TimeRange>> _availability;

  @override
  void initState() {
    _availability = context.read<ProfileBloc>().state.tempAvailability ?? {};
    super.initState();
  }

  String? _selectedDay;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  bool _showTimeError = false;
  String _timeErrorMessage = '';

  void _addAvailability() {
    if (_selectedDay == null) {
      setState(() {
        _showTimeError = true;
        _timeErrorMessage = 'Select the day.';
      });
      return;
    } else if (_selectedStartTime == null) {
      setState(() {
        _showTimeError = true;
        _timeErrorMessage = 'Select the start time.';
      });
      return;
    } else if (_selectedEndTime == null) {
      setState(() {
        _showTimeError = true;
        _timeErrorMessage = 'Select the end time.';
      });
      return;
    }

    if (_selectedDay != null &&
        _selectedStartTime != null &&
        _selectedEndTime != null) {
      _timeErrorMessage = "";
      _showTimeError = false;

      // Calculate time difference in minutes
      int startMinutes =
          _selectedStartTime!.hour * 60 + _selectedStartTime!.minute;
      int endMinutes = _selectedEndTime!.hour * 60 + _selectedEndTime!.minute;
      int timeDifference = endMinutes - startMinutes;

      if (timeDifference < 30) {
        setState(() {
          _showTimeError = true;
          _timeErrorMessage = 'Time gap must be at least 30 minutes.';
        });
        return;
      }

      setState(() {
        _showTimeError = false;
        _timeErrorMessage = '';
        if (_availability[_selectedDay!] == null) {
          _availability[_selectedDay!] = [];
        }
        _availability[_selectedDay!]!
            .add(TimeRange(_selectedStartTime!, _selectedEndTime!));
        _selectedStartTime = null; // Reset the times after adding
        _selectedEndTime = null;
      });
    }
  }

  Future<void> _pickTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }

        // Validate if start and end times are the same
        if (_selectedStartTime == _selectedEndTime) {
          _showTimeError = true;
          _timeErrorMessage = 'Start and end time cannot be the same.';
        } else {
          _showTimeError = false;
          _timeErrorMessage = '';
        }
      });
    }
  }

  void _exportAvailability(ProfileState profileState) {
    _availability.forEach((day, times) {});

    BlocProvider.of<ProfileBloc>(context).add(
      UpdateAvailability(
        availability: _availability,
        state: profileState,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.editMode)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: AppColors.greyColor),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Select a day'),
                              value: _selectedDay,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDay = newValue;
                                });
                              },
                              items: AppKeywordConstants.daysOfWeek
                                  .map<DropdownMenuItem<String>>(
                                (String day) {
                                  return DropdownMenuItem<String>(
                                    value: day,
                                    child: Text(day),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.editMode)
                const SizedBox(
                  height: 8,
                ),
              _showTimeError
                  ? Center(
                      child: Text(
                        _timeErrorMessage,
                        style: const TextStyle(color: AppColors.red),
                      ),
                    )
                  : const SizedBox.shrink(),
              if (widget.editMode)
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        right: 60,
                        bottom: 6,
                        top: 6,
                      ),
                      child: CommonButton(
                        borderRadius: BorderRadius.circular(8),
                        fontSize: 14,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryBorderColor,
                        text: _selectedStartTime == null
                            ? 'Select Start Time'
                            : 'Start Time: ${_selectedStartTime!.format(context)}',
                        textColor: AppColors.primaryTextColor,
                        onTap: () => _pickTime(context, true),
                        contentColor: AppColors.primaryTextColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        right: 60,
                        bottom: 6,
                      ),
                      child: CommonButton(
                        borderRadius: BorderRadius.circular(8),
                        fontSize: 14,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryBorderColor,
                        text: _selectedEndTime == null
                            ? 'Select End Time'
                            : 'End Time: ${_selectedEndTime!.format(context)}',
                        textColor: AppColors.primaryTextColor,
                        onTap: () => _pickTime(context, false),
                        contentColor: AppColors.primaryTextColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        right: 60,
                        bottom: 6,
                      ),
                      child: CommonButton(
                        borderRadius: BorderRadius.circular(8),
                        fontSize: 14,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryBorderColor,
                        text: 'Add Availability',
                        textColor: AppColors.primaryTextColor,
                        onTap: _addAvailability,
                        contentColor: AppColors.primaryTextColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 100,
                        right: 100,
                      ),
                      child: CommonButton(
                        borderRadius: BorderRadius.circular(8),
                        fontSize: 14,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryBorderColor,
                        text: 'Save',
                        textColor: AppColors.primaryTextColor,
                        onTap: () {
                          _exportAvailability(state);
                        },
                        contentColor: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              const Text(
                'Selected Times:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: state.tempAvailability!.keys.map((day) {
                  final times = state.tempAvailability![day] ?? [];
                  return ListTile(
                    title: Text(day),
                    subtitle: Text(
                      times
                          .map((time) =>
                              '${time.start.format(context)} to ${time.end.format(context)}')
                          .join(', '),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
