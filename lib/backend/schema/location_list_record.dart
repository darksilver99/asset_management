import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocationListRecord extends FirestoreRecord {
  LocationListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "remark" field.
  String? _remark;
  String get remark => _remark ?? '';
  bool hasRemark() => _remark != null;

  // "asset_ref" field.
  DocumentReference? _assetRef;
  DocumentReference? get assetRef => _assetRef;
  bool hasAssetRef() => _assetRef != null;

  // "location_name" field.
  String? _locationName;
  String get locationName => _locationName ?? '';
  bool hasLocationName() => _locationName != null;

  // "last_date" field.
  DateTime? _lastDate;
  DateTime? get lastDate => _lastDate;
  bool hasLastDate() => _lastDate != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _remark = snapshotData['remark'] as String?;
    _assetRef = snapshotData['asset_ref'] as DocumentReference?;
    _locationName = snapshotData['location_name'] as String?;
    _lastDate = snapshotData['last_date'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('location_list')
          : FirebaseFirestore.instance.collectionGroup('location_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('location_list').doc(id);

  static Stream<LocationListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LocationListRecord.fromSnapshot(s));

  static Future<LocationListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LocationListRecord.fromSnapshot(s));

  static LocationListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LocationListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LocationListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LocationListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LocationListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LocationListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLocationListRecordData({
  DateTime? createDate,
  String? remark,
  DocumentReference? assetRef,
  String? locationName,
  DateTime? lastDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'remark': remark,
      'asset_ref': assetRef,
      'location_name': locationName,
      'last_date': lastDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class LocationListRecordDocumentEquality
    implements Equality<LocationListRecord> {
  const LocationListRecordDocumentEquality();

  @override
  bool equals(LocationListRecord? e1, LocationListRecord? e2) {
    return e1?.createDate == e2?.createDate &&
        e1?.remark == e2?.remark &&
        e1?.assetRef == e2?.assetRef &&
        e1?.locationName == e2?.locationName &&
        e1?.lastDate == e2?.lastDate;
  }

  @override
  int hash(LocationListRecord? e) => const ListEquality().hash(
      [e?.createDate, e?.remark, e?.assetRef, e?.locationName, e?.lastDate]);

  @override
  bool isValidKey(Object? o) => o is LocationListRecord;
}
