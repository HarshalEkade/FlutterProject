class EditProfileModel{
 String ProfileId;
  String firstName;
  String lastName;
  String location;
  String mobileNumber;
  String profilePic;

  EditProfileModel({
    required this.ProfileId,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.mobileNumber,
    required this.profilePic
  }

  );

  Map<dynamic,dynamic> toJson() => <dynamic,dynamic>{
    'firstName':firstName,
    'lastName':lastName,
    'location':location,
    'mobileNumber':mobileNumber,
    'profilePic':profilePic
  };
}