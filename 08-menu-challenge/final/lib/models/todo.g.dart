// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as int,
      finished: json['finished'] as bool? ?? false,
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'finished': instance.finished,
      'notes': instance.notes,
    };
