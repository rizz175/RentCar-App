class carModel
{
  String? id;
  String? name;
  String? model;
  String? number;
  String? category;
  String? image;
  String? perday;
  String? status;


  carModel({
      this.id, this.name, this.model, this.number, this.category, this.image,this.perday,this.status});

  factory carModel.fromJson(Map<String, dynamic> json) => carModel(
    id: json["id"],
    name: json["name"],
    model: json["model"],
    number: json["cnumber"],
    category: json["category"],
    image: json["image"],
    perday: json["perday"],
    status:json['status']

  );


}