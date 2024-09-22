import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../domain/family/model/family_question_model.dart';
import '../../routes/routes.dart';
import '../../service/app/app_service.dart';
import '../../theme/typographies.dart';
import '../../util/date_time_formatter.dart';
import '../common/consts/assets.dart';
import '../common/widgets/toast_message_widget.dart';
import 'home_state.dart';
import 'home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  HomeView({
    required String familyId,
    super.key,
  }) : familyId = int.parse(familyId);

  final int familyId;

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const double _cacheExtent = 2000;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier)
        ..getFamilyInfo(familyId: widget.familyId)
        ..initFamilyQuestions(familyId: widget.familyId);
    });
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - _cacheExtent &&
          ref.read(
            homeViewModelProvider.select((HomeState value) => !value.isEndPage),
          )) {
        ref.read(homeViewModelProvider.notifier).getNextFamilyQuestions(
            familyId: widget.familyId,
            loadedPage: ref.read(
              homeViewModelProvider
                  .select((HomeState value) => value.loadedPage),
            ));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

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
      endDrawer: const FamilyInfoDrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: <Widget>[
              if (state.isInitLoading)
                const Expanded(
                    child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFA800),
                  ),
                ))
              else
                Expanded(
                  child: RefreshIndicator(
                    color: const Color(0xFFFFA800),
                    onRefresh: () async {
                      await viewModel.initFamilyQuestions(
                          familyId: widget.familyId);
                    },
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      cacheExtent: _cacheExtent,
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: LoadNewQuestionButtonWidget(
                            familyId: widget.familyId,
                          ),
                        ),
                        SliverList.separated(
                          itemCount: state.questionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == state.questionList.length - 1) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: QuestionItemWidget(
                                  familyId: widget.familyId,
                                  questionNumber: state.totalCount - index,
                                  questionModel: state.questionList[index],
                                ),
                              );
                            }
                            return QuestionItemWidget(
                              familyId: widget.familyId,
                              questionNumber: state.totalCount - index,
                              questionModel: state.questionList[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 10,
                            color: Colors.white,
                          ),
                        ),
                        if (state.isLoading)
                          const SliverToBoxAdapter(
                              child: SizedBox(
                            height: 40,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFFA800),
                              ),
                            ),
                          )),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyInfoDrawerWidget extends ConsumerWidget {
  const FamilyInfoDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppService appService = ref.read(appServiceProvider.notifier);
    final HomeState state = ref.watch(homeViewModelProvider);
    return Drawer(
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
                  state.familyName,
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
                        state.familyNicknameList.length,
                        (int index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            state.familyNicknameList[index],
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    constraints: const BoxConstraints(maxWidth: 80),
                    child: Image.asset(Assets.face),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      appService.signOut();
                      context.goNamed(Routes.signIn.name);
                    },
                    child: Text(
                      '로그아웃',
                      style: Typo.hBold14.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadNewQuestionButtonWidget extends ConsumerWidget {
  const LoadNewQuestionButtonWidget({
    required this.familyId,
    super.key,
  });
  final int familyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    ref.listen(
        homeViewModelProvider
            .select((HomeState value) => value.createNewQuestionLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        viewModel.initFamilyQuestions(familyId: familyId);
      } else if (next == LoadingStatus.error) {
        if (ref.read(homeViewModelProvider).createNewQuestionError ==
            '이전 가족 질문에 모두 답하지 않아 새로운 질문을 생성할 수 없습니다.') {
          showToastWidget(
              context, '이전 가족 질문에 가족들이 모두 답하지 않아서\n' '새로운 질문을 생성할 수 없습니다.',
              bottom: 100);
        }
      }
    });
    return Padding(
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
                onPressed: () {
                  viewModel.createQuestion(
                    familyId: familyId,
                  );
                },
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
}

class QuestionItemWidget extends StatelessWidget {
  const QuestionItemWidget({
    required this.familyId,
    required this.questionNumber,
    required this.questionModel,
    super.key,
  });
  final int familyId;
  final int questionNumber;
  final FamilyQuestionModel questionModel;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          context
              .goNamed(Routes.question.name, pathParameters: <String, String>{
            'familyId': familyId.toString(),
            'questionId': questionModel.familyQusetionId.toString(),
            'question': questionModel.question,
            'createdAt': DateTimeFormatter.getDateUsingDot(
                dateTime: questionModel.createdAt),
          });
        },
        child: Container(
          height: 110,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFFFCE30).withOpacity(0.6),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text('$questionNumber'),
              ),
              Expanded(
                child: Text(
                  questionModel.question,
                  style: Typo.tSemiBold18,
                ),
              ),
            ],
          ),
        ),
      );
}
