import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme/typographies.dart';
import '../common/consts/assets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Image.asset(
          Assets.logoHorizon,
          height: 56,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.people_alt_outlined),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0XFFFF5372),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 200),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'bluekmky\n의 가족',
                    style: Typo.hBold24.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...List<Widget>.generate(
                          4,
                          (int index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'bluekmky',
                              style: Typo.hBold16.copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: Image.asset(Assets.face),
                ),
              ),
            ],
          ),
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
