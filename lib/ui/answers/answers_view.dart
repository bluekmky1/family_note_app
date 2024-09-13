import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../theme/typographies.dart';

class AnswersView extends StatefulWidget {
  const AnswersView({super.key});

  @override
  State<AnswersView> createState() => _AnswersViewState();
}

class _AnswersViewState extends State<AnswersView> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.isScrollingNotifier.value) {
        // 여기에 setState를 사용하지 않음으로써 전체 빌드를 피함
        // 단, 특정 위젯만 Repaint될 수 있도록 RepaintBoundary를 활용
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFE283),
        body: SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              const SliverAppBar(
                backgroundColor: Color(0xFFFFE283),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('24.09.13'),
                          SizedBox(width: 8),
                          Text('#12')
                        ],
                      ),
                      Text(
                        '고양이 VS 강아지 어떤 동물을 더 좋아하나요?',
                        style: Typo.hBold24,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.separated(
                itemCount: 3,
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                itemBuilder: (BuildContext context, int index) => AnswerWidget(
                  scrollController: scrollController,
                  index: index,
                ),
              ),
            ],
          ),
        ),
      );
}

class AnswerWidget extends StatefulWidget {
  const AnswerWidget({
    required this.scrollController,
    required this.index,
    super.key,
  });

  final int index;
  final ScrollController scrollController;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) => Padding(
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
                    'bluekmky',
                    style: Typo.bRegular16
                        .copyWith(color: const Color.fromARGB(255, 69, 69, 69)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Builder(
                      builder: (BuildContext context) => switch (widget.index) {
                            0 => Expanded(
                                child: GestureDetector(
                                  child: const ColoredBox(
                                    color: Colors.transparent,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          const AnsweringDialogWidget(),
                                    );
                                  },
                                ),
                              ),
                            2 => Expanded(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 12,
                                    sigmaY: 12,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                      '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                      '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                      '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                      '나는 고양',
                                      style: Typo.tSemiBold18,
                                    ),
                                  ),
                                ),
                              ),
                            _ => const Text(
                                '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                '나는 고양이가 더 좋아 그 이유는 블라블라 '
                                '나는 고양',
                                style: Typo.tSemiBold18,
                              ),
                          }),
                ],
              ),
            ),
          ],
        ),
      );
}

class AnsweringDialogWidget extends StatelessWidget {
  const AnsweringDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Dialog(
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
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '답변하기',
                            style:
                                Typo.tSemiBold16.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ))
              ],
            )),
      );
}
