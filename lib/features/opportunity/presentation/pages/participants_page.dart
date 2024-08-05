import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/opportunity_attendance_bloc.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            BlocBuilder<OpportunityAttendanceBloc, OpportunityAttendanceState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.isLoaded) {
                  final attendees = state.attendees;
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
                  return const Center(child: Text('Failed to fetch attendees'));
                }
              },
            ),
            BlocBuilder<OpportunityAttendanceBloc, OpportunityAttendanceState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.isLoaded) {
                  final registeredUsers = state.registeredUsers;
                  return ListView.builder(
                    itemCount: registeredUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(registeredUsers[index].name),
                        subtitle: Text(registeredUsers[index].email),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Failed to fetch registered users',
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
