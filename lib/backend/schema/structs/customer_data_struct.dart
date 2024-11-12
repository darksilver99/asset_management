// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomerDataStruct extends FFFirebaseStruct {
  CustomerDataStruct({
    DateTime? expireDate,
    DocumentReference? customerRef,
    int? maxAssets,
    String? customerName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _expireDate = expireDate,
        _customerRef = customerRef,
        _maxAssets = maxAssets,
        _customerName = customerName,
        super(firestoreUtilData);

  // "expire_date" field.
  DateTime? _expireDate;
  DateTime? get expireDate => _expireDate;
  set expireDate(DateTime? val) => _expireDate = val;

  bool hasExpireDate() => _expireDate != null;

  // "customer_ref" field.
  DocumentReference? _customerRef;
  DocumentReference? get customerRef => _customerRef;
  set customerRef(DocumentReference? val) => _customerRef = val;

  bool hasCustomerRef() => _customerRef != null;

  // "max_assets" field.
  int? _maxAssets;
  int get maxAssets => _maxAssets ?? 0;
  set maxAssets(int? val) => _maxAssets = val;

  void incrementMaxAssets(int amount) => maxAssets = maxAssets + amount;

  bool hasMaxAssets() => _maxAssets != null;

  // "customer_name" field.
  String? _customerName;
  String get customerName => _customerName ?? '';
  set customerName(String? val) => _customerName = val;

  bool hasCustomerName() => _customerName != null;

  static CustomerDataStruct fromMap(Map<String, dynamic> data) =>
      CustomerDataStruct(
        expireDate: data['expire_date'] as DateTime?,
        customerRef: data['customer_ref'] as DocumentReference?,
        maxAssets: castToType<int>(data['max_assets']),
        customerName: data['customer_name'] as String?,
      );

  static CustomerDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CustomerDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'expire_date': _expireDate,
        'customer_ref': _customerRef,
        'max_assets': _maxAssets,
        'customer_name': _customerName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'expire_date': serializeParam(
          _expireDate,
          ParamType.DateTime,
        ),
        'customer_ref': serializeParam(
          _customerRef,
          ParamType.DocumentReference,
        ),
        'max_assets': serializeParam(
          _maxAssets,
          ParamType.int,
        ),
        'customer_name': serializeParam(
          _customerName,
          ParamType.String,
        ),
      }.withoutNulls;

  static CustomerDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CustomerDataStruct(
        expireDate: deserializeParam(
          data['expire_date'],
          ParamType.DateTime,
          false,
        ),
        customerRef: deserializeParam(
          data['customer_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['customer_list'],
        ),
        maxAssets: deserializeParam(
          data['max_assets'],
          ParamType.int,
          false,
        ),
        customerName: deserializeParam(
          data['customer_name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CustomerDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CustomerDataStruct &&
        expireDate == other.expireDate &&
        customerRef == other.customerRef &&
        maxAssets == other.maxAssets &&
        customerName == other.customerName;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([expireDate, customerRef, maxAssets, customerName]);
}

CustomerDataStruct createCustomerDataStruct({
  DateTime? expireDate,
  DocumentReference? customerRef,
  int? maxAssets,
  String? customerName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CustomerDataStruct(
      expireDate: expireDate,
      customerRef: customerRef,
      maxAssets: maxAssets,
      customerName: customerName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CustomerDataStruct? updateCustomerDataStruct(
  CustomerDataStruct? customerData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    customerData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCustomerDataStructData(
  Map<String, dynamic> firestoreData,
  CustomerDataStruct? customerData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (customerData == null) {
    return;
  }
  if (customerData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && customerData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final customerDataData =
      getCustomerDataFirestoreData(customerData, forFieldValue);
  final nestedData =
      customerDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = customerData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCustomerDataFirestoreData(
  CustomerDataStruct? customerData, [
  bool forFieldValue = false,
]) {
  if (customerData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(customerData.toMap());

  // Add any Firestore field values
  customerData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCustomerDataListFirestoreData(
  List<CustomerDataStruct>? customerDatas,
) =>
    customerDatas?.map((e) => getCustomerDataFirestoreData(e, true)).toList() ??
    [];
