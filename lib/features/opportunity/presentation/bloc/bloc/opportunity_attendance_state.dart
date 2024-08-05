part of 'opportunity_attendance_bloc.dart';

class OpportunityAttendanceState extends Equatable {
  final bool isLoading;
  final PostStatus status;
  final List<Opportunity> opportunities;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDocument;

  const OpportunityAttendanceState({
    this.isLoading = false,
    this.status = PostStatus.initial,
    this.opportunities = const [],
    this.hasReachedMax = false,
    this.lastDocument,
  });

  @override
  List<Object?> get props => [
        isLoading,
        status,
        opportunities,
        hasReachedMax,
        lastDocument,
      ];

  OpportunityAttendanceState copyWith({
    bool? isLoading,
    PostStatus? status,
    List<Opportunity>? opportunities,
    bool? hasReachedMax,
    DocumentSnapshot? lastDocument,
  }) {
    return OpportunityAttendanceState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      opportunities: opportunities ?? this.opportunities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}
