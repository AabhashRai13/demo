import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) => UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
    UpdateProfile({
        this.firstName,
        this.lastName,
        this.gender,
        this.shippingAddr,
        this.billingAddr,
        this.contactNo,
        this.city,
        this.address,
    });

    String firstName;
    String lastName;
    String gender;
    String shippingAddr;
    String billingAddr;
    String contactNo;
    String city;
    String address;

    factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        shippingAddr: json["shipping_addr"],
        billingAddr: json["billing_addr"],
        contactNo: json["contact_no"],
        city: json["city"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "shipping_addr": shippingAddr,
        "billing_addr": billingAddr,
        "contact_no": contactNo,
        "city": city,
        "address": address,
    };
}
