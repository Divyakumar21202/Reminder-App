import 'package:mobx/mobx.dart';

part 'reminder.g.dart';

class Reminder = _Reminder with _$Reminder;

abstract class _Reminder with Store {
  final String id;
  final DateTime creationDate;
  bool isDone;
  String text;

  _Reminder({
    required this.id,
    required this.creationDate,
    required this.isDone,
    required this.text,
  });

  @override
  bool operator ==(covariant _Reminder other) =>
      other.id == id &&
      other.creationDate == creationDate &&
      other.text == text &&
      other.isDone == isDone;

  @override
  int get hashCode => Object.hash(
        id,
        creationDate,
        text,
        isDone,
      );
}
