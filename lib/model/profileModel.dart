class ProfileModel {
  String userId;
  String userName;
  String userMobile;
  String userMailid;
  String userDOB;
  String userDOA;
  String userDOJ;
  String userHQ;
  String userDvsn;
  String userSection;
  String userDesignation;

  ProfileModel(
      {this.userId,
      this.userName,
      this.userMobile,
      this.userMailid,
      this.userDOB,
      this.userDOA,
      this.userDOJ,
      this.userHQ,
      this.userDvsn,
      this.userSection,
      this.userDesignation});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['userId'],
      userName: json['userName'],
      userMobile: json['userMobile'],
      userMailid: json['userMailid'],
      userDOB: json['userDOB'],
      userDOA: json['userDOA'],
      userDOJ: json['userDOJ'],
      userHQ: json['userHQ'],
      userDvsn: json['userDvsn'],
      userSection: json['userSection'],
      userDesignation: json['userDesignation'],
    );
  }
}
