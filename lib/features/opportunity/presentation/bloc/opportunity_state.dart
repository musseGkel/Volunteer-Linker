part of 'opportunity_bloc.dart';

class OpportunityState extends Equatable {
  final String tempTitle;
  final String tempDescription;
  final LatLng? selectedLocation;
  final String? address;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final List<String>? tempRequiredSkills;
  final bool isLoading;
  final String errorMesssage;
  final bool opportunityPosted;

  const OpportunityState({
    this.tempTitle = '',
    this.tempDescription = '',
    this.selectedLocation,
    this.address,
    this.startDateTime,
    this.endDateTime,
    this.tempRequiredSkills,
    this.isLoading = false,
    this.errorMesssage = '',
    this.opportunityPosted = false,
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
        isLoading,
        errorMesssage,
        opportunityPosted,
      ];

  List<String> skills() {
    return AppKeywordConstants.skills;
  }

  copyWith({
    String? tempTitle,
    String? tempDescription,
    LatLng? selectedLocation,
    String? address,
    DateTime? startDateTime,
    DateTime? endDateTime,
    List<String>? tempRequiredSkills,
    bool? isLoading,
    String? errorMesssage,
    bool? opportunityPosted,
  }) {
    return OpportunityState(
      tempTitle: tempTitle ?? this.tempTitle,
      tempDescription: tempDescription ?? this.tempDescription,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      address: address ?? this.address,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      tempRequiredSkills: tempRequiredSkills ?? this.tempRequiredSkills,
      isLoading: isLoading ?? this.isLoading,
      errorMesssage: errorMesssage ?? this.errorMesssage,
      opportunityPosted: opportunityPosted ?? this.opportunityPosted,
    );
  }
}
