

// ignore_for_file: file_names

class Parcel {
  final String id;
  final String? title;
  final String? description;
  final int startValue;
  final int endValue;
  final String unit;
  final String parcelType;
  final bool deleted;
  final bool status;
  final int? basePrice;

  Parcel({
    required this.id,
    this.title,
    this.description,
    required this.startValue,
    required this.endValue,
    required this.unit,
    required this.parcelType,
    required this.deleted,
    required this.status,
    this.basePrice,
  });
}
