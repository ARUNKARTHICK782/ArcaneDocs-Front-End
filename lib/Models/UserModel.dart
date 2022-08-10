class UserModel{
  String? _id;
  String? _session_id;
  String? _profile_url;
  String? _created_at;
  String? _updated_at;


  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  String? get session_id => _session_id;

  set session_id(String? value) {
    _session_id = value;
  }

  String? get profile_url => _profile_url;

  set profile_url(String? value) {
    _profile_url = value;
  }

  String? get created_at => _created_at;

  set created_at(String? value) {
    _created_at = value;
  }

  String? get updated_at => _updated_at;

  set updated_at(String? value) {
    _updated_at = value;
  }


  @override
  String toString() {
    return 'UserModel{_id: $_id, _session_id: $_session_id, _profile_url: $_profile_url, _created_at: $_created_at, _updated_at: $_updated_at}';
  }

  UserModel(this._id, this._session_id, this._profile_url, this._created_at,
      this._updated_at);

  UserModel.empty();
}