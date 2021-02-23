class Follow {
    String userid;
  Follow({this.userid});

  factory Follow.fromJson(Map<String, String> json) {
    return Follow(userid: json["userid"]);
  }

   Map<String, dynamic> toMap() {
    return {
    "userid":userid
    };
  }
}