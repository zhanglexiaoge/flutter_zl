class CalssifcationModelEntity {
	String name;
	int id;
	List<CalssifcationModelRightgirder> rightGirder;

	CalssifcationModelEntity({this.name, this.id, this.rightGirder});

	CalssifcationModelEntity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
		if (json['rightGirder'] != null) {
			rightGirder = new List<CalssifcationModelRightgirder>();(json['rightGirder'] as List).forEach((v) { rightGirder.add(new CalssifcationModelRightgirder.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		if (this.rightGirder != null) {
      data['rightGirder'] =  this.rightGirder.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CalssifcationModelRightgirder {
	List<CalssifcationModelRightgirderMoudle> moudle;
	String title;

	CalssifcationModelRightgirder({this.moudle, this.title});

	CalssifcationModelRightgirder.fromJson(Map<String, dynamic> json) {
		if (json['moudle'] != null) {
			moudle = new List<CalssifcationModelRightgirderMoudle>();(json['moudle'] as List).forEach((v) { moudle.add(new CalssifcationModelRightgirderMoudle.fromJson(v)); });
		}
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.moudle != null) {
      data['moudle'] =  this.moudle.map((v) => v.toJson()).toList();
    }
		data['title'] = this.title;
		return data;
	}
}

class CalssifcationModelRightgirderMoudle {
	String name;
	int id;
	String url;

	CalssifcationModelRightgirderMoudle({this.name, this.id, this.url});

	CalssifcationModelRightgirderMoudle.fromJson(Map<String, dynamic> json) {
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
