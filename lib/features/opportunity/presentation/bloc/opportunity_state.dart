part of 'opportunity_bloc.dart';

class OpportunityState extends Equatable {
  final String tempTitle;
  final String tempDescription;
  final LatLng? selectedLocation;
  final String? address;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<String>? tempRequiredSkills;

  const OpportunityState({
    this.tempTitle = '',
    this.tempDescription = '',
    this.selectedLocation,
    this.address,
    this.startDateTime,
    this.endDateTime,
    this.tempRequiredSkills,
  });

  @override
  List<Object> get props => [
        tempTitle,
        tempDescription,
        selectedLocation ?? const LatLng(0, 0),
        address ?? '',
        startDateTime ?? DateTime(0),
        endDateTime ?? DateTime(0),
        tempRequiredSkills ?? [],
      ];

  List<String> skills() {
    return AppKeywordConstants.skills;
  }
}
