import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  String id;
  String title;
  String description;
  bool isCompleted;

  TodoModel({
    required this.description,
    required this.id,
    required this.isCompleted,
    required this.title,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return _$TodoModelFromJson(json);
  }
}
