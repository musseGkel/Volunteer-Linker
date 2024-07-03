part of 'profile_detail_bloc.dart';

class ProfileDetailState extends Equatable {
  const ProfileDetailState();

  String title(ProfileDetailType type) {
    if (ProfileDetailType.name == type) {
      return "Name";
    } else if (ProfileDetailType.email == type) {
      return "Email";
    } else if (ProfileDetailType.username == type) {
      return "Username";
    } else if (ProfileDetailType.bio == type) {
      return "Bio";
    } else if (ProfileDetailType.interests == type) {
      return "Interests";
    } else if (ProfileDetailType.skills == type) {
      return "Skills";
    } else if (ProfileDetailType.availability == type) {
      return "Availability";
    } else if (ProfileDetailType.volunteerActivities == type) {
      return "Volunteer Activities";
    }
    return "";
  }

  List<String> keywords(ProfileDetailType type) {
    if (ProfileDetailType.interests == type) {
      return AppKeywordConstants.interests;
    } else if (ProfileDetailType.skills == type) {
      return AppKeywordConstants.skills;
    }
    return [];
  }

  Map<String, int> volunteerActivities() {
    return {
      "Red Cross": 4,
      "Habitat for Humanity": 8,
      "UNICEF": 12,
      "World Food Programme": 16,
      "Doctors Without Borders": 20,
      "Save the Children": 24,
      "Greenpeace": 28,
    };
  }

  @override
  List<Object> get props => [];
}
