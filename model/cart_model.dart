final columnId = '_id';
final columnName = 'Name';
final columnProductDetails = 'Productdetails';
final columnImage = 'image';
final columnPrice = 'price';
final columnProductId = 'productId';
final columnVariant = 'variant';
final columnVariantType = 'variantType';
final columnQuantity = 'quantity';

class CartModel {
  int id;
  String title;

  String image;
  double price;
  int productId;
  int variant;
  String variantType;
  int quantity;

  CartModel(this.title, this.image, this.price, this.productId, this.variant,this.variantType,
      this.quantity);

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columnName: title,
      columnImage: image,
      columnPrice: price,
      columnProductId: productId,
      columnVariant: variant,
      columnVariantType:variantType,
      columnQuantity: quantity
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  CartModel.fromMap(Map<String, Object> map) {
    id = map[columnId];
    title = map[columnName];

    image = map[columnImage];
    price = map[columnPrice];
    productId = map[columnProductId];
    variant = map[columnVariant];
    variantType = map[columnVariantType];
    quantity = map[columnQuantity];
  }
}
