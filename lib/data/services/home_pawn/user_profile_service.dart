import 'package:Dfy/data/response/pawn/user_profile/user_profile_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'user_profile_service.g.dart';

@RestApi()
abstract class UserProfileService {
  @factoryMethod
  factory UserProfileService(Dio dio, {String baseUrl}) = _UserProfileService;

  @GET('${ApiConstants.GET_PROFILE_USER}{userId}/profile')
  Future<UserProfileResponse> getOfficialPawn(
      @Path('userId') String userId,
      );

}
