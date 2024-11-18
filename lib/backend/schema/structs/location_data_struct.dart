// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocationDataStruct extends FFFirebaseStruct {
  LocationDataStruct({
    List<String>? imageList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _imageList = imageList,
        super(firestoreUtilData);

  // "imageList" field.
  List<String>? _imageList;
  List<String> get imageList => _imageList ?? const [];
  set imageList(List<String>? val) => _imageList = val;

  void updateImageList(Function(List<String>) updateFn) {
    updateFn(_imageList ??= []);
  }

  bool hasImageList() => _imageList != null;

  static LocationDataStruct fromMap(Map<String, dynamic> data) =>
      LocationDataStruct(
        imageList: getDataList(data['imageList']),
      );

  static LocationDataStruct? maybeFromMap(dynamic data) => data is Map
      ? LocationDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'imageList': _imageList,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'imageList': serializeParam(
          _imageList,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static LocationDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationDataStruct(
        imageList: deserializeParam<String>(
          data['imageList'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'LocationDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LocationDataStruct &&
        listEquality.equals(imageList, other.imageList);
  }

  @override
  int get hashCode => const ListEquality().hash([imageList]);
}

LocationDataStruct createLocationDataStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LocationDataStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LocationDataStruct? updateLocationDataStruct(
  LocationDataStruct? locationData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    locationData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLocationDataStructData(
  Map<String, dynamic> firestoreData,
  LocationDataStruct? locationData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (locationData == null) {
    return;
  }
  if (locationData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && locationData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final locationDataData =
      getLocationDataFirestoreData(locationData, forFieldValue);
  final nestedData =
      locationDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = locationData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLocationDataFirestoreData(
  LocationDataStruct? locationData, [
  bool forFieldValue = false,
]) {
  if (locationData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(locationData.toMap());

  // Add any Firestore field values
  locationData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLocationDataListFirestoreData(
  List<LocationDataStruct>? locationDatas,
) =>
    locationDatas?.map((e) => getLocationDataFirestoreData(e, true)).toList() ??
    [];
