import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/enums.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../home_page/presentation/widgets/custom_drawer.dart';
import '../bloc/bloc/opportunity_attendance_bloc.dart';

class ParticipantsPage extends StatefulWidget {
  final String opportunityId;

  const ParticipantsPage({
    Key? key,
    required this.opportunityId,
  }) : super(key: key);

  @override
  State<ParticipantsPage> createState() => _ParticipantsPageState();
}

class _ParticipantsPageState extends State<ParticipantsPage> {
  @override
  void initState() {
    context.read<OpportunityAttendanceBloc>().add(
          FetchAttendantsAndRegisteredUsers(
            state: context.read<OpportunityAttendanceBloc>().state,
            opportunityId: widget.opportunityId,
          ),
        );

    super.initState();
  }

  void _onItemTapped(
    CurrentPage currentPage,
    AuthState authState,
  ) {
    BlocProvider.of<AuthBloc>(
      context,
    ).add(
      ChangePageEvent(
        changePage: currentPage,
        state: authState,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpportunityAttendanceBloc, OpportunityAttendanceState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                drawer: CustomDrawer(
                  authState: authState,
                  onItemTapped: _onItemTapped,
                ),
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Participants'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        text: 'Attendees',
                      ),
                      Tab(
                        text: 'Registered Users',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Builder(builder: (context) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.isLoaded) {
                        final attendees = state.attendees;
                        if (attendees.isEmpty) {
                          return const Center(child: Text('No attendees yet'));
                        }

                        return ListView.builder(
                          itemCount: attendees.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(attendees[index].name),
                              subtitle: Text(attendees[index].email),
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: Text('Failed to fetch attendees'));
                      }
                    }),
                    Builder(builder: (context) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.isLoaded) {
                        final registeredUsers = state.registeredUsers;

                        if (registeredUsers.isEmpty) {
                          return const Center(
                              child: Text('No registered users yet'));
                        }
                        return ListView.builder(
                          itemCount: registeredUsers.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(registeredUsers[index].name),
                                subtitle: Text(registeredUsers[index].email),
                                trailing: SizedBox(
                                  width: 80,
                                  height: 38,
                                  child: CommonButton(
                                    backgroundColor: AppColors.primaryColor,
                                    borderColor: AppColors.primaryBorderColor,
                                    text: 'Approve',
                                    textColor: AppColors.primaryTextColor,
                                    onTap: () {
                                      BlocProvider.of<
                                          OpportunityAttendanceBloc>(
                                        context,
                                      ).add(
                                        ApproveAttendance(
                                          opportunityId: widget.opportunityId,
                                          userId: registeredUsers[index].id,
                                        ),
                                      );
                                      BlocProvider.of<
                                                  OpportunityAttendanceBloc>(
                                              context)
                                          .add(
                                        FetchAttendantsAndRegisteredUsers(
                                          opportunityId: widget.opportunityId,
                                          state: state,
                                        ),
                                      );
                                    },
                                    contentColor: AppColors.primaryTextColor,
                                    fontSize: 12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ));
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'Failed to fetch registered users',
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
