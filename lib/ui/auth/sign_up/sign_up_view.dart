import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/loading_status.dart';
import '../../../routes/routes.dart';
import '../../../theme/typographies.dart';
import '../../common/widgets/outlined_border_text_field_widget.dart';
import 'sign_up_state.dart';
import 'sign_up_view_model.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        signUpViewModelProvider
            .select((SignUpState value) => value.signUpLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        context.goNamed(Routes.signIn.name);
      }
    });

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Text(
          '회원가입',
          style: Typo.tSemiBold20.copyWith(fontSize: 32),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: SignUpFormWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpFormWidget extends ConsumerWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpState state = ref.watch(signUpViewModelProvider);
    final SignUpViewModel viewModel =
        ref.watch(signUpViewModelProvider.notifier);
    return Column(
      children: <Widget>[
        OutlinedBorderTextFieldWidget(
          label: '닉네임',
          hintText: '30자 이내로 작성해주세요',
          onChanged: (String value) {
            viewModel.onChangeNickname(nickName: value);
          },
          errorText: state.nickNameValueError,
        ),
        const SizedBox(
          height: 32,
        ),
        OutlinedBorderTextFieldWidget(
          label: '비밀번호',
          hintText: '최소 8자리 이상, 영문자와 숫자를 포함해야 합니다',
          obscureText: true,
          onChanged: (String value) {
            viewModel.onChangePassword(password: value);
          },
          errorText: state.passwordValueError,
        ),
        const SizedBox(
          height: 32,
        ),
        OutlinedBorderTextFieldWidget(
          label: '비밀번호 재확인',
          hintText: '비밀번호를 한 번 더 입력해주세요',
          obscureText: true,
          onChanged: (String value) {
            viewModel.onChangeRepeatPassword(repeatPassword: value);
          },
          errorText: state.repeatPasswordValueError,
        ),
        const SizedBox(
          height: 72,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 56,
                child: TextButton(
                  onPressed: viewModel.signUp,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: const Color(0xFFFFA800),
                  ),
                  child: Text(
                    '회원가입',
                    style: Typo.hBold20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            context.goNamed(Routes.signIn.name);
          },
          style: TextButton.styleFrom(),
          child: Text(
            '로그인 하기',
            style: Typo.bMedium18.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
