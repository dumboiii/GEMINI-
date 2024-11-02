import 'dart:typed_data';

class AiModel {
  bool? isUser;
  String? text;
  List<Uint8List>? images;

  AiModel({this.isUser, this.text, this.images});

  AiModel.fromJson(Map<String, dynamic> json) {
    isUser = json['is_user'];
    text = json['text'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_user'] = this.isUser;
    data['text'] = this.text;
    data['images'] = this.images;
    return data;
  }
}
