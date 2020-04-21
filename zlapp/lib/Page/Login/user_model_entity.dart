class UserModelEntity {
	String password;
	String publicName;
	List<Null> chapterTops;
	String icon;
	String nickname;
	bool admin;
	List<Null> collectIds;
	int id;
	int type;
	String email;
	String token;
	String username;

	UserModelEntity({this.password, this.publicName, this.chapterTops, this.icon, this.nickname, this.admin, this.collectIds, this.id, this.type, this.email, this.token, this.username});

	UserModelEntity.fromJson(Map<dynamic, dynamic> json) {
		password = json['password'];
		publicName = json['publicName'];
		if (json['chapterTops'] != null) {
			chapterTops = new List<Null>();
		}
		icon = json['icon'];
		nickname = json['nickname'];
		admin = json['admin'];
		if (json['collectIds'] != null) {
			collectIds = new List<Null>();
		}
		id = json['id'];
		type = json['type'];
		email = json['email'];
		token = json['token'];
		username = json['username'];
	}

	Map<dynamic, dynamic> toJson() {
		final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
		data['password'] = this.password;
		data['publicName'] = this.publicName;
		if (this.chapterTops != null) {
      data['chapterTops'] =  [];
    }
		data['icon'] = this.icon;
		data['nickname'] = this.nickname;
		data['admin'] = this.admin;
		if (this.collectIds != null) {
      data['collectIds'] =  [];
    }
		data['id'] = this.id;
		data['type'] = this.type;
		data['email'] = this.email;
		data['token'] = this.token;
		data['username'] = this.username;
		return data;
	}
}
