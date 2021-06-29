class AccountProfileDetail {
  AccountProfileDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.customerType,
    this.gender,
    this.district,
    this.city,
    this.address,
    this.contactNumber,
    this.billingAddress,
    this.shippingAddress,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String customerType;
  String gender;
  int district;
  String city;
  String address;
  String contactNumber;
  String billingAddress;
  String shippingAddress;

  factory AccountProfileDetail.fromJson(Map<String, dynamic> json) {
    return AccountProfileDetail(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        customerType: json["customer_type"],
        gender: json["gender"],
        district: json["district"],
        city: json["city"],
        address: json["address"],
        contactNumber: json["contact_no"],
        billingAddress: json["billing_addr"],
        shippingAddress: json["shipping_addr"]);
  }

  static List<AccountProfileDetail> mapArray(List<dynamic> data) {
    return data.map((json) => AccountProfileDetail.fromJson(json)).toList();
  }
}
