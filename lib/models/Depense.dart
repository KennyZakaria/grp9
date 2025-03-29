class Depense {
  String name;
  String paidBy;
  String price;

  Depense({required this.name, required this.paidBy, required this.price});
  Map<String, dynamic> toJson() {
    return {'name': name, 'paidBy': paidBy, 'price': price};
  }
}
