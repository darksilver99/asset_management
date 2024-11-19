import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RepairListRecord extends FirestoreRecord {
  RepairListRecord._(
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

  // "finish_date" field.
  DateTime? _finishDate;
  DateTime? get finishDate => _finishDate;
  bool hasFinishDate() => _finishDate != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "image" field.
  List<String>? _image;
  List<String> get image => _image ?? const [];
  bool hasImage() => _image != null;

  // "finish_remark" field.
  String? _finishRemark;
  String get finishRemark => _finishRemark ?? '';
  bool hasFinishRemark() => _finishRemark != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _remark = snapshotData['remark'] as String?;
    _assetRef = snapshotData['asset_ref'] as DocumentReference?;
    _finishDate = snapshotData['finish_date'] as DateTime?;
    _price = castToType<int>(snapshotData['price']);
    _image = getDataList(snapshotData['image']);
    _finishRemark = snapshotData['finish_remark'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('repair_list')
          : FirebaseFirestore.instance.collectionGroup('repair_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('repair_list').doc(id);

  static Stream<RepairListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RepairListRecord.fromSnapshot(s));

  static Future<RepairListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RepairListRecord.fromSnapshot(s));

  static RepairListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RepairListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RepairListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RepairListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RepairListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RepairListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRepairListRecordData({
  DateTime? createDate,
  String? remark,
  DocumentReference? assetRef,
  DateTime? finishDate,
  int? price,
  String? finishRemark,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'remark': remark,
      'asset_ref': assetRef,
      'finish_date': finishDate,
      'price': price,
      'finish_remark': finishRemark,
    }.withoutNulls,
  );

  return firestoreData;
}

class RepairListRecordDocumentEquality implements Equality<RepairListRecord> {
  const RepairListRecordDocumentEquality();

  @override
  bool equals(RepairListRecord? e1, RepairListRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createDate == e2?.createDate &&
        e1?.remark == e2?.remark &&
        e1?.assetRef == e2?.assetRef &&
        e1?.finishDate == e2?.finishDate &&
        e1?.price == e2?.price &&
        listEquality.equals(e1?.image, e2?.image) &&
        e1?.finishRemark == e2?.finishRemark;
  }

  @override
  int hash(RepairListRecord? e) => const ListEquality().hash([
        e?.createDate,
        e?.remark,
        e?.assetRef,
        e?.finishDate,
        e?.price,
        e?.image,
        e?.finishRemark
      ]);

  @override
  bool isValidKey(Object? o) => o is RepairListRecord;
}
