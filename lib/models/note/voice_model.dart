class VoiceModel {
  final String filename;
  final String filePath;

  VoiceModel(this.filename, this.filePath);

  factory VoiceModel.fromMap(Map<String, dynamic> json) {
    return VoiceModel(
      json['filename'],
      json['filePath'],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data['filename'] = filename;
    data['filePath'] = filePath;
    return data;
  }

//  factory VoiceModel.fromJson(Map<String, dynamic> json) => _$VoiceModelFromJson(json);

  Map toJson() => {
        'filename': filename,
        'filePath': filePath,
      };
}
