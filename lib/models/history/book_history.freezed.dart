// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'book_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookHistory _$BookHistoryFromJson(Map<String, dynamic> json) {
  return _BookHistory.fromJson(json);
}

/// @nodoc
class _$BookHistoryTearOff {
  const _$BookHistoryTearOff();

  _BookHistory call(
      {required String isbn,
      required int seq,
      required int isBorrowed,
      required String? holderId,
      required String? borrowFrom,
      required String? borrowTo,
      required String createdAt}) {
    return _BookHistory(
      isbn: isbn,
      seq: seq,
      isBorrowed: isBorrowed,
      holderId: holderId,
      borrowFrom: borrowFrom,
      borrowTo: borrowTo,
      createdAt: createdAt,
    );
  }

  BookHistory fromJson(Map<String, Object> json) {
    return BookHistory.fromJson(json);
  }
}

/// @nodoc
const $BookHistory = _$BookHistoryTearOff();

/// @nodoc
mixin _$BookHistory {
  String get isbn => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  int get isBorrowed => throw _privateConstructorUsedError;
  String? get holderId => throw _privateConstructorUsedError;
  String? get borrowFrom => throw _privateConstructorUsedError;
  String? get borrowTo => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookHistoryCopyWith<BookHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookHistoryCopyWith<$Res> {
  factory $BookHistoryCopyWith(
          BookHistory value, $Res Function(BookHistory) then) =
      _$BookHistoryCopyWithImpl<$Res>;
  $Res call(
      {String isbn,
      int seq,
      int isBorrowed,
      String? holderId,
      String? borrowFrom,
      String? borrowTo,
      String createdAt});
}

/// @nodoc
class _$BookHistoryCopyWithImpl<$Res> implements $BookHistoryCopyWith<$Res> {
  _$BookHistoryCopyWithImpl(this._value, this._then);

  final BookHistory _value;
  // ignore: unused_field
  final $Res Function(BookHistory) _then;

  @override
  $Res call({
    Object? isbn = freezed,
    Object? seq = freezed,
    Object? isBorrowed = freezed,
    Object? holderId = freezed,
    Object? borrowFrom = freezed,
    Object? borrowTo = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      isbn: isbn == freezed
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String,
      seq: seq == freezed
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      isBorrowed: isBorrowed == freezed
          ? _value.isBorrowed
          : isBorrowed // ignore: cast_nullable_to_non_nullable
              as int,
      holderId: holderId == freezed
          ? _value.holderId
          : holderId // ignore: cast_nullable_to_non_nullable
              as String?,
      borrowFrom: borrowFrom == freezed
          ? _value.borrowFrom
          : borrowFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      borrowTo: borrowTo == freezed
          ? _value.borrowTo
          : borrowTo // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BookHistoryCopyWith<$Res>
    implements $BookHistoryCopyWith<$Res> {
  factory _$BookHistoryCopyWith(
          _BookHistory value, $Res Function(_BookHistory) then) =
      __$BookHistoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String isbn,
      int seq,
      int isBorrowed,
      String? holderId,
      String? borrowFrom,
      String? borrowTo,
      String createdAt});
}

/// @nodoc
class __$BookHistoryCopyWithImpl<$Res> extends _$BookHistoryCopyWithImpl<$Res>
    implements _$BookHistoryCopyWith<$Res> {
  __$BookHistoryCopyWithImpl(
      _BookHistory _value, $Res Function(_BookHistory) _then)
      : super(_value, (v) => _then(v as _BookHistory));

  @override
  _BookHistory get _value => super._value as _BookHistory;

  @override
  $Res call({
    Object? isbn = freezed,
    Object? seq = freezed,
    Object? isBorrowed = freezed,
    Object? holderId = freezed,
    Object? borrowFrom = freezed,
    Object? borrowTo = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_BookHistory(
      isbn: isbn == freezed
          ? _value.isbn
          : isbn // ignore: cast_nullable_to_non_nullable
              as String,
      seq: seq == freezed
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      isBorrowed: isBorrowed == freezed
          ? _value.isBorrowed
          : isBorrowed // ignore: cast_nullable_to_non_nullable
              as int,
      holderId: holderId == freezed
          ? _value.holderId
          : holderId // ignore: cast_nullable_to_non_nullable
              as String?,
      borrowFrom: borrowFrom == freezed
          ? _value.borrowFrom
          : borrowFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      borrowTo: borrowTo == freezed
          ? _value.borrowTo
          : borrowTo // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookHistory implements _BookHistory {
  const _$_BookHistory(
      {required this.isbn,
      required this.seq,
      required this.isBorrowed,
      required this.holderId,
      required this.borrowFrom,
      required this.borrowTo,
      required this.createdAt});

  factory _$_BookHistory.fromJson(Map<String, dynamic> json) =>
      _$_$_BookHistoryFromJson(json);

  @override
  final String isbn;
  @override
  final int seq;
  @override
  final int isBorrowed;
  @override
  final String? holderId;
  @override
  final String? borrowFrom;
  @override
  final String? borrowTo;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'BookHistory(isbn: $isbn, seq: $seq, isBorrowed: $isBorrowed, holderId: $holderId, borrowFrom: $borrowFrom, borrowTo: $borrowTo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BookHistory &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.seq, seq) ||
                const DeepCollectionEquality().equals(other.seq, seq)) &&
            (identical(other.isBorrowed, isBorrowed) ||
                const DeepCollectionEquality()
                    .equals(other.isBorrowed, isBorrowed)) &&
            (identical(other.holderId, holderId) ||
                const DeepCollectionEquality()
                    .equals(other.holderId, holderId)) &&
            (identical(other.borrowFrom, borrowFrom) ||
                const DeepCollectionEquality()
                    .equals(other.borrowFrom, borrowFrom)) &&
            (identical(other.borrowTo, borrowTo) ||
                const DeepCollectionEquality()
                    .equals(other.borrowTo, borrowTo)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(seq) ^
      const DeepCollectionEquality().hash(isBorrowed) ^
      const DeepCollectionEquality().hash(holderId) ^
      const DeepCollectionEquality().hash(borrowFrom) ^
      const DeepCollectionEquality().hash(borrowTo) ^
      const DeepCollectionEquality().hash(createdAt);

  @JsonKey(ignore: true)
  @override
  _$BookHistoryCopyWith<_BookHistory> get copyWith =>
      __$BookHistoryCopyWithImpl<_BookHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BookHistoryToJson(this);
  }
}

abstract class _BookHistory implements BookHistory {
  const factory _BookHistory(
      {required String isbn,
      required int seq,
      required int isBorrowed,
      required String? holderId,
      required String? borrowFrom,
      required String? borrowTo,
      required String createdAt}) = _$_BookHistory;

  factory _BookHistory.fromJson(Map<String, dynamic> json) =
      _$_BookHistory.fromJson;

  @override
  String get isbn => throw _privateConstructorUsedError;
  @override
  int get seq => throw _privateConstructorUsedError;
  @override
  int get isBorrowed => throw _privateConstructorUsedError;
  @override
  String? get holderId => throw _privateConstructorUsedError;
  @override
  String? get borrowFrom => throw _privateConstructorUsedError;
  @override
  String? get borrowTo => throw _privateConstructorUsedError;
  @override
  String get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BookHistoryCopyWith<_BookHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
