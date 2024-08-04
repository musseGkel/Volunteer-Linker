import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/core/enums.dart';
import 'package:volunteer_linker/core/widgets/common_textfield.dart';
import 'package:volunteer_linker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:volunteer_linker/features/opportunity/presentation/bloc/opportunity_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../home_page/presentation/bloc/image_picker/image_picker_bloc.dart';
import '../../../profile/presentation/bloc/key_selection_bloc/keyword_selection_bloc.dart';
import '../../../profile/presentation/widgets/keyword_selection.dart';
import '../widgets/date_time_selection.dart';

class PostOpportunity extends StatelessWidget {
  const PostOpportunity({super.key});

  void _showImageSourceActionSheet(
    BuildContext context,
    ImagePickerState imagePickerState,
  ) {
    final imagePickerBloc = BlocProvider.of<ImagePickerBloc>(context);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: imagePickerBloc,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick from gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    imagePickerBloc.add(
                      PickImageFromGalleryEvent(state: imagePickerState),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () {
                    Navigator.of(context).pop();
                    imagePickerBloc.add(
                      TakePhotoEvent(state: imagePickerState),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeywordSelectionBloc>(
          create: (context) {
            final skills =
                context.read<OpportunityBloc>().state.tempRequiredSkills ??
                    <String>[];
            return KeywordSelectionBloc(skills);
          },
        ),
        BlocProvider<ImagePickerBloc>(
          create: (context) => ImagePickerBloc(),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocConsumer<OpportunityBloc, OpportunityState>(
            listener: (context, state) {
              if (state.opportunityPosted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Opportunity posted successfully!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                BlocProvider.of<AuthBloc>(
                  context,
                ).add(
                  ChangePageEvent(
                    state: authState,
                    changePage: CurrentPage.home,
                  ),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (imagePickerContext, imagePickerState) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Post an Opportunity',
                      ),
                      centerTitle: true,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonTextField(
                              label: "Title",
                              onChanged: (value) {
                                BlocProvider.of<OpportunityBloc>(context).add(
                                  UpdateTempTitle(
                                    state: state,
                                    title: value,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonTextField(
                              label: "Description",
                              onChanged: (value) {
                                BlocProvider.of<OpportunityBloc>(context).add(
                                  UpdateTempDescription(
                                    state: state,
                                    description: value,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: KeywordsSelection(
                              keywords: state.skills(),
                              title: "Required Skills",
                              canEdit: true,
                              onSave: (value) {
                                BlocProvider.of<OpportunityBloc>(context).add(
                                  UpdateTempRequiredSkills(
                                    state: state,
                                    requiredSkills: value,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 60,
                              right: 60,
                              bottom: 6,
                              top: 6,
                            ),
                            child: CommonButton(
                              borderRadius: BorderRadius.circular(8),
                              fontSize: 14,
                              backgroundColor: AppColors.primaryTextColor,
                              borderColor: AppColors.primaryColor,
                              text: "Select a Location",
                              textColor: AppColors.secondaryTextColor,
                              onTap: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  ChangePageEvent(
                                    changePage: CurrentPage.selectLocation,
                                    state: authState,
                                  ),
                                );
                              },
                              contentColor: AppColors.primaryTextColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: DateTimeSelection(
                              startDateTime: state.startDateTime,
                              endDateTime: state.endDateTime,
                              onDateTimeChanged: (startDateTime, endDateTime) {
                                BlocProvider.of<OpportunityBloc>(context).add(
                                  UpdateTempDateTime(
                                    state: state,
                                    startDateTime: startDateTime,
                                    endDateTime: endDateTime,
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 100, // Adjust width as needed
                            height: 200, // Adjust height as needed
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 2), // Border for empty state
                              image: imagePickerState.image != null
                                  ? DecorationImage(
                                      image: FileImage(
                                          File(imagePickerState.image!.path)),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: imagePickerState.image == null
                                ? Center(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                        size: 40, // Adjust size as needed
                                      ),
                                      onPressed: () {
                                        _showImageSourceActionSheet(
                                          imagePickerContext,
                                          imagePickerState,
                                        );
                                      },
                                    ),
                                  )
                                : null,
                          ),
                          if (state.errorMesssage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 60,
                                right: 60,
                                bottom: 6,
                                top: 6,
                              ),
                              child: Text(
                                state.errorMesssage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 60,
                              right: 60,
                              bottom: 6,
                              top: 6,
                            ),
                            child: CommonButton(
                              borderRadius: BorderRadius.circular(8),
                              fontSize: 14,
                              backgroundColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryBorderColor,
                              text: "Post Opportunity",
                              textColor: AppColors.primaryTextColor,
                              isLoading: state.isLoading,
                              onTap: () {
                                BlocProvider.of<OpportunityBloc>(context).add(
                                  PostOpportunityEvent(
                                    state: state,
                                    organizationId: context
                                            .read<AuthBloc>()
                                            .state
                                            .user
                                            ?.uid ??
                                        "",
                                    authState: authState,
                                    image: imagePickerState.image,
                                  ),
                                );
                              },
                              contentColor: AppColors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
