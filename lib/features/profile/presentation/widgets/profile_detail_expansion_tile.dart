import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/core/enums.dart';
import 'package:volunteer_linker/features/profile/presentation/widgets/keyword_selection.dart';

import '../bloc/profile_detail_bloc/profile_detail_bloc.dart';
import 'availability_widget.dart';

class ProfileDetailExpansionTile extends StatelessWidget {
  final ProfileDetailType profileDetailType;
  final bool editMode;
  const ProfileDetailExpansionTile({
    super.key,
    required this.profileDetailType,
    required this.editMode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDetailBloc, ProfileDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: ExpansionTile(
              title: Text(
                state.title(profileDetailType),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                if (profileDetailType == ProfileDetailType.skills ||
                    profileDetailType == ProfileDetailType.interests)
                  Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: KeywordsSelection(
                      keywords: state.keywords(profileDetailType),
                      title: state.title(profileDetailType),
                      canEdit: editMode,
                      onSave: (value) {},
                    ),
                  ),
                if (profileDetailType == ProfileDetailType.volunteerActivities)
                  Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Charity",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Hours of contribution",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...Map.from(state.volunteerActivities())
                            .entries
                            .map((entry) {
                          final String charity = entry.key;
                          final int hours = entry.value;

                          // return SizedBox();
                          return ListTile(
                            title: Text(
                              "$charity : ",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 50,
                              child: Row(
                                children: [
                                  Text(
                                    hours.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                if (profileDetailType == ProfileDetailType.availability)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AvailabilityWidget(
                      editMode: editMode,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
