import 'package:equatable/equatable.dart';

import '../../../data/family/entity/family_questions_entity.dart';

class PageableModel extends Equatable {
  const PageableModel({
    required this.page,
    required this.size,
    required this.totalPages,
    required this.totlaElements,
    required this.isEnd,
  });
  final int page;
  final int size;
  final int totalPages;
  final int totlaElements;
  final bool isEnd;

  factory PageableModel.fromEntity({
    required PageableEntity entity,
  }) =>
      PageableModel(
        page: entity.page,
        size: entity.size,
        totalPages: entity.totalPages,
        totlaElements: entity.totalElements,
        isEnd: entity.isEnd,
      );

  @override
  List<Object?> get props => <Object?>[
        page,
        size,
        totalPages,
        totlaElements,
        isEnd,
      ];
}
