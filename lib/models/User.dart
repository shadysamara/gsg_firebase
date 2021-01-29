class User {
  String name;
  int age;
  bool isMale;
  Map familyMembers;
  List hobbies;
  User({this.age, this.familyMembers, this.hobbies, this.isMale, this.name});
  User.fromMap(Map map) {
    this.name = map['name'];
    this.age = map['age'];
    this.isMale = map['isMale'];
    this.familyMembers = map['family'];
    this.hobbies = map['hobbies'];
  }
  toJson() {
    return {
      'name': this.name,
      'age': this.age,
      'isMale': this.isMale,
      'hobbies': this.hobbies,
      'family': this.familyMembers
    };
  }
}
