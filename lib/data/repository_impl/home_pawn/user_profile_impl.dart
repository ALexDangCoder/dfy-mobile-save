import 'package:Dfy/data/response/pawn/user_profile/user_profile_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/home_pawn/user_profile_service.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';

class UserProfileRepositoryImpl implements UsersRepository {
  final UserProfileService _userService;

  UserProfileRepositoryImpl(this._userService);

  @override
  Future<Result<UserProfile>> getUserProfile({String? userId}) {
    return runCatchingAsync<UserProfileResponse,
        UserProfile>(
          () => _userService.getOfficialPawn(userId ?? ''),
          (response) => response.data?.toDomain() ?? UserProfile(),
    );
  }
}