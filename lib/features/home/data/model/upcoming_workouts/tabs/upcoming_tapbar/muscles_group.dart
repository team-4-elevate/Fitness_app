class MusclesGroup {
  String? id;
  String? name;

  MusclesGroup({this.id, this.name});

  factory MusclesGroup.fromJson(Map<String, dynamic> json) =>
      MusclesGroup(id: json['_id'] as String?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};
}
