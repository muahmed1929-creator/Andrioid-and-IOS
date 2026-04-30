import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sim_expiry_tracker/core/isar_service.dart';
import 'package:sim_expiry_tracker/features/accounts/domain/account_model.dart';

part 'account_provider.g.dart';

@Riverpod(keepAlive: true)
IsarService isarService(IsarServiceRef ref) {
  // This will be overridden in main.dart
  throw UnimplementedError();
}

@riverpod
class Accounts extends _$Accounts {
  @override
  Stream<List<Account>> build() {
    final service = ref.watch(isarServiceProvider);
    return service.watchAccounts();
  }

  Future<void> addAccount(Account account) async {
    await ref.read(isarServiceProvider).saveAccount(account);
  }

  Future<void> deleteAccount(int id) async {
    await ref.read(isarServiceProvider).deleteAccount(id);
  }

  Future<void> archiveAccount(int id) async {
    await ref.read(isarServiceProvider).archiveAccount(id);
  }
}
