import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../service/app/app_service.dart';
import '../../service/app/app_state.dart';
import '../../theme/typographies.dart';

class RecruitView extends ConsumerWidget {
  const RecruitView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appServiceProvider.select((AppState value) => value.hasFamily),
        (bool? previous, bool next) {
      print(next);
      if (next) {
        context.goNamed(Routes.home.name);
      }
    });

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            '가족 구성원 모집',
            style: Typo.tSemiBold20.copyWith(fontSize: 32),
          ),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          cursorColor: const Color(0xFFFFA800),
                          decoration: InputDecoration(
                            hintText: '가족 구성원의 닉네임을 검색해주세요',
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(left: 16, right: 32),
                              child: Icon(Icons.search),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFCDCDCD),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Color(0xFFCDCDCD),
                              ),
                            ),
                          ),
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
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 64,
                                  child: Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                        title: const Text('bluekmky'),
                                        trailing: const Icon(
                                            Icons.remove_circle_outline),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  height: 8,
                                ),
                              ),
                              itemCount: 10,
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
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const CompleteRecruitDialogWidget(),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
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

class CompleteRecruitDialogWidget extends ConsumerWidget {
  const CompleteRecruitDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppService appService = ref.read(appServiceProvider.notifier);
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
                        ),
                        onPressed: () {
                          appService.completeRecruit();
                          context.pop();
                        },
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
