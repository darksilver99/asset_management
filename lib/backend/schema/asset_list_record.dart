import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AssetListRecord extends FirestoreRecord {
  AssetListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  bool hasSubject() => _subject != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _status = castToType<int>(snapshotData['status']);
    _subject = snapshotData['subject'] as String?;
    _detail = snapshotData['detail'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('asset_list')
          : FirebaseFirestore.instance.collectionGroup('asset_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('asset_list').doc(id);

  static Stream<AssetListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AssetListRecord.fromSnapshot(s));

  static Future<AssetListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AssetListRecord.fromSnapshot(s));

  static AssetListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AssetListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AssetListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AssetListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AssetListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AssetListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAssetListRecordData({
  DateTime? createDate,
  int? status,
  String? subject,
  String? detail,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'status': status,
      'subject': subject,
      'detail': detail,
    }.withoutNulls,
  );

  return firestoreData;
}

class AssetListRecordDocumentEquality implements Equality<AssetListRecord> {
  const AssetListRecordDocumentEquality();

  @override
  bool equals(AssetListRecord? e1, AssetListRecord? e2) {
    return e1?.createDate == e2?.createDate &&
        e1?.status == e2?.status &&
        e1?.subject == e2?.subject &&
        e1?.detail == e2?.detail;
  }

  @override
  int hash(AssetListRecord? e) => const ListEquality()
      .hash([e?.createDate, e?.status, e?.subject, e?.detail]);

  @override
  bool isValidKey(Object? o) => o is AssetListRecord;
}
