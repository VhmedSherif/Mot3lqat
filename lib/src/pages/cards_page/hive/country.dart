import 'package:hive/hive.dart';
part 'country.g.dart';

@HiveType(typeId: 2)
class Country {
  Country({
    required this.code,
    required this.name,
    required this.flagEmoji,
  });

  @HiveField(0)
  String code;

  @HiveField(1)
  String name;

  @HiveField(2)
  String flagEmoji;
}
