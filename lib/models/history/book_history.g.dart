// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookHistory _$_$_BookHistoryFromJson(Map<String, dynamic> json) {
  return _$_BookHistory(
    isbn: json['isbn'] as String,
    seq: json['seq'] as int,
    isBorrowed: json['isBorrowed'] as int,
    holderId: json['holderId'] as String?,
    borrowFrom: json['borrowFrom'] as String?,
    borrowTo: json['borrowTo'] as String?,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$_$_BookHistoryToJson(_$_BookHistory instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'seq': instance.seq,
      'isBorrowed': instance.isBorrowed,
      'holderId': instance.holderId,
      'borrowFrom': instance.borrowFrom,
      'borrowTo': instance.borrowTo,
      'createdAt': instance.createdAt,
    };
