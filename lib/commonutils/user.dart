class User {
  final String status;
  final String userId;
  final String username;
  final String userType;
  final String userDesgn;
  final String userHQ;
  final String userDvsn;
  final String userMob;
  User({
    this.status,
    this.userId,
    this.username,
    this.userType,
    this.userDesgn,
    this.userHQ,
    this.userDvsn,
    this.userMob,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      status: json['status'],
      username: json['username'],
      userType: json['userType'],
      userDesgn: json['userDesgn'],
      userHQ: json['userHQ'],
      userDvsn: json['userDvsn'],
      userMob: json['userMob'],
    );
  }
}
