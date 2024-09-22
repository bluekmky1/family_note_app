import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../domain/family/model/family_answer_model.dart';
import '../../theme/typographies.dart';
import 'question_state.dart';
import 'question_view_model.dart';

class QuestionView extends ConsumerStatefulWidget {
  QuestionView({
    required this.question,
    required String questionId,
    required String familyId,
    required this.createdAt,
    super.key,
  })  : questionId = int.parse(questionId),
        familyId = int.parse(familyId);

  final String question;
  final int questionId;
  final int familyId;
  final String createdAt;

  @override
  ConsumerState<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(questionViewModelProvider.notifier)
          ..getFamilyAnswerList(familyQuestionId: widget.questionId)
          ..getFamilyInfo(familyId: widget.familyId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final QuestionState state = ref.watch(questionViewModelProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFFFE283),
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            const SliverAppBar(
              backgroundColor: Color(0xFFFFE283),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(widget.createdAt),
                        // const SizedBox(width: 8),
                        // const Text('#12')
                      ],
                    ),
                    Text(
                      widget.question,
                      style: Typo.hBold24,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFA800),
                  ),
                ),
              )
            else
              SliverList.separated(
                itemCount: state.familyNicknameList.length,
                itemBuilder: (BuildContext context, int index) => AnswerWidget(
                  scrollController: scrollController,
                  familyQuestionId: widget.questionId,
                  nickname: state.familyNicknameList[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AnswerWidget extends ConsumerStatefulWidget {
  const AnswerWidget({
    required this.scrollController,
    required this.nickname,
    required this.familyQuestionId,
    super.key,
  });

  final String nickname;
  final int familyQuestionId;
  final ScrollController scrollController;

  @override
  ConsumerState<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends ConsumerState<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    final QuestionState state = ref.watch(questionViewModelProvider);

    final FamilyAnswerModel answerModel = state.familyAnswerList.singleWhere(
        (FamilyAnswerModel element) => widget.nickname == element.nickname,
        orElse: () => FamilyAnswerModel(
              answer: '',
              nickname: widget.nickname,
            ));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(
              minHeight: 160,
              maxHeight: 160,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.nickname,
                  style: Typo.bRegular16
                      .copyWith(color: const Color.fromARGB(255, 69, 69, 69)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Builder(builder: (BuildContext context) {
                  // 내가 답변을 작성한 경우
                  if (state.isAnswered) {
                    // 내 답변
                    if (state.myName == answerModel.nickname) {
                      return Text(
                        answerModel.answer,
                        style: Typo.tSemiBold18,
                      );
                    }
                    // 가족 답변
                    else {
                      // 가족이 답변하지 않은 경우
                      if (answerModel.answer == '') {
                        return const Text(
                          '가족이 아직 답변을 작성하지 않았어요...',
                          style: Typo.tSemiBold18,
                        );
                      }
                      // 가족이 답변한 경우
                      else {
                        return Text(
                          answerModel.answer,
                          style: Typo.tSemiBold18,
                        );
                      }
                    }
                  }
                  // 내가 답변을 작성하지 않은 경우
                  else {
                    // 내 답변
                    if (state.myName == answerModel.nickname) {
                      return Expanded(
                        child: GestureDetector(
                          child: const ColoredBox(
                            color: Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '가족들의 답변이 궁금하다면?\n'
                                  '이곳을 눌러 답변을 작성해 주세요',
                                  style: Typo.tSemiBold18,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AnsweringDialogWidget(
                                familyQuestionId: widget.familyQuestionId,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    // 가족 답변
                    else {
                      return Expanded(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 12,
                            sigmaY: 12,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              '나는 고양이가 좋아 나는 고양이가 좋아 '
                              '나는 고양이가 좋아 나는 고양이가 좋아 '
                              '나는 고양이가 좋아 나는 고양이가 좋아 '
                              '나는 고양이가 좋아 나는 고양이가 좋아 '
                              '나는 고양이가 좋아',
                              style: Typo.tSemiBold18,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnsweringDialogWidget extends ConsumerWidget {
  const AnsweringDialogWidget({
    required this.familyQuestionId,
    super.key,
  });

  final int familyQuestionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        questionViewModelProvider
            .select((QuestionState value) => value.postAnswerLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        ref
            .read(questionViewModelProvider.notifier)
            .getFamilyAnswerList(familyQuestionId: familyQuestionId)
            .then((_) => context.pop());
      }
    });

    final QuestionState state = ref.watch(questionViewModelProvider);
    final QuestionViewModel viewModel =
        ref.read(questionViewModelProvider.notifier);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '답변',
                    style: Typo.hBold22,
                  ),
                  CloseButton(),
                ],
              ),
              const SizedBox(height: 1),
              TextField(
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                onChanged: (String value) {
                  viewModel.onchangeAnswerValue(answer: value);
                },
                maxLength: 100,
                cursorColor: const Color(0xFFFFA800),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: '이곳에 답변을 작성해주세요',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                minLines: 5,
                maxLines: 5,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color(0xFFFFA800),
                    disabledBackgroundColor: const Color(0xFFCDCDCD),
                  ),
                  onPressed: state.answerValue.isEmpty
                      ? null
                      : () {
                          viewModel.postAnswer(
                              familyQuestionId: familyQuestionId);
                        },
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '답변하기',
                          style: Typo.tSemiBold16.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
