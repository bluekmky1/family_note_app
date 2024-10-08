import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/loading_status.dart';
import '../../../routes/routes.dart';
import '../../../theme/typographies.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/outlined_border_text_field_widget.dart';
import 'sign_in_state.dart';
import 'sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                      child: SignInFormWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class SignInFormWidget extends ConsumerWidget {
  const SignInFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        signInViewModelProvider
            .select((SignInState value) => value.signInLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        context.goNamed(Routes.familyRooms.name);
      }
    });

    final SignInViewModel viewModel =
        ref.read(signInViewModelProvider.notifier);

    return Column(
      children: <Widget>[
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Image.asset(Assets.logo),
        ),
        const SizedBox(
          height: 16,
        ),
        OutlinedBorderTextFieldWidget(
          label: '닉네임',
          hintText: '30자 이내로 작성해주세요',
          errorText: '',
          onChanged: (String value) {
            viewModel.onChangeNickname(nickName: value);
          },
        ),
        const SizedBox(
          height: 32,
        ),
        OutlinedBorderTextFieldWidget(
          label: '비밀번호',
          obscureText: true,
          onChanged: (String value) {
            viewModel.onChangePassword(password: value);
          },
          errorText: '',
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
                  onPressed: viewModel.signIn,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: const Color(0xFFFFA800),
                  ),
                  child: Text(
                    '로그인',
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
            context.goNamed(Routes.signUp.name);
          },
          style: TextButton.styleFrom(),
          child: Text(
            '회원가입',
            style: Typo.bMedium18.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
