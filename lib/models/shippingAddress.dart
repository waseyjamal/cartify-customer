class ShippingAddress {
  final String name;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zip;

  ShippingAddress({
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
  });

  // model to Map 
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
    };
  }
}