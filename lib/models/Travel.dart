class Travel {
  String city;
  String date;
  String price;
  List<String> participants;

  Travel({
    required this.city,
    required this.date,
    required this.price,
    required this.participants,
  });
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'date': date,
      'price': price,
      'participants': participants,
    };
  }
}
