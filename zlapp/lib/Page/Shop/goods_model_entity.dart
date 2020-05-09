class GoodsModelEntity {
	bool isproprietary;
	double price;
	String name;
	int id;
	String url;

	GoodsModelEntity({this.isproprietary, this.price, this.name, this.id, this.url});

	GoodsModelEntity.fromJson(Map<String, dynamic> json) {
		isproprietary = json['isproprietary'];
		price = json['price'];
		name = json['name'];
		id = json['id'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isproprietary'] = this.isproprietary;
		data['price'] = this.price;
		data['name'] = this.name;
		data['id'] = this.id;
		data['url'] = this.url;
		return data;
	}
}
