import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_history.freezed.dart';
part 'book_history.g.dart';

@freezed
abstract class BookHistory with _$BookHistory {
  const factory BookHistory({
    required String isbn,
    required int seq,
    required int isBorrowed,
    required String? holderId,
    required String? borrowFrom,
    required String? borrowTo,
    required String createdAt,
  }) = _BookHistory;

  factory BookHistory.fromJson(Map<String, dynamic> json) =>
      _$BookHistoryFromJson(json);

  // BookStateのjsonからBookHistoryを作成する
  // BookStateのupdatedAtをBookHistoryのcreatedAtとする
  factory BookHistory.fromJsonBookState(Map<String, dynamic> json) =>
      BookHistory(
        isbn: json['isbn'],
        seq: json['seq'],
        isBorrowed: json['isBorrowed'],
        holderId: json['holderId'],
        borrowFrom: json['borrowFrom'],
        borrowTo: json['borrowTo'],
        createdAt: json['updatedAt'],
      );
}
