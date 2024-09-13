import 'package:flutter/material.dart';

import '../../theme/typographies.dart';

class AnswersView extends StatelessWidget {
  const AnswersView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFCE30).withOpacity(0.6),
        ),
        body: ColoredBox(
          color: const Color(0xFFFFCE30).withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '질문',
                  style: Typo.hBold22,
                ),
                const Text(
                  '고양이 VS 강아지 어떤 동물을 더 좋아하나요?',
                  style: Typo.tSemiBold18,
                ),
                const Row(
                  children: <Widget>[
                    Text('24.09.13'),
                    SizedBox(width: 16),
                    Text('#12')
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  '답변',
                  style: Typo.hBold22,
                ),
                const Divider(
                  color: Colors.black,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 150,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'bluekmky',
                        style: Typo.bRegular16,
                      ),
                      Text(
                        '나는 고양이가 더 좋아 그 이유는 블라블라',
                        style: Typo.tSemiBold18,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      );
}
