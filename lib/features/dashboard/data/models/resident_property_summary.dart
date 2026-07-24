class ResidentPropertySummary {
  const ResidentPropertySummary({
    required this.propertyUnitId,
    required this.unitNumber,
    required this.propertyType,
    required this.unitStatus,
    required this.occupancyType,
    required this.startDate,
    this.buildingName,
    this.floorNumber,
  });

  final String propertyUnitId;
  final String unitNumber;
  final String propertyType;
  final String unitStatus;
  final String occupancyType;
  final DateTime startDate;
  final String? buildingName;
  final int? floorNumber;

  factory ResidentPropertySummary.fromJson(Map<String, dynamic> json) => ResidentPropertySummary(
        propertyUnitId: json['propertyUnitId'] as String,
        unitNumber: json['unitNumber'] as String,
        propertyType: json['propertyType'] as String,
        unitStatus: json['unitStatus'] as String,
        occupancyType: json['occupancyType'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        buildingName: json['buildingName'] as String?,
        floorNumber: json['floorNumber'] as int?,
      );
}
