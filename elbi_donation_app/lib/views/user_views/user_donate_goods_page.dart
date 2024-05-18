import 'package:flutter/material.dart';
import 'donation_icons_icons.dart';
import 'user_donation_type.dart'; // Make sure to import the new widget

class DonateGoodsPage extends StatefulWidget {
  const DonateGoodsPage({super.key});

  @override
  State<DonateGoodsPage> createState() => _DonateGoodsPageState();
}

class _DonateGoodsPageState extends State<DonateGoodsPage> {
  String? _selectedDonationType;
  String? _selectedModeOfDelivery;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedAddress;

  final List<String> _addresses = [
    '123 Main St',
    '456 Oak Ave',
    '789 Pine Rd',
  ];

  final List<String> _modeOfDelivery = [
    'Drop off',
    'Pick up'
  ];


  void _onDonationTypeSelected(String donationType) {
    setState(() {
      _selectedDonationType = donationType;
    });
  }

  void _onModeOfDeliverySelected(String modeOfDelivery) {
    setState(() {
      _selectedModeOfDelivery = modeOfDelivery;
    });
  }

    Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2100),
    ))!;
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ))!;
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Donate Goods"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select your donation type.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DonationContainer(
                    iconData: DonationIcons.tshirt, 
                    label: 'Clothes',
                    onPressed: (selected) {
                      if (selected) _onDonationTypeSelected('Clothes');
                    },
                  ),
                  DonationContainer(
                    iconData: DonationIcons.food, 
                    label: 'Food',
                    onPressed: (selected) {
                      if (selected) _onDonationTypeSelected('Food');
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DonationContainer(
                    iconData: DonationIcons.mobile, 
                    label: 'Electronics',
                    onPressed: (selected) {
                      if (selected) _onDonationTypeSelected('Electronics');
                    },
                  ),
                  DonationContainer(
                    iconData: DonationIcons.money_bill_alt, 
                    label: 'Cash',
                    onPressed: (selected) {
                      if (selected) _onDonationTypeSelected('Cash');
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DonationContainer(
                    iconData: DonationIcons.bed, 
                    label: 'Furniture',
                    onPressed: (selected) {
                      if (selected) _onDonationTypeSelected('Furniture');
                    },
                  ),
                  DonationContainer(
                    iconData: DonationIcons.dot_3, 
                    label: 'Others',
                    onPressed: (selected) {
                      if (selected) _onDonationTypeSelected('Others');
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Mode of delivery'),
              SizedBox(height: 10),
// MODE OF DELIVERY
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Mode of delivery',
                hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              value: _selectedModeOfDelivery,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedModeOfDelivery = newValue;
                });
              },
              items: _modeOfDelivery.map((String modeOfDelivery) {
                return DropdownMenuItem<String>(
                  value: modeOfDelivery,
                  child: Text(modeOfDelivery, style: TextStyle(fontFamily: 'Poppins')),
                );
              }).toList(),
            ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Donation weight',
                    hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ), 
                  ),
                ),
              ),
// DATE AND TIME SELECTOR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: _selectedDate == null
                            ? 'Select Date'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      decoration: InputDecoration(
                        hintText: _selectedTime == null
                            ? 'Select Time'
                            : '${_selectedTime!.hour}:${_selectedTime!.minute}',
                        hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
// ADDRESS SELECTOR
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Select Address',
                  hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                value: _selectedAddress,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAddress = newValue;
                  });
                },
                items: _addresses.map((String address) {
                  return DropdownMenuItem<String>(
                    value: address,
                    child: Text(address, style: TextStyle(fontFamily: 'Poppins')),
                  );
                }).toList(),
              ),
// CONTACT NUMBER
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Contact number',
                    hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ), 
                  ),
                ),
              ),
              SizedBox(height: 16.0),
// SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    backgroundColor: Color(0xFF37A980),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}