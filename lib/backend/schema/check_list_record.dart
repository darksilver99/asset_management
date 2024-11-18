import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckListRecord extends FirestoreRecord {
  CheckListRecord._(
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

  // "checker_name" field.
  String? _checkerName;
  String get checkerName => _checkerName ?? '';
  bool hasCheckerName() => _checkerName != null;

  // "image" field.
  List<String>? _image;
  List<String> get image => _image ?? const [];
  bool hasImage() => _image != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _remark = snapshotData['remark'] as String?;
    _assetRef = snapshotData['asset_ref'] as DocumentReference?;
    _checkerName = snapshotData['checker_name'] as String?;
    _image = getDataList(snapshotData['image']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('check_list')
          : FirebaseFirestore.instance.collectionGroup('check_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('check_list').doc(id);

  static Stream<CheckListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CheckListRecord.fromSnapshot(s));

  static Future<CheckListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CheckListRecord.fromSnapshot(s));

  static CheckListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CheckListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CheckListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CheckListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CheckListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CheckListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCheckListRecordData({
  DateTime? createDate,
  String? remark,
  DocumentReference? assetRef,
  String? checkerName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'remark': remark,
      'asset_ref': assetRef,
      'checker_name': checkerName,
    }.withoutNulls,
  );

  return firestoreData;
}

class CheckListRecordDocumentEquality implements Equality<CheckListRecord> {
  const CheckListRecordDocumentEquality();

  @override
  bool equals(CheckListRecord? e1, CheckListRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createDate == e2?.createDate &&
        e1?.remark == e2?.remark &&
        e1?.assetRef == e2?.assetRef &&
        e1?.checkerName == e2?.checkerName &&
        listEquality.equals(e1?.image, e2?.image);
  }

  @override
  int hash(CheckListRecord? e) => const ListEquality()
      .hash([e?.createDate, e?.remark, e?.assetRef, e?.checkerName, e?.image]);

  @override
  bool isValidKey(Object? o) => o is CheckListRecord;
}
