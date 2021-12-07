
import 'package:Dfy/data/services/account_service.dart';
import 'package:Dfy/domain/repository/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountClient _accountService;

  AccountRepositoryImpl(
    this._accountService,
  );

}
