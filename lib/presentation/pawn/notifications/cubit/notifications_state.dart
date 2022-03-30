part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState extends Equatable {}

class NotificationsInitial extends NotificationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationsLoadMore extends NotificationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationsSuccess extends NotificationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NotificationsDetailSuccess extends NotificationsState {

  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<NotificationDetail>? list;
  final String? message;

  NotificationsDetailSuccess(this.completeType,{this.list,this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [id,completeType,list,message];
}
