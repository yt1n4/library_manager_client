// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookState _$_$_BookStateFromJson(Map<String, dynamic> json) {
  return _$_BookState(
    isbn: json['isbn'] as String,
    seq: json['seq'] as int,
    isBorrowed: json['isBorrowed'] as int,
    holderId: json['holderId'] as String?,
    borrowFrom: json['borrowFrom'] as String?,
    borrowTo: json['borrowTo'] as String?,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$_$_BookStateToJson(_$_BookState instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'seq': instance.seq,
      'isBorrowed': instance.isBorrowed,
      'holderId': instance.holderId,
      'borrowFrom': instance.borrowFrom,
      'borrowTo': instance.borrowTo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
