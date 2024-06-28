import 'package:flutter/material.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import '../widgets/profile_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: AppColors.backgroundColor),
        actions: const [
          Icon(
            Icons.settings,
            color: AppColors.backgroundColor,
          ),
          SizedBox(width: 16),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            height: 350,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.softGray, AppColors.secondaryTextColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      "https://via.placeholder.com/150"), // Replace with actual image URL
                ),
                SizedBox(height: 10),
                Text(
                  "James Martin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  true ? "Volunteer" : "Organization",
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "12 ",
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Total Contributions",
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                // Column(
                //   children: [
                //     Text(
                //       "1000",
                //       style: TextStyle(
                //         color: AppColors.primaryTextColor,
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     Text(
                //       "Followers",
                //       style: TextStyle(
                //         color: AppColors.primaryTextColor,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(width: 40),
                // Column(
                //   children: [
                //     Text(
                //       "1200",
                //       style: TextStyle(
                //         color: AppColors.primaryTextColor,
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     Text(
                //       "Following",
                //       style: TextStyle(
                //         color: AppColors.primaryTextColor,
                //       ),
                //     ),
                //   ],
                // ),
                //   ],
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfileItem(
                  title: 'Name',
                  subtitle:
                      'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Username',
                  subtitle: '',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Email',
                  subtitle: '',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Bio',
                  subtitle: '',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Interests',
                  subtitle: '',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Skills',
                  subtitle: '',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Availability',
                  subtitle: '',
                  onEditPressed: () {},
                ),
                ProfileItem(
                  title: 'Volunteer Activities',
                  subtitle: '',
                  onEditPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
