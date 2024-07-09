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
    PizaaModel({
      this.name,
      this.description,
      this.discount,
      this.picture,
      this.isVeg,
      this.spicy,
      this.price,
      this.macros

});
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

    Map<String,dynamic> toMap(){
      return {
        'description':description,
        'discount':discount,
        'isVeg':isVeg,
        'name':name,
        'picture':picture,
        'pizzaId':pizzaId,
        'price':price,
        'spicy':spicy,
        'macros':{
          'calories':macros!.calories,
          'carbs':macros!.carbs,
          'fat':macros!.fat,
          'protien':macros!.protien
        }
      };
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