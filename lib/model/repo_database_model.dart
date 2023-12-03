class DatabaseModelList {
  List<DatabaseModel> repos;

  DatabaseModelList({required this.repos});

  factory DatabaseModelList.fromList(List<Map<String, dynamic>> list) {
    List<DatabaseModel> repos =
        list.map((map) => DatabaseModel.fromMap(map)).toList();
    return DatabaseModelList(repos: repos);
  }
}

class DatabaseModel {
  int id;

  String name;
  String fullName;
  String? description;
  String user;
  String avatarurl;
  int stargazersCount;
  DatabaseModel(
      {required this.id,
      required this.name,
      required this.fullName,
      required this.user,
      required this.avatarurl,
      required this.description,
      required this.stargazersCount});
  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'star_count': stargazersCount,
      'user': user,
      'avatar_url': avatarurl,
    };
  }

  factory DatabaseModel.fromMap(Map<String, dynamic> map) {
    return DatabaseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      fullName: map['full_name'] as String,
      description: map['description'] as String?,
      stargazersCount: map['star_count'] as int,
      user: map['user'] as String,
      avatarurl: map['avatar_url'] as String,
    );
  }
}
