import 'package:flutter/material.dart';

import '../widgets/opportunity_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ListView(
        children: [
          OpportunityCard(
            organizationName: 'Italian Red Cross',
            timeAgo: DateTime(
              2024,
              1,
              10,
            ),
            address: "via Roma 1, Milano",
            imageUrl:
                'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            description:
                'lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
            organizationLogoUrl:
                'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            participants: 21,
            onApply: () {
              print('Apply button pressed');
            },
          ),
        ],
      ),
    );
  }
}
