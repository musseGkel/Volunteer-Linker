part of 'opportunity_bloc.dart';

class OpportunityState extends Equatable {
  final String tempTitle;
  final String tempDescription;
  final List<String>? tempLocation;
  final DateTime? tempDate;
  final DateTime? tempTime;
  final int? tempDuration;
  final List<String>? tempRequiredSkills;

  const OpportunityState({
    this.tempTitle = '',
    this.tempDescription = '',
    this.tempLocation,
    this.tempDate,
    this.tempTime,
    this.tempDuration,
    this.tempRequiredSkills,
  });

  @override
  List<Object> get props => [
        tempTitle,
        tempDescription,
        tempLocation ?? [],
        tempDate ?? DateTime(0),
        tempTime ?? DateTime(0),
        tempDuration ?? 0,
        tempRequiredSkills ?? [],
      ];

  List<String> skills() {
    return AppKeywordConstants.skills;
  }
}
