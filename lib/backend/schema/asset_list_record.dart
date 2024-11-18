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

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  bool hasSubject() => _subject != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "purchase_date" field.
  DateTime? _purchaseDate;
  DateTime? get purchaseDate => _purchaseDate;
  bool hasPurchaseDate() => _purchaseDate != null;

  // "serial_number" field.
  String? _serialNumber;
  String get serialNumber => _serialNumber ?? '';
  bool hasSerialNumber() => _serialNumber != null;

  // "update_date" field.
  DateTime? _updateDate;
  DateTime? get updateDate => _updateDate;
  bool hasUpdateDate() => _updateDate != null;

  // "last_check_ref" field.
  DocumentReference? _lastCheckRef;
  DocumentReference? get lastCheckRef => _lastCheckRef;
  bool hasLastCheckRef() => _lastCheckRef != null;

  // "last_repair_ref" field.
  DocumentReference? _lastRepairRef;
  DocumentReference? get lastRepairRef => _lastRepairRef;
  bool hasLastRepairRef() => _lastRepairRef != null;

  // "last_location_ref" field.
  DocumentReference? _lastLocationRef;
  DocumentReference? get lastLocationRef => _lastLocationRef;
  bool hasLastLocationRef() => _lastLocationRef != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "lost_detail" field.
  String? _lostDetail;
  String get lostDetail => _lostDetail ?? '';
  bool hasLostDetail() => _lostDetail != null;

  // "lost_date" field.
  DateTime? _lostDate;
  DateTime? get lostDate => _lostDate;
  bool hasLostDate() => _lostDate != null;

  // "broken_detail" field.
  String? _brokenDetail;
  String get brokenDetail => _brokenDetail ?? '';
  bool hasBrokenDetail() => _brokenDetail != null;

  // "broken_date" field.
  DateTime? _brokenDate;
  DateTime? get brokenDate => _brokenDate;
  bool hasBrokenDate() => _brokenDate != null;

  // "broken_image_list" field.
  List<String>? _brokenImageList;
  List<String> get brokenImageList => _brokenImageList ?? const [];
  bool hasBrokenImageList() => _brokenImageList != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _subject = snapshotData['subject'] as String?;
    _detail = snapshotData['detail'] as String?;
    _location = snapshotData['location'] as String?;
    _purchaseDate = snapshotData['purchase_date'] as DateTime?;
    _serialNumber = snapshotData['serial_number'] as String?;
    _updateDate = snapshotData['update_date'] as DateTime?;
    _lastCheckRef = snapshotData['last_check_ref'] as DocumentReference?;
    _lastRepairRef = snapshotData['last_repair_ref'] as DocumentReference?;
    _lastLocationRef = snapshotData['last_location_ref'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _image = snapshotData['image'] as String?;
    _price = castToType<int>(snapshotData['price']);
    _lostDetail = snapshotData['lost_detail'] as String?;
    _lostDate = snapshotData['lost_date'] as DateTime?;
    _brokenDetail = snapshotData['broken_detail'] as String?;
    _brokenDate = snapshotData['broken_date'] as DateTime?;
    _brokenImageList = getDataList(snapshotData['broken_image_list']);
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
  String? subject,
  String? detail,
  String? location,
  DateTime? purchaseDate,
  String? serialNumber,
  DateTime? updateDate,
  DocumentReference? lastCheckRef,
  DocumentReference? lastRepairRef,
  DocumentReference? lastLocationRef,
  String? status,
  String? image,
  int? price,
  String? lostDetail,
  DateTime? lostDate,
  String? brokenDetail,
  DateTime? brokenDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'subject': subject,
      'detail': detail,
      'location': location,
      'purchase_date': purchaseDate,
      'serial_number': serialNumber,
      'update_date': updateDate,
      'last_check_ref': lastCheckRef,
      'last_repair_ref': lastRepairRef,
      'last_location_ref': lastLocationRef,
      'status': status,
      'image': image,
      'price': price,
      'lost_detail': lostDetail,
      'lost_date': lostDate,
      'broken_detail': brokenDetail,
      'broken_date': brokenDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class AssetListRecordDocumentEquality implements Equality<AssetListRecord> {
  const AssetListRecordDocumentEquality();

  @override
  bool equals(AssetListRecord? e1, AssetListRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createDate == e2?.createDate &&
        e1?.subject == e2?.subject &&
        e1?.detail == e2?.detail &&
        e1?.location == e2?.location &&
        e1?.purchaseDate == e2?.purchaseDate &&
        e1?.serialNumber == e2?.serialNumber &&
        e1?.updateDate == e2?.updateDate &&
        e1?.lastCheckRef == e2?.lastCheckRef &&
        e1?.lastRepairRef == e2?.lastRepairRef &&
        e1?.lastLocationRef == e2?.lastLocationRef &&
        e1?.status == e2?.status &&
        e1?.image == e2?.image &&
        e1?.price == e2?.price &&
        e1?.lostDetail == e2?.lostDetail &&
        e1?.lostDate == e2?.lostDate &&
        e1?.brokenDetail == e2?.brokenDetail &&
        e1?.brokenDate == e2?.brokenDate &&
        listEquality.equals(e1?.brokenImageList, e2?.brokenImageList);
  }

  @override
  int hash(AssetListRecord? e) => const ListEquality().hash([
        e?.createDate,
        e?.subject,
        e?.detail,
        e?.location,
        e?.purchaseDate,
        e?.serialNumber,
        e?.updateDate,
        e?.lastCheckRef,
        e?.lastRepairRef,
        e?.lastLocationRef,
        e?.status,
        e?.image,
        e?.price,
        e?.lostDetail,
        e?.lostDate,
        e?.brokenDetail,
        e?.brokenDate,
        e?.brokenImageList
      ]);

  @override
  bool isValidKey(Object? o) => o is AssetListRecord;
}
