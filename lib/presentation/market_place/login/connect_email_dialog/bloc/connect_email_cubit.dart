import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'connect_email_state.dart';

enum ConnectEmailStatus { CONNECTED, NOT_CONNECTED }

extension ParseConnectEmailEnum on ConnectEmailStatus {
  String toContent() {
    switch (this) {
      case ConnectEmailStatus.CONNECTED:
        UserProfileModel userProfile =
            userProfileFromJson(PrefsService.getUserProfile());
        final email = userProfile.email ?? '';
        return '${S.current.login_to_your_email} $email';
      case ConnectEmailStatus.NOT_CONNECTED:
        return S.current.associate_email;
      default:
        return '';
    }
  }
}

class ConnectEmailCubit extends BaseCubit<ConnectEmailState> {
  ConnectEmailCubit() : super(ConnectEmailInitial());

  BehaviorSubject<ConnectEmailStatus> connectEmailStatusSubject =
      BehaviorSubject();

  Stream<ConnectEmailStatus> get connectEmailStatusStream =>
      connectEmailStatusSubject.stream;

  Future<void> checkLoginStatus() async {
    final data = PrefsService.getUserProfile();
    final userProfile = userProfileFromJson(data);
    String email = userProfile.email ?? '';
    if (email.isEmpty) {
      connectEmailStatusSubject.sink.add(ConnectEmailStatus.NOT_CONNECTED);
    } else {
      connectEmailStatusSubject.sink.add(ConnectEmailStatus.CONNECTED);
    }
  }
}
