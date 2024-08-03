import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';

import '../bloc/home_page_bloc.dart';

class OpportunityCard extends StatelessWidget {
  final String organizationName;
  final DateTime createdAt;
  final String organizationLogoUrl;
  final String imageUrl;
  final String description;
  final int participants;
  final VoidCallback onApply;
  final String address;

  const OpportunityCard({
    super.key,
    required this.organizationName,
    required this.createdAt,
    required this.imageUrl,
    required this.description,
    required this.participants,
    required this.onApply,
    required this.organizationLogoUrl,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(organizationLogoUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organizationName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          state.getTimeAgo(createdAt),
                          style: const TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_vert),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.secondaryTextColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      address.length > 30
                          ? '${address.substring(0, 35)}...'
                          : address,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.man,
                          color: AppColors.secondaryTextColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$participants Participants',
                          style: const TextStyle(
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'APPLY',
                        style: TextStyle(
                          color: AppColors.primaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
