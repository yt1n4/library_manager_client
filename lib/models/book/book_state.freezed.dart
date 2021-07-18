// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'book_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookState _$BookStateFromJson(Map<String, dynamic> json) {
  return _BookState.fromJson(json);
}

/// @nodoc
class _$BookStateTearOff {
  const _$BookStateTearOff();

  _BookState call(
      {required String isbn,
      required int seq,
      required int isBorrowed,
      required String? holderId,
      required String? borrowFrom,
      required String? borrowTo,
      required String createdAt,
      required String updatedAt}) {
    return _BookState(
      isbn: isbn,
      seq: seq,
      isBorrowed: isBorrowed,
      holderId: holderId,
      borrowFrom: borrowFrom,
      borrowTo: borrowTo,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  BookState fromJson(Map<String, Object> json) {
    return BookState.fromJson(json);
  }
}

/// @nodoc
const $BookState = _$BookStateTearOff();

/// @nodoc
mixin _$BookState {
  String get isbn => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  int get isBorrowed => throw _privateConstructorUsedError;
  String? get holderId => throw _privateConstructorUsedError;
  String? get borrowFrom => throw _privateConstructorUsedError;
  String? get borrowTo => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookStateCopyWith<BookState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookStateCopyWith<$Res> {
  factory $BookStateCopyWith(BookState value, $Res Function(BookState) then) =
      _$BookStateCopyWithImpl<$Res>;
  $Res call(
      {String isbn,
      int seq,
      int isBorrowed,
      String? holderId,
      String? borrowFrom,
      String? borrowTo,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$BookStateCopyWithImpl<$Res> implements $BookStateCopyWith<$Res> {
  _$BookStateCopyWithImpl(this._value, this._then);

  final BookState _value;
  // ignore: unused_field
  final $Res Function(BookState) _then;

  @override
  $Res call({
    Object? isbn = freezed,
    Object? seq = freezed,
    Object? isBorrowed = freezed,
    Object? holderId = freezed,
    Object? borrowFrom = freezed,
    Object? borrowTo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BookStateCopyWith<$Res> implements $BookStateCopyWith<$Res> {
  factory _$BookStateCopyWith(
          _BookState value, $Res Function(_BookState) then) =
      __$BookStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String isbn,
      int seq,
      int isBorrowed,
      String? holderId,
      String? borrowFrom,
      String? borrowTo,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$BookStateCopyWithImpl<$Res> extends _$BookStateCopyWithImpl<$Res>
    implements _$BookStateCopyWith<$Res> {
  __$BookStateCopyWithImpl(_BookState _value, $Res Function(_BookState) _then)
      : super(_value, (v) => _then(v as _BookState));

  @override
  _BookState get _value => super._value as _BookState;

  @override
  $Res call({
    Object? isbn = freezed,
    Object? seq = freezed,
    Object? isBorrowed = freezed,
    Object? holderId = freezed,
    Object? borrowFrom = freezed,
    Object? borrowTo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_BookState(
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
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookState extends _BookState {
  const _$_BookState(
      {required this.isbn,
      required this.seq,
      required this.isBorrowed,
      required this.holderId,
      required this.borrowFrom,
      required this.borrowTo,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  factory _$_BookState.fromJson(Map<String, dynamic> json) =>
      _$_$_BookStateFromJson(json);

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
  final String updatedAt;

  @override
  String toString() {
    return 'BookState(isbn: $isbn, seq: $seq, isBorrowed: $isBorrowed, holderId: $holderId, borrowFrom: $borrowFrom, borrowTo: $borrowTo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BookState &&
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
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
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
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$BookStateCopyWith<_BookState> get copyWith =>
      __$BookStateCopyWithImpl<_BookState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BookStateToJson(this);
  }
}

abstract class _BookState extends BookState {
  const factory _BookState(
      {required String isbn,
      required int seq,
      required int isBorrowed,
      required String? holderId,
      required String? borrowFrom,
      required String? borrowTo,
      required String createdAt,
      required String updatedAt}) = _$_BookState;
  const _BookState._() : super._();

  factory _BookState.fromJson(Map<String, dynamic> json) =
      _$_BookState.fromJson;

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
  String get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BookStateCopyWith<_BookState> get copyWith =>
      throw _privateConstructorUsedError;
}
