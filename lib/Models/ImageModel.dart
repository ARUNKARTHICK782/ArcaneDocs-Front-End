class ImageModel{
  String? _id;
  String? _img_url;
  String? _post_id;
  String? _created_at;
  String? _updated_at;
  ImageModel(this._id, this._img_url, this._post_id, this._created_at,
      this._updated_at);

  String? get updated_at => _updated_at;

  set updated_at(String? value) {
    _updated_at = value;
  }

  String? get created_at => _created_at;

  set created_at(String? value) {
    _created_at = value;
  }

  String? get post_id => _post_id;

  set post_id(String? value) {
    _post_id = value;
  }

  String? get img_url => _img_url;

  set img_url(String? value) {
    _img_url = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'ImageModel{_id: $_id, _img_url: $_img_url, _post_id: $_post_id, _created_at: $_created_at, _updated_at: $_updated_at}';
  }
}