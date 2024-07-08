class LoginModel{
  String ?name;
  String ?email;
  String ?uid;
  String ?phone;

  LoginModel({
    this.name,
    this.phone,
    this.uid,
    this.email
});

  LoginModel.fromJosn(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uid=json['uid'];

  }

  Map<String,dynamic> toMap(){
    return {
    'name':name,
    'email':email,
    'phone':phone,
    'uid':uid
    };
  }
}