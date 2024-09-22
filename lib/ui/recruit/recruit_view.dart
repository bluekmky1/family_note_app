import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../domain/users/model/user_info_model.dart';
import '../../theme/typographies.dart';
import '../common/widgets/outlined_border_text_field_widget.dart';
import '../family_rooms/family_rooms_view_model.dart';
import 'recruit_state.dart';
import 'recruit_view_model.dart';

class RecruitView extends ConsumerStatefulWidget {
  const RecruitView({super.key});

  @override
  ConsumerState<RecruitView> createState() => _RecruitViewState();
}

class _RecruitViewState extends ConsumerState<RecruitView> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RecruitState state = ref.watch(recruitViewModelProvider);
    final RecruitViewModel viewModel =
        ref.read(recruitViewModelProvider.notifier);

    ref.listen(
        recruitViewModelProvider
            .select((RecruitState value) => value.recruitFmailyLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        ref.read(familyRoomsViewModelProvider.notifier).getFamilyGroupList();
        context
          ..pop()
          ..pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          '가족 구성원 모집',
          style: Typo.tSemiBold20.copyWith(fontSize: 32),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 75,
                    left: 0,
                    child: Container(
                      width: 70,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(300),
                          bottomRight: Radius.circular(170),
                        ),
                        color: const Color(0xff0B70FE).withOpacity(0.22),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 175,
                    right: 0,
                    child: Container(
                      width: 70,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(230),
                          bottomLeft: Radius.circular(150),
                        ),
                        color: const Color(0xffFEBA0B).withOpacity(0.22),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: -10,
                    child: Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.elliptical(100, 50),
                          bottomRight: Radius.circular(130),
                        ),
                        color: const Color(0xffFE540B).withOpacity(0.3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            textSelectionTheme: const TextSelectionThemeData(
                              cursorColor: Color(0xFFFFA800),
                            ),
                            searchViewTheme: SearchViewThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              dividerColor: const Color(0xFFCDCDCD),
                            ),
                          ),
                          child: SearchAnchor(
                            isFullScreen: false,
                            viewOnChanged: (String value) {
                              if (_debounce?.isActive ?? false) {
                                _debounce?.cancel();
                              }

                              _debounce =
                                  Timer(const Duration(milliseconds: 250), () {
                                if (value.isNotEmpty) {
                                  viewModel.searchUser(
                                    searchKeyword: value,
                                  );
                                }
                              });
                            },
                            builder: (_, SearchController controller) =>
                                GestureDetector(
                              onTap: () {
                                viewModel.clearSearchResult();
                                controller
                                  ..clear()
                                  ..openView();
                              },
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFCDCDCD),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '가족 구성원의 닉네임을 검색해주세요',
                                      style: Typo.bMedium16.copyWith(
                                        color: const Color(0xFF888888),
                                      ),
                                    ),
                                    const Icon(Icons.search)
                                  ],
                                ),
                              ),
                            ),
                            viewBuilder: (_) => Consumer(
                              builder: (_, WidgetRef ref, __) {
                                final List<UserInfoModel> searchResults =
                                    ref.watch(
                                  recruitViewModelProvider.select(
                                      (RecruitState value) =>
                                          value.searchedFamilyList),
                                );

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          FamilyListItemWidget(
                                    user: searchResults[index],
                                    onPressed: () {
                                      viewModel.selectFamily(
                                        nickName: searchResults[index],
                                      );

                                      context.pop();
                                    },
                                  ),
                                  itemCount: searchResults.length,
                                );
                              },
                            ),
                            suggestionsBuilder: (_, __) => <Widget>[],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '모집된 가족 구성원',
                          style: Typo.tSemiBold20,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFCDCDCD),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              itemBuilder: (_, int index) =>
                                  FamilyListItemWidget(
                                user: state.recruitedFamilyList[index],
                                onPressed: () {
                                  viewModel
                                    ..unselectFamily(
                                      nickName:
                                          state.recruitedFamilyList[index],
                                    )
                                    ..clearSearchResult();
                                },
                              ),
                              separatorBuilder: (_, int index) => const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  height: 8,
                                ),
                              ),
                              itemCount: state.recruitedFamilyList.length,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: TextButton(
                                  onPressed: state.recruitedFamilyList.isEmpty
                                      ? null
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const CompleteRecruitDialogWidget(),
                                          );
                                        },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    disabledBackgroundColor:
                                        const Color(0xFFCDCDCD),
                                    backgroundColor: const Color(0xFFFFA800),
                                  ),
                                  child: Text(
                                    '가족 구성원 모집 완료',
                                    style: Typo.hBold20.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class FamilyListItemWidget extends ConsumerWidget {
  const FamilyListItemWidget({
    required this.user,
    required this.onPressed,
    super.key,
  });
  final UserInfoModel user;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSelected = ref
        .watch(recruitViewModelProvider
            .select((RecruitState value) => value.recruitedFamilyList))
        .contains(user);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 64,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    user.nickname,
                    style: Typo.bMedium18,
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: onPressed,
                    icon: Icon(isSelected
                        ? Icons.remove_circle_outline_outlined
                        : Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteRecruitDialogWidget extends ConsumerWidget {
  const CompleteRecruitDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RecruitState state = ref.watch(recruitViewModelProvider);
    final RecruitViewModel viewModel =
        ref.read(recruitViewModelProvider.notifier);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              const Text(
                '가족 구성원 모집을 완료하시겠습니까?',
                textAlign: TextAlign.center,
                style: Typo.hBold18,
              ),
              const SizedBox(height: 8),
              const Text(
                '모집 완료 후 가족 구성원을 변경할 수 없습니다.',
                textAlign: TextAlign.center,
                style: Typo.bMedium14,
              ),
              const SizedBox(height: 8),
              OutlinedBorderTextFieldWidget(
                onChanged: (String value) {
                  viewModel.onchangeFamilyName(familyName: value);
                },
                errorText: '',
                hintText: '가족 이름을 적어주세요 (필수)',
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                            color: Color(
                              0xFFFFA800,
                            ),
                            width: 2,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          '아니요',
                          style: Typo.tSemiBold16.copyWith(
                            color: const Color(
                              0xFFFFA800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFFA800,
                          ),
                          disabledBackgroundColor: const Color(0xFFCDCDCD),
                        ),
                        onPressed: state.familyName.isEmpty
                            ? null
                            : viewModel.recruitFamily,
                        child: Text(
                          '네',
                          style: Typo.tSemiBold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
