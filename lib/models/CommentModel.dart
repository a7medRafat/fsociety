class CommentModel{

  String? name;
  String? dateTime;
  String? image;
  String? commentTxt;
  String? uId;

  CommentModel({
    this.name,
    this.dateTime,
    this.image,
    this.commentTxt,
    this.uId,
  });

  CommentModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    image = json['image'];
    dateTime = json['dateTime'];
    commentTxt = json['commentTxt'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'commentTxt':commentTxt,
      'uId':uId,
    };
  }

}