class User {
  /*
  This class encapsulates the json response from the api
  {
      'userId': '1908789',
      'username': username,
      'name': 'Peter Clarke',
      'lastLogin': "23 March 2020 03:34 PM",
      'email': 'x7uytx@mundanecode.com'
  }
  */
  String? _userId;
  String? _username;
  String? _name;
  String? _lastLogin;
  String? _email;

  // constructor
  User({
    required String userId,
    required String username,
    required String name,
    required String lastLogin,
    required String email,
  }) {
    _userId = userId;
    _username = username;
    _name = name;
    _lastLogin = lastLogin;
    _email = email;
  }

  // Properties
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get lastLogin => _lastLogin;
  set lastLogin(String? lastLogin) => _lastLogin = lastLogin;
  String? get email => _email;
  set email(String? email) => _email = email;

  // create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _username = json['username'];
    _name = json['name'];
    _lastLogin = json['lastLogin'];
    _email = json['email'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = _userId;
    data['username'] = _username;
    data['name'] = _name;
    data['lastLogin'] = _lastLogin;
    data['email'] = _email;
    return data;
  }
}
