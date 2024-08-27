import 'package:hive/hive.dart';

part 'memory_model.g.dart';

@HiveType(typeId: 0)
class Memory extends HiveObject {
  @HiveField(0)
  late final String imagePath;

  @HiveField(1)
  late final String caption;

  @HiveField(2)
  late final DateTime timeAdded;

  Memory({
    required this.imagePath,
    required this.caption,
    required this.timeAdded,
  });
}
