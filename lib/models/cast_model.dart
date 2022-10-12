class CastModel {
  int? id;
  String? character;
  String? name;
  String? profile_path;

  CastModel({
    this.id,
    this.character,
    this.name,
    this.profile_path,
  });

  factory CastModel.fromMap(Map<String, dynamic> map) {
    return CastModel(
      id: map['id'],
      character: map['character'],
      name: map['name'],
      profile_path: map['profile_path'] ?? '',
    );
  }

  
}