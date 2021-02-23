class Users {
  String name;
  String surname;
  String username;
  String email;
  String password;
  String profilePhotoUrl;
  String description;
  int posts;
  int followers;
  int following;
  String phone_number;

  var timestamp;
  String userId;

  Users(
      {this.description,
      this.email,
      this.followers,
      this.following,
      this.name,
      this.password,
      this.phone_number,
      this.posts,
      this.profilePhotoUrl,
      this.surname,
      this.timestamp,
      this.userId,
      this.username});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        description: json["description"],
        email: json["email"],
        followers: json['followers'],
        following: json['following'],
        name: json['name'],
        password: json['password'],
        phone_number: json['phone_number'],
        posts: json['posts'],
        profilePhotoUrl: json['profilePhotoUrl'],
        surname: json['surname'],
        timestamp: json['timestamp'],
        userId: json['userId'],
        username: json['username']);
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'userId': userId,
      'timestamp': timestamp,
      'username': username,
      'profilePhotoUrl': profilePhotoUrl,
      'following': following,
      'followers': followers,
      'phone_number': phone_number,
      'posts': posts,
      'password': password,
      'email': email
    };
  }
}
