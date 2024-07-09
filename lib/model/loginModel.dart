class LoginModel{
  String ?name;
  String ?email;
  String ?uid;
  String ?phone;
  String ?image;
  String ?status;

  LoginModel({
    this.name,
    this.phone,
    this.uid,
    this.email,
    this.image='https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png',
    this.status='user'
}
);

  LoginModel.fromJosn(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uid=json['uid'];
    image=json['image'];
    status=json['status'];

  }

  Map<String,dynamic> toMap(){
    return {
    'name':name,
    'email':email,
    'phone':phone,
    'uid':uid,
      'image':image,
      'status':status
    };
  }
}