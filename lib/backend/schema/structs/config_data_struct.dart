// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConfigDataStruct extends FFFirebaseStruct {
  ConfigDataStruct({
    List<String>? contact,
    int? freeDay,
    bool? isReview,
    List<String>? paymentAlertText,
    String? paymentDetailImage,
    String? policyUrl,
    String? promotionDetailImage,
    String? storeAndroidLink,
    String? storeIosLink,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _contact = contact,
        _freeDay = freeDay,
        _isReview = isReview,
        _paymentAlertText = paymentAlertText,
        _paymentDetailImage = paymentDetailImage,
        _policyUrl = policyUrl,
        _promotionDetailImage = promotionDetailImage,
        _storeAndroidLink = storeAndroidLink,
        _storeIosLink = storeIosLink,
        super(firestoreUtilData);

  // "contact" field.
  List<String>? _contact;
  List<String> get contact => _contact ?? const [];
  set contact(List<String>? val) => _contact = val;

  void updateContact(Function(List<String>) updateFn) {
    updateFn(_contact ??= []);
  }

  bool hasContact() => _contact != null;

  // "free_day" field.
  int? _freeDay;
  int get freeDay => _freeDay ?? 0;
  set freeDay(int? val) => _freeDay = val;

  void incrementFreeDay(int amount) => freeDay = freeDay + amount;

  bool hasFreeDay() => _freeDay != null;

  // "isReview" field.
  bool? _isReview;
  bool get isReview => _isReview ?? false;
  set isReview(bool? val) => _isReview = val;

  bool hasIsReview() => _isReview != null;

  // "payment_alert_text" field.
  List<String>? _paymentAlertText;
  List<String> get paymentAlertText => _paymentAlertText ?? const [];
  set paymentAlertText(List<String>? val) => _paymentAlertText = val;

  void updatePaymentAlertText(Function(List<String>) updateFn) {
    updateFn(_paymentAlertText ??= []);
  }

  bool hasPaymentAlertText() => _paymentAlertText != null;

  // "payment_detail_image" field.
  String? _paymentDetailImage;
  String get paymentDetailImage => _paymentDetailImage ?? '';
  set paymentDetailImage(String? val) => _paymentDetailImage = val;

  bool hasPaymentDetailImage() => _paymentDetailImage != null;

  // "policy_url" field.
  String? _policyUrl;
  String get policyUrl => _policyUrl ?? '';
  set policyUrl(String? val) => _policyUrl = val;

  bool hasPolicyUrl() => _policyUrl != null;

  // "promotion_detail_image" field.
  String? _promotionDetailImage;
  String get promotionDetailImage => _promotionDetailImage ?? '';
  set promotionDetailImage(String? val) => _promotionDetailImage = val;

  bool hasPromotionDetailImage() => _promotionDetailImage != null;

  // "store_android_link" field.
  String? _storeAndroidLink;
  String get storeAndroidLink => _storeAndroidLink ?? '';
  set storeAndroidLink(String? val) => _storeAndroidLink = val;

  bool hasStoreAndroidLink() => _storeAndroidLink != null;

  // "store_ios_link" field.
  String? _storeIosLink;
  String get storeIosLink => _storeIosLink ?? '';
  set storeIosLink(String? val) => _storeIosLink = val;

  bool hasStoreIosLink() => _storeIosLink != null;

  static ConfigDataStruct fromMap(Map<String, dynamic> data) =>
      ConfigDataStruct(
        contact: getDataList(data['contact']),
        freeDay: castToType<int>(data['free_day']),
        isReview: data['isReview'] as bool?,
        paymentAlertText: getDataList(data['payment_alert_text']),
        paymentDetailImage: data['payment_detail_image'] as String?,
        policyUrl: data['policy_url'] as String?,
        promotionDetailImage: data['promotion_detail_image'] as String?,
        storeAndroidLink: data['store_android_link'] as String?,
        storeIosLink: data['store_ios_link'] as String?,
      );

  static ConfigDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ConfigDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'contact': _contact,
        'free_day': _freeDay,
        'isReview': _isReview,
        'payment_alert_text': _paymentAlertText,
        'payment_detail_image': _paymentDetailImage,
        'policy_url': _policyUrl,
        'promotion_detail_image': _promotionDetailImage,
        'store_android_link': _storeAndroidLink,
        'store_ios_link': _storeIosLink,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'contact': serializeParam(
          _contact,
          ParamType.String,
          isList: true,
        ),
        'free_day': serializeParam(
          _freeDay,
          ParamType.int,
        ),
        'isReview': serializeParam(
          _isReview,
          ParamType.bool,
        ),
        'payment_alert_text': serializeParam(
          _paymentAlertText,
          ParamType.String,
          isList: true,
        ),
        'payment_detail_image': serializeParam(
          _paymentDetailImage,
          ParamType.String,
        ),
        'policy_url': serializeParam(
          _policyUrl,
          ParamType.String,
        ),
        'promotion_detail_image': serializeParam(
          _promotionDetailImage,
          ParamType.String,
        ),
        'store_android_link': serializeParam(
          _storeAndroidLink,
          ParamType.String,
        ),
        'store_ios_link': serializeParam(
          _storeIosLink,
          ParamType.String,
        ),
      }.withoutNulls;

  static ConfigDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConfigDataStruct(
        contact: deserializeParam<String>(
          data['contact'],
          ParamType.String,
          true,
        ),
        freeDay: deserializeParam(
          data['free_day'],
          ParamType.int,
          false,
        ),
        isReview: deserializeParam(
          data['isReview'],
          ParamType.bool,
          false,
        ),
        paymentAlertText: deserializeParam<String>(
          data['payment_alert_text'],
          ParamType.String,
          true,
        ),
        paymentDetailImage: deserializeParam(
          data['payment_detail_image'],
          ParamType.String,
          false,
        ),
        policyUrl: deserializeParam(
          data['policy_url'],
          ParamType.String,
          false,
        ),
        promotionDetailImage: deserializeParam(
          data['promotion_detail_image'],
          ParamType.String,
          false,
        ),
        storeAndroidLink: deserializeParam(
          data['store_android_link'],
          ParamType.String,
          false,
        ),
        storeIosLink: deserializeParam(
          data['store_ios_link'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ConfigDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ConfigDataStruct &&
        listEquality.equals(contact, other.contact) &&
        freeDay == other.freeDay &&
        isReview == other.isReview &&
        listEquality.equals(paymentAlertText, other.paymentAlertText) &&
        paymentDetailImage == other.paymentDetailImage &&
        policyUrl == other.policyUrl &&
        promotionDetailImage == other.promotionDetailImage &&
        storeAndroidLink == other.storeAndroidLink &&
        storeIosLink == other.storeIosLink;
  }

  @override
  int get hashCode => const ListEquality().hash([
        contact,
        freeDay,
        isReview,
        paymentAlertText,
        paymentDetailImage,
        policyUrl,
        promotionDetailImage,
        storeAndroidLink,
        storeIosLink
      ]);
}

ConfigDataStruct createConfigDataStruct({
  int? freeDay,
  bool? isReview,
  String? paymentDetailImage,
  String? policyUrl,
  String? promotionDetailImage,
  String? storeAndroidLink,
  String? storeIosLink,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConfigDataStruct(
      freeDay: freeDay,
      isReview: isReview,
      paymentDetailImage: paymentDetailImage,
      policyUrl: policyUrl,
      promotionDetailImage: promotionDetailImage,
      storeAndroidLink: storeAndroidLink,
      storeIosLink: storeIosLink,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConfigDataStruct? updateConfigDataStruct(
  ConfigDataStruct? configData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    configData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConfigDataStructData(
  Map<String, dynamic> firestoreData,
  ConfigDataStruct? configData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (configData == null) {
    return;
  }
  if (configData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && configData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final configDataData = getConfigDataFirestoreData(configData, forFieldValue);
  final nestedData = configDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = configData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConfigDataFirestoreData(
  ConfigDataStruct? configData, [
  bool forFieldValue = false,
]) {
  if (configData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(configData.toMap());

  // Add any Firestore field values
  configData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConfigDataListFirestoreData(
  List<ConfigDataStruct>? configDatas,
) =>
    configDatas?.map((e) => getConfigDataFirestoreData(e, true)).toList() ?? [];
