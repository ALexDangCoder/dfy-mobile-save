import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/notification.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'notifications_state.dart';

class NotificationsCubit extends BaseCubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  BehaviorSubject<String> delete = BehaviorSubject.seeded('0');

  UsersRepository get _repo => Get.find();

  List<NotificationData> listNotification = [];
  List<NotificationDetail> listNotificationDetail = [];

  int page = 0;
  String message = '';

  Future<void> getNoti({int? notiType, int? isRead}) async {
    showLoading();
    final Result<List<NotificationData>> result = await _repo.getNotification(
      notiType: notiType,
      isRead: isRead,
    );
    result.when(
      success: (res) {
        listNotification = res;
        emit(NotificationsSuccess());
        showContent();
      },
      error: (error) {},
    );
  }

  ///NotiDetail

  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;

  Future<void> refreshPosts({int? notiType, int? isRead}) async {
    canLoadMoreList = true;
    if (!refresh) {
      showLoading();
      emit(NotificationsInitial());
      page = 0;
      refresh = true;
      await getNotiDetail(
        notiType: notiType,
        isRead: isRead,
      );
    }
  }

  Future<void> loadMorePosts({int? notiType, int? isRead}) async {
    if (!loadMore) {
      emit(NotificationsLoadMore());
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getNotiDetail(
        notiType: notiType,
        isRead: isRead,
      );
    }
  }

  Future<void> getNotiDetail({int? notiType, int? isRead}) async {
    showLoading();
    final Result<List<NotificationDetail>> result =
        await _repo.getNotificationDetail(
      notiType: notiType,
      isRead: isRead,
      page: page,
    );
    result.when(
      success: (res) {
        emit(NotificationsDetailSuccess(CompleteType.SUCCESS, list: res));
      },
      error: (error) {
        emit(NotificationsDetailSuccess(CompleteType.ERROR,
            message: error.message));
      },
    );
  }

  Future<void> updateNoti(int? idNoti) async {
    final Result<String> result = await _repo.updateNoti(id: idNoti.toString());
    result.when(success: (success) {}, error: (err) {});
  }
  Future<void> deleteNoti(int? idNoti) async {
    final Result<String> result = await _repo.deleteNoti(id: idNoti.toString());
    result.when(success: (success) {}, error: (err) {});
  }
}
