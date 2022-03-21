part of 'other_profile_cubit.dart';

@immutable
abstract class OtherProfileState extends Equatable{}

class OtherProfileInitial extends OtherProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OtherProfileSuccess extends OtherProfileState {

  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final UserProfile? userProfile;
  final String? message;
  OtherProfileSuccess(this.completeType, {this.userProfile, this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [id,completeType,userProfile,message];
}

