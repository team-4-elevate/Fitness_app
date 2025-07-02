class User {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  int? age;
  int? weight;
  int? height;
  String? activityLevel;
  String? goal;
  String? photo;
  String? id;
  DateTime? createdAt;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.id,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        gender: json['gender'] as String?,
        age: json['age'] as int?,
        weight: json['weight'] as int?,
        height: json['height'] as int?,
        activityLevel: json['activityLevel'] as String?,
        goal: json['goal'] as String?,
        photo: json['photo'] as String?,
        id: json['_id'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'gender': gender,
        'age': age,
        'weight': weight,
        'height': height,
        'activityLevel': activityLevel,
        'goal': goal,
        'photo': photo,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
      };
}
