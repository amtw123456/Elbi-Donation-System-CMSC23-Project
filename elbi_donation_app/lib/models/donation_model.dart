class DonationModel {
  String? id;
  String? donatorId;
  // which organization would it be sent to
  String? organizationId;
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
  // pending, confirmed, scheduled(scheduled for pick up), complete, or canceled
  String? status;

  DonationModel(
      {this.id,
      this.donatorId,
      this.organizationId,
      this.categories,
      this.isPickupOrDropoff,
      this.weight,
      this.dateTime,
      this.pickupAddresses,
      this.contactNo,
      this.isCancelled = false,
      this.status});

  // Factory constructor to instantiate object from json format
  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      donatorId: json['donatorId'],
      organizationId: json['organizationId'],
      categories: json['categories'],
      isPickupOrDropoff: json['isPickupOrDropoff'],
      weight: json['weight'],
      dateTime: json['dateTime'],
      pickupAddresses: json['pickupAddresses'],
      contactNo: json['contactNo'],
      isCancelled: json['isCancelled'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson(DonationModel donationModel) {
    return {
      'id': donationModel.id,
      'donatorId': donationModel.donatorId,
      'organizationId': donationModel.organizationId,
      'categories': donationModel.categories,
      'isPickupOrDropoff': donationModel.isPickupOrDropoff,
      'weight': donationModel.weight,
      'dateTime': donationModel.dateTime,
      'pickupAddresses': donationModel.pickupAddresses,
      'contactNo': donationModel.contactNo,
      'isCancelled': donationModel.isCancelled,
      'status': donationModel.status
    };
  }
}
