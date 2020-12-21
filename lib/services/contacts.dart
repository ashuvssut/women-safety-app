class Contacts {
  int _id;
  String _number;
  String _name;

  Contacts(this._number, this._name);

  //getters
  int get id => _id;
  String get number => _number;
  String get name => _name;

  //setters
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this._name = newName;

  //convert a Contact object to a Map object
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = this._id;
    map['number'] = this._number;
    map['name'] = this._name;

    return map;
  }

  //Extract a Contact Object from a Map object
  Contacts.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._number = map['number'];
    this._name = map['name'];
  }
}