
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';

mixin UsersRepository {
  Future<Result<UserProfile>> getUserProfile({String? userId});
}
