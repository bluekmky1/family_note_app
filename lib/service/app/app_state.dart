import 'package:equatable/equatable.dart';

/// 전역으로 관리하는 상태
class AppState extends Equatable {
  const AppState({
    required this.isSignedIn,
    required this.hasFamily,
  });

  const AppState.init()
      : isSignedIn = false,
        hasFamily = false;

  final bool isSignedIn;
  final bool hasFamily;

  AppState copyWith({
    bool? isSignedIn,
    bool? hasFamily,
  }) =>
      AppState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
        hasFamily: hasFamily ?? this.hasFamily,
      );

  @override
  List<Object?> get props => <Object?>[isSignedIn];
}
