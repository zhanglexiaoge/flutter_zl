class HomeGirderModelEntity {
	String name;
	int id;
	String url;

	HomeGirderModelEntity({this.name, this.id, this.url});

	HomeGirderModelEntity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		data['url'] = this.url;
		return data;
	}
}
