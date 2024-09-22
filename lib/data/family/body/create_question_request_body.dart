import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/create_question_request_body.g.dart';

@JsonSerializable()
class PostAnswerRequestBody extends Equatable {
  final String content;

  const PostAnswerRequestBody({
    required this.content,
  });

  Map<String, dynamic> toJson() => _$PostAnswerRequestBodyToJson(this);

  @override
  List<Object?> get props => <Object?>[content];
}
