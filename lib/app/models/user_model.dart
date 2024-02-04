class UserModel {
  String id;
  String uid;
  String name;
  String email;
  String password;
  String typeUser;

  UserModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.typeUser,
  });

  // when get data from dataBase
  factory UserModel.fromJson(json) {
    var data;

    if(Map<String,dynamic>().runtimeType!=json.runtimeType)
      data=json.data();
    else
      data=json;
    return UserModel(
      id: json['id'],
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      typeUser: json["typeUser"],

    );
  }


  // when post (send) data to dataBase
  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'name': name,
    'email': email,
    'password': password,
    'typeUser': typeUser,
  };

  factory UserModel.init(){
    return UserModel(id: "", uid: '', name: '', email: '', password: '', typeUser: '');
  }

}


//UserModels
class UserModels {
  List<UserModel> userModels;

  //DateTime date;

  UserModels({required this.userModels});

  factory UserModels.fromJson(json) {
    List<UserModel> tempUserModels = [];

    for (int i = 0; i < json.length; i++) {
      UserModel tempUserModel = UserModel.fromJson(json[i]);
      tempUserModel.id = json[i].id;
      tempUserModels.add(tempUserModel);
    }
    return UserModels(userModels: tempUserModels);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUserModels = [];
    for (UserModel userModel in userModels) {
      tempUserModels.add(userModel.toJson());
    }
    return {
      'userModels': tempUserModels,
    };
  }


}
