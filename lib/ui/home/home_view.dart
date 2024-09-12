import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme/typographies.dart';
import '../common/consts/assets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          title: Image.asset(
            Assets.logoHorizon,
            height: 56,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      const SliverToBoxAdapter(
                        child: LoadNewQuestionButtonWidget(),
                      ),
                      SliverList.separated(
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 9) {
                            return const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: QuestionItemWidget(),
                            );
                          }
                          return const QuestionItemWidget();
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          height: 10,
                          color: Colors.white,
                        ),
                        itemCount: 10,
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: ListView.separated(
                //     itemBuilder: (BuildContext context, int index) =>
                //         const QuestionItemWidget(),
                //     separatorBuilder: (BuildContext context, int index) =>
                //         const Divider(
                //       height: 10,
                //       color: Colors.white,
                //     ),
                //     itemCount: 10,
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
}

class LoadNewQuestionButtonWidget extends StatelessWidget {
  const LoadNewQuestionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 110,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA800),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '새 질문 받아오기',
                          style: Typo.hBold24.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class QuestionItemWidget extends StatelessWidget {
  const QuestionItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 110,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFFFCE30).withOpacity(0.6),
        ),
        child: const Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text('#24'),
            ),
            Expanded(
              child: Text(
                '내일 하루를 위해 오늘 할 수 있는 가장 좋은 일은 무엇이라고 생각하나요? 글자채우기채우기',
                style: Typo.bMedium16,
              ),
            ),
          ],
        ),
      );
}
