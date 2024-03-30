import 'package:hive/hive.dart';

part 'id.g.dart';

@HiveType(typeId: 3)
class Id {
  Id({
    required this.idNumber,
    required this.Addres,
    required this.ExpiryDate,
    required this.cardHolderName,
    required this.DateOfBirth,
    required this.Jop,
    this.cardType,
  });

  @HiveField(0)
  String idNumber;
  @HiveField(1)
  String ExpiryDate;
  @HiveField(2)
  String cardHolderName;
  @HiveField(3)
  String Addres;
  @HiveField(4)
  String DateOfBirth;
  @HiveField(6)
  String Jop;

  @HiveField(7, defaultValue: 'other ')
  String? cardType;
}
