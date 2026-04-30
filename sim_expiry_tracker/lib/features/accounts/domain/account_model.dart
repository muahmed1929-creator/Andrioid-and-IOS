import 'package:isar/isar.dart';

part 'account_model.g.dart';

@collection
class Account {
  Id id = Isar.autoIncrement;

  late String name;
  late String simNumber;
  late String deviceName;
  late String packageType; // 'Weekly', 'Monthly', 'Custom'
  late DateTime activationDate;
  late DateTime expiryDate;
  String? notes;
  int? customDurationDays;
  
  bool isArchived = false;
  DateTime? lastRechargedAt;

  // UI state (not persisted if needed, but here we can use it for filtering)
  @ignore
  int get daysLeft => expiryDate.difference(DateTime.now()).inDays;

  @ignore
  String get status {
    final now = DateTime.now();
    if (expiryDate.isBefore(now)) return 'Expired';
    if (expiryDate.difference(now).inDays <= 3) return 'Expiring Soon';
    return 'Safe';
  }

  @ignore
  String get statusColor {
    final s = status;
    if (s == 'Expired') return 'Red';
    if (s == 'Expiring Soon') return 'Yellow';
    return 'Green';
  }
}
