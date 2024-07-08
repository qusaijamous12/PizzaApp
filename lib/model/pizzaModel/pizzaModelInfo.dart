class PizaaModel{
    dynamic ?description;
    dynamic discount;
    dynamic ?isVeg;
    Macros ?macros;
    dynamic ?name;
    dynamic ?picture;
    dynamic ?pizzaId;
    dynamic price;
    dynamic ?spicy;
    PizaaModel.fromJosn(Map<String,dynamic> json){
      description=json['description'];
      discount=json['discount'];
      isVeg=json['isVeg'];
      macros=Macros.fromJson(json['macros']);
      name=json['name'];
      picture=json['picture'];
      pizzaId=json['pizzaId'];
      price=json['price'];
      spicy=json['spicy'];
    }


}
class Macros{
  dynamic ?calories;
  dynamic ?carbs;
  dynamic ?fat;
  dynamic ?protien;
  Macros.fromJson(Map<String,dynamic>json){
    calories=json['calories'];
    carbs=json['carbs'];
    fat=json['fat'];
    protien=json['protien'];
  }
}