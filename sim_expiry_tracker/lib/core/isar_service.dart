import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sim_expiry_tracker/features/accounts/domain/account_model.dart';

import 'package:flutter/foundation.dart';

class IsarService {
  late Isar isar;

  Future<void> init() async {
    if (kIsWeb) {
      isar = await Isar.open(
        [AccountSchema],
        directory: '', // Isar web uses IndexedDB and ignores this, but empty string prevents error.
      );
    } else {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [AccountSchema],
        directory: dir.path,
      );
    }
  }

  Future<void> saveAccount(Account account) async {
    await isar.writeTxn(() async {
      await isar.accounts.put(account);
    });
  }

  Future<List<Account>> getAllAccounts() async {
    return await isar.accounts.where().findAll();
  }

  Stream<List<Account>> watchAccounts() {
    return isar.accounts.where().watch(fireImmediately: true);
  }

  Future<void> deleteAccount(Id id) async {
    await isar.writeTxn(() async {
      await isar.accounts.delete(id);
    });
  }

  Future<void> archiveAccount(Id id) async {
    await isar.writeTxn(() async {
      final account = await isar.accounts.get(id);
      if (account != null) {
        account.isArchived = true;
        await isar.accounts.put(account);
      }
    });
  }
}
