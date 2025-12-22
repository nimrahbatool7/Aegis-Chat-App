// lib/models/threat_model.dart
enum ThreatType {
  malwareFile,
  harmfulLink,
}

class ThreatDetails {
  final ThreatType type;
  final String fileName;
  final String fileSize;
  final String description;
  final String? linkUrl;
  final DateTime detectedAt;

  ThreatDetails({
    required this.type,
    required this.fileName,
    required this.fileSize,
    required this.description,
    this.linkUrl,
    DateTime? detectedAt,
  }) : detectedAt = detectedAt ?? DateTime.now();

  factory ThreatDetails.fromJson(Map<String, dynamic> json) {
    return ThreatDetails(
      type: ThreatType.values[json['type'] ?? 0],
      fileName: json['fileName'] ?? '',
      fileSize: json['fileSize'] ?? '',
      description: json['description'] ?? '',
      linkUrl: json['linkUrl'],
      detectedAt: json['detectedAt'] != null 
          ? DateTime.parse(json['detectedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'fileName': fileName,
      'fileSize': fileSize,
      'description': description,
      'linkUrl': linkUrl,
      'detectedAt': detectedAt.toIso8601String(),
    };
  }
}