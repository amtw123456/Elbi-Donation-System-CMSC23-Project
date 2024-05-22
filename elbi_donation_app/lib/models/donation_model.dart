class DonationModel {
  String? id;
  String? donatorId;
  // could be 'Food', 'Clothes', 'Cash', 'Necessities', or others
  List<String>? categories;
  // string that could be a pickup or dropoff
  String? isPickupOrDropoff;
  // weight of the items
  double? weight;
  // TODO: photo of the items (later)
  // date time for pickup or dropoff
  DateTime? dateTime;
  // addresses for pickup
  List<String>? pickupAddresses;
  // contact number for pickup
  String? contactNo;
  // donations could be cancelled
  bool? isCancelled;

  DonationModel(
      {this.id,
      this.donatorId,
      this.categories,
      this.isPickupOrDropoff,
      this.weight,
      this.dateTime,
      this.pickupAddresses,
      this.contactNo,
      this.isCancelled = false});

  // Factory constructor to instantiate object from json format
  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      donatorId: json['donatorId'],
      categories: json['categories'],
      isPickupOrDropoff: json['isPickupOrDropoff'],
      weight: json['weight'],
      dateTime: json['dateTime'],
      pickupAddresses: json['pickupAddresses'],
      contactNo: json['contactNo'],
      isCancelled: json['isCancelled'],
    );
  }
}
