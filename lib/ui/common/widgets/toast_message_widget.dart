import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../theme/typographies.dart';

void showToastWidget(
  BuildContext context,
  String text, {
  int milliseconds = 3000,
  int bottom = 95,
}) {
  final FToast fToast = FToast();
  final Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: const Color.fromRGBO(42, 46, 55, 1),
    ),
    child: Text(
      text,
      style: Typo.bRegular13.copyWith(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );

  fToast
    // removeQueuedCustomToasts(): toast 메세지가 있을 경우 제거
    ..removeQueuedCustomToasts()
    ..init(context)
    ..showToast(
      child: toast,
      fadeDuration: const Duration(milliseconds: 250),
      toastDuration: Duration(milliseconds: milliseconds),
      positionedToastBuilder: (BuildContext context, Widget child) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + bottom,
            child: child,
          ),
        ],
      ),
    );
}
