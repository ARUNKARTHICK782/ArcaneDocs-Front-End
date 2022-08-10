import 'package:mycloud/Models/ImageModel.dart';

class PostModel{
  String? _id;
  String? _title;
  String? _user_id;
  String? _created_at;
  String? _updated_at;
  List<ImageModel> _imgs;


  List<ImageModel> get imgs => _imgs;

  set imgs(List<ImageModel> value) {
    _imgs = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  String? get title => _title;

  String? get updated_at => _updated_at;

  set updated_at(String? value) {
    _updated_at = value;
  }

  String? get created_at => _created_at;

  set created_at(String? value) {
    _created_at = value;
  }

  String? get user_id => _user_id;

  set user_id(String? value) {
    _user_id = value;
  }

  set title(String? value) {
    _title = value;
  }

  PostModel(
      this._id, this._title, this._user_id, this._created_at, this._updated_at,this._imgs);

  @override
  String toString() {
    return 'PostModel{_id: $_id, _title: $_title, _user_id: $_user_id, _created_at: $_created_at, _updated_at: $_updated_at, _imgs: $_imgs}';
  }
}