part of 'opportunity_attendance_bloc.dart';

class OpportunityAttendanceState extends Equatable {
  final bool isLoading;
  const OpportunityAttendanceState({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [isLoading];

  copyWith({
    bool? isLoading,
  }) {
    return OpportunityAttendanceState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
