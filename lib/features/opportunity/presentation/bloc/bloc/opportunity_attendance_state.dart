part of 'opportunity_attendance_bloc.dart';

class OpportunityAttendanceState extends Equatable {
  final bool isLoading;
  final PostStatus status;
  final List<Opportunity> opportunities;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDocument;
  final bool isLoaded;
  final List<UserData> attendees;
  final List<UserData> registeredUsers;
  const OpportunityAttendanceState({
    this.isLoading = false,
    this.status = PostStatus.initial,
    this.opportunities = const [],
    this.hasReachedMax = false,
    this.lastDocument,
    this.isLoaded = false,
    this.attendees = const [],
    this.registeredUsers = const [],
  });

  @override
  List<Object?> get props => [
        isLoading,
        status,
        opportunities,
        hasReachedMax,
        lastDocument,
        isLoaded,
        attendees,
        registeredUsers,
      ];

  OpportunityAttendanceState copyWith({
    bool? isLoading,
    PostStatus? status,
    List<Opportunity>? opportunities,
    bool? hasReachedMax,
    DocumentSnapshot? lastDocument,
    bool? isLoaded,
    List<UserData>? attendees,
    List<UserData>? registeredUsers,
  }) {
    return OpportunityAttendanceState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      opportunities: opportunities ?? this.opportunities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoaded: isLoaded ?? this.isLoaded,
      attendees: attendees ?? this.attendees,
      registeredUsers: registeredUsers ?? this.registeredUsers,
    );
  }
}
