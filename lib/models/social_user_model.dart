class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap()
  {
    return
    {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
    };
  }


}