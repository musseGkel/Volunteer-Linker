import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final AuthState authState;
  final Function(CurrentPage, AuthState) onItemTapped;

  const CustomDrawer({
    Key? key,
    required this.authState,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            selected: authState.isCurrentPage(CurrentPage.home),
            leading: Icon(
              Icons.home,
              size: authState.isCurrentPage(CurrentPage.home) ? 30 : 24,
            ),
            title: const Text('Home'),
            onTap: () => onItemTapped(CurrentPage.home, authState),
          ),
          ListTile(
            selected: authState.isCurrentPage(CurrentPage.postOpportunity),
            leading: Icon(
              Icons.post_add,
              size: authState.isCurrentPage(CurrentPage.postOpportunity)
                  ? 30
                  : 24,
            ),
            title: const Text('Post Opportunity'),
            onTap: () => onItemTapped(CurrentPage.postOpportunity, authState),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: authState.isCurrentPage(CurrentPage.profile) ? 30 : 24,
            ),
            title: const Text('Profile'),
            onTap: () => onItemTapped(CurrentPage.profile, authState),
          ),
        ],
      ),
    );
  }
}
