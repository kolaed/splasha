

class CarWashModel {

  String specifications = '';
  String washType ='';
  int priceSUV = 0;
  int priceSedan=0;


  CarWashModel(this.specifications,this.washType,this.priceSedan,this.priceSUV);

 CarWashModel.fromJson(Map<String, dynamic> json) {
    specifications = json['specifications'];
    washType = json['washType'];
    priceSUV = json['priceSUV'];
    priceSedan = json['priceSedan'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specifications'] = this.specifications;
    data['washType'] = this.washType;
    data['priceSUV'] = this.priceSUV;
    data['priceSedan'] = this.priceSedan;

    return data;
  }
}