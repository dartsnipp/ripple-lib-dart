part of ripplelib.core;

class FieldType extends Enum {

  static const FieldType UNKNOWN = const FieldType._(-2, Object);
  static const FieldType DONE = const FieldType._(-1, Object);
  static const FieldType NOT_PRESENT = const FieldType._(0, Object);

  static const FieldType UINT16 = const FieldType._(1, int);
  static const FieldType UINT32 = const FieldType._(2, int);
  static const FieldType UINT64 = const FieldType._(3, BigInteger);
  static const FieldType HASH128 = const FieldType._(4, Hash128);
  static const FieldType HASH256 = const FieldType._(5, Hash256);
  static const FieldType AMOUNT = const FieldType._(6, Amount);
  static const FieldType VARLEN = const FieldType._(7, Uint8List);
  static const FieldType ACCOUNT = const FieldType._(8, AccountID);

  static const FieldType OBJECT = const FieldType._(14, RippleSerializedObject);
  static const FieldType ARRAY = const FieldType._(15, List);

  static const FieldType UINT8 = const FieldType._(16, int);
  static const FieldType HASH160 = const FieldType._(17, Hash160);
  static const FieldType PATH_SET = const FieldType._(18, PathSet);
  static const FieldType VECTOR256 = const FieldType._(19, List);

  static const FieldType TRANSACTION = const FieldType._(10001, Transaction);
  static const FieldType LEDGER_ENTRY = const FieldType._(10002, LedgerEntry);
  static const FieldType VALIDATION = const FieldType._(10003, Object); //TODO

  final int id;
  final Type nativeType; // only used informative
  const FieldType._(this.id, this.nativeType);

  // required by Enum
  static FieldType valueOf(String e) => Enum.valueOf(FieldType, e);
  static List<FieldType> get values => Enum.values(FieldType);
}