// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topratedmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopRatedRepoModel _$TopRatedRepoModelFromJson(Map<String, dynamic> json) =>
    TopRatedRepoModel(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopRatedRepoModelToJson(TopRatedRepoModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      private: json['private'] as bool,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      stargazersCount: json['stargazers_count'] as int,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'private': instance.private,
      'owner': instance.owner,
      'description': instance.description,
      'stargazers_count': instance.stargazersCount,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      user: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'login': instance.user,
      'avatar_url': instance.avatarUrl,
    };
