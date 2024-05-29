import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'donation_icons_icons.dart';
import 'user_donation_type.dart';
import 'package:elbi_donation_app/functions/misc.dart';

import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:provider/provider.dart';

class DonateGoodsPage extends StatefulWidget {
  const DonateGoodsPage({super.key});

  @override
  State<DonateGoodsPage> createState() => _DonateGoodsPageState();
}

class _DonateGoodsPageState extends State<DonateGoodsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _selectedDonationType = [];
  String? _selectedModeOfDelivery;
  double? _selectedWeight;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedAddress;
  int? _selectedContactNum;

  bool? dropOffSelected = false;

  String noTypeSelected = '';

  final List<String> _addresses = [
    '123 Main St',
    '456 Oak Ave',
    '789 Pine Rd',
  ];

  final List<String> _modeOfDelivery = ['Drop off', 'Pick up'];

  void _onDonationTypeSelected(String donationType) {
    setState(() {
      _selectedDonationType.add(donationType);
    });
  }

  void _onDonationTypeRemoved(String donationType) {
    setState(() {
      _selectedDonationType.remove(donationType);
    });
  }

  void _onModeOfDeliverySelected(String modeOfDelivery) {
    setState(() {
      _selectedModeOfDelivery = modeOfDelivery;
      if (modeOfDelivery == 'Drop off') {
        dropOffSelected = true;
        _selectedAddress = null;
        _selectedContactNum = null;
      } else {
        dropOffSelected = false;
      }
    });
  }

  void _updateDonationWeight(String weight) {
    setState(() {
      _selectedWeight = double.tryParse(weight);
    });
  }

  void _onContactNumSelected(String number) {
    setState(() {
      _selectedContactNum = int.tryParse(number);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    ))!;
    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ))!;
    if (picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // This will format the time as AM/PM
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select your donation type.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
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
                  Text(
                    noTypeSelected,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  const SizedBox(height: 20),
                  const Text('Mode of delivery'),
                  const SizedBox(height: 10),
                  // MODE OF DELIVERY
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      hintText: 'Mode of delivery',
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: Color(0XFFD2D2D2)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    value: _selectedModeOfDelivery,
                    onChanged: (String? newValue) {
                      setState(() {
                        _onModeOfDeliverySelected(newValue!);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a mode of delivery';
                      }
                      return null;
                    },
                    items: _modeOfDelivery.map((String modeOfDelivery) {
                      return DropdownMenuItem<String>(
                        value: modeOfDelivery,
                        child: Text(modeOfDelivery,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal)),
                      );
                    }).toList(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the weight';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Donation weight',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: Color(0XFFD2D2D2)),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      onChanged: _updateDonationWeight,
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
                          validator: (value) {
                            if (_selectedDate == null) {
                              return 'Please choose a date';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: _selectedDate == null
                                ? 'Select Date'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                color: _selectedDate == null
                                    ? Color(0XFFD2D2D2)
                                    : Colors.black),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => _selectTime(context),
                          validator: (value) {
                            if (_selectedTime == null) {
                              return 'Please choose a time';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: _selectedTime == null
                                ? 'Select Time'
                                : '${_selectedTime!.hour}:${_selectedTime!.minute}',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                color: _selectedTime == null
                                    ? Color(0XFFD2D2D2)
                                    : Colors.black),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // ADDRESS SELECTOR
                  Visibility(
                    visible: !dropOffSelected!,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Select Address',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: Color(0XFFD2D2D2)),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a mode of delivery';
                        }
                        return null;
                      },
                      items: _addresses.map((String address) {
                        return DropdownMenuItem<String>(
                          value: address,
                          child: Text(address,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  ),
                  // CONTACT NUMBER
                  Visibility(
                    visible: !dropOffSelected!,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a contact number';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter a valid number';
                          }
                          if (value.length != 11) {
                            return 'Contact number must be 10 digits long';
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Contact number',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: Color(0XFFD2D2D2)),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        onChanged: _onContactNumSelected,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // SUBMIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: const Color(0xFF37A980),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () async {
                        if (_selectedDonationType.isEmpty) {
                          setState(() {
                            noTypeSelected = 'Please choose a donation type';
                          });
                        } else {
                          setState(() {
                            noTypeSelected = '';
                          });
                        }
                        if (_formKey.currentState!.validate()) {
                          print(_selectedDonationType);
                          print(_selectedModeOfDelivery);
                          print(_selectedWeight);
                          print(
                              DateFormat('dd/MM/yyyy').format(_selectedDate!));
                          print(formatTimeOfDay(_selectedTime!));
                          print(_selectedAddress);
                          print(_selectedContactNum);
                        }

                        // Map<String, dynamic> donationDetails = {
                        //   'donationTypes': _selectedDonationType,
                        //   'modeOfDelivery': _selectedModeOfDelivery,
                        //   'donationWeight': _selectedWeight,
                        //   'date':
                        //       DateFormat('dd/MM/yyyy').format(_selectedDate!),
                        //   'time': formatTimeOfDay(_selectedTime!),
                        //   'address': _selectedAddress,
                        //   'contactNumber': _selectedContactNum
                        // };
                        String? donationId = generateRandomString(28);
                        DonationModel donationDetails = DonationModel(
                          categories: _selectedDonationType,
                          id: donationId,
                          donatorId: userId,
                          contactNo: _selectedContactNum.toString(),
                          organizationId: null,
                          weight: _selectedWeight,
                          pickupAddresses: _addresses,
                          dateTime: DateFormat('dd/MM/yyyy').parse(
                              DateFormat('dd/MM/yyyy').format(_selectedDate!)),
                        );

                        await context
                            .read<DonorProvider>()
                            .addDonationModel(donationDetails);
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
