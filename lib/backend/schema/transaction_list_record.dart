import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionListRecord extends FirestoreRecord {
  TransactionListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "asset_ref" field.
  DocumentReference? _assetRef;
  DocumentReference? get assetRef => _assetRef;
  bool hasAssetRef() => _assetRef != null;

  // "ref_path" field.
  String? _refPath;
  String get refPath => _refPath ?? '';
  bool hasRefPath() => _refPath != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  bool hasSubject() => _subject != null;

  // "remark" field.
  String? _remark;
  String get remark => _remark ?? '';
  bool hasRemark() => _remark != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _assetRef = snapshotData['asset_ref'] as DocumentReference?;
    _refPath = snapshotData['ref_path'] as String?;
    _subject = snapshotData['subject'] as String?;
    _remark = snapshotData['remark'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('transaction_list')
          : FirebaseFirestore.instance.collectionGroup('transaction_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('transaction_list').doc(id);

  static Stream<TransactionListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionListRecord.fromSnapshot(s));

  static Future<TransactionListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionListRecord.fromSnapshot(s));

  static TransactionListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTransactionListRecordData({
  DateTime? createDate,
  DocumentReference? assetRef,
  String? refPath,
  String? subject,
  String? remark,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'asset_ref': assetRef,
      'ref_path': refPath,
      'subject': subject,
      'remark': remark,
    }.withoutNulls,
  );

  return firestoreData;
}

class TransactionListRecordDocumentEquality
    implements Equality<TransactionListRecord> {
  const TransactionListRecordDocumentEquality();

  @override
  bool equals(TransactionListRecord? e1, TransactionListRecord? e2) {
    return e1?.createDate == e2?.createDate &&
        e1?.assetRef == e2?.assetRef &&
        e1?.refPath == e2?.refPath &&
        e1?.subject == e2?.subject &&
        e1?.remark == e2?.remark;
  }

  @override
  int hash(TransactionListRecord? e) => const ListEquality()
      .hash([e?.createDate, e?.assetRef, e?.refPath, e?.subject, e?.remark]);

  @override
  bool isValidKey(Object? o) => o is TransactionListRecord;
}
