import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/family/model/family_group_model.dart';
import '../../routes/routes.dart';
import '../../theme/typographies.dart';
import 'family_rooms_state.dart';
import 'family_rooms_view_model.dart';

class FamilyRoomsView extends ConsumerStatefulWidget {
  const FamilyRoomsView({super.key});

  @override
  ConsumerState<FamilyRoomsView> createState() => _FamilyRoomsViewState();
}

class _FamilyRoomsViewState extends ConsumerState<FamilyRoomsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(familyRoomsViewModelProvider.notifier).getFamilyGroupList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FamilyRoomsState state = ref.watch(familyRoomsViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 400,
              left: -10,
              child: Container(
                width: 100,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.elliptical(300, 50),
                    bottomRight: Radius.circular(130),
                  ),
                  color: const Color(0xffFE0BE6).withOpacity(0.3),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '어느 채팅방으로 들어가실 건가요?',
                      style: Typo.hBold24,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFFFA800),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFFA800),
                              ),
                            )
                          : ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.familyGroupList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  context.goNamed(
                                    Routes.home.name,
                                    pathParameters: <String, String>{
                                      'familyId': state
                                          .familyGroupList[index].familyId
                                          .toString(),
                                    },
                                  );
                                },
                                child: FamilyGroupListItemWidget(
                                  familyGroupModel:
                                      state.familyGroupList[index],
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                color: Colors.transparent,
                                height: 13,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFFFA800),
                        ),
                        onPressed: () {
                          context.goNamed(Routes.recruit.name);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '새 가족 구성원 모집하기',
                              style: Typo.hBold18.copyWith(color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyGroupListItemWidget extends StatelessWidget {
  const FamilyGroupListItemWidget({
    required this.familyGroupModel,
    super.key,
  });

  final FamilyGroupModel familyGroupModel;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: const Color(0xFFFFCCB6), width: 2)),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    familyGroupModel.familyName,
                    style: Typo.tSemiBold18,
                  ),
                  Text(
                    '${familyGroupModel.familyMemberNameList.length} 명',
                    style: Typo.bRegular14
                        .copyWith(color: const Color(0xff8F8F8F)),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 18,
                      mainAxisSpacing: 7),
                  itemBuilder: (BuildContext context, int index) => Text(
                    familyGroupModel.familyMemberNameList[index],
                    style: Typo.bRegular14,
                  ),
                  itemCount: familyGroupModel.familyMemberNameList.length,
                ),
              )
            ],
          ),
        ),
      );
}
