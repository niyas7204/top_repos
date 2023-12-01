import 'package:json_annotation/json_annotation.dart';
part 'topratedmodel.g.dart';

@JsonSerializable()
class TopRatedRepoModel {
  @JsonKey(name: "total_count")
  int totalCount;
  @JsonKey(name: "incomplete_results")
  bool incompleteResults;
  @JsonKey(name: "items")
  List<Item> items;

  TopRatedRepoModel({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory TopRatedRepoModel.fromJson(Map<String, dynamic> json) =>
      _$TopRatedRepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopRatedRepoModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: "private")
  bool private;
  @JsonKey(name: "owner")
  Owner owner;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "stargazers_count")
  int stargazersCount;

  Item({
    required this.id,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.description,
    required this.stargazersCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Owner {
  @JsonKey(name: "login")
  String user;
  @JsonKey(name: "avatar_url")
  String avatarUrl;

  Owner({
    required this.user,
    required this.avatarUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
