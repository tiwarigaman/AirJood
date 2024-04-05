class AddonData {
  String name;
  String description;
  String latqaId;
  String laqtaImage;
  String priceType;
  String price;

  AddonData({
    required this.name,
    required this.description,
    required this.latqaId,
    required this.laqtaImage,
    required this.priceType,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddonData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          latqaId == other.latqaId &&
          laqtaImage == other.laqtaImage &&
          priceType == other.priceType &&
          price == other.price;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      latqaId.hashCode ^
      laqtaImage.hashCode ^
      priceType.hashCode ^
      price.hashCode;

  @override
  String toString() {
    return 'FormData{name: $name, description: $description, latqaId: $latqaId, laqtaImage : $laqtaImage,priceType: $priceType, price: $price}';
  }
}
