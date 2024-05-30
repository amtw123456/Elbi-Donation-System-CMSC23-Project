import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'donation_icons_icons.dart';
import 'user_donation_type.dart';
import 'package:elbi_donation_app/functions/misc.dart';

import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class DonateGoodsPage extends StatefulWidget {
  String? organizationId;

  DonateGoodsPage({super.key, required this.organizationId});

  @override
  State<DonateGoodsPage> createState() => _DonateGoodsPageState();
}

class _DonateGoodsPageState extends State<DonateGoodsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _selectedDonationType = [];
  String? _selectedModeOfDelivery;
  double? _selectedWeight;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedAddress;
  int? _selectedContactNum;

  bool? dropOffSelected = false;

  String noTypeSelected = '';

  File? _selectedImage;

  XFile? file;
  String imageUrl = '';

  List<File> _selectedImageLists = [];
  List<String> selectedImagesUrlLists = [];

  final List<String> _addresses = [
    '123 Main St',
    '456 Oak Ave',
    '789 Pine Rd',
  ];

  final List<String> _modeOfDelivery = ['Drop off', 'Pick up'];

  // for loading
  bool _isLoading = false;

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

  Widget imageCarousel(List<File> _selectedImageLists) {
    return _selectedImageLists != []
        ? Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImageLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: _selectedImageLists[index] != null
                      ? Image.file(
                          File(_selectedImageLists[index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text('No image selected'),
                        ),
                );
              },
            ),
          )
        : Container(child: Text("red"));
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
                      style: const TextStyle(
                          fontFamily: 'Poppins', color: Colors.black),
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
                                    ? const Color(0XFFD2D2D2)
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
                                    ? const Color(0XFFD2D2D2)
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
                        style: const TextStyle(
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
                  //
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : ElevatedButton(
                            onPressed: () async {
                              if (await Permission.storage
                                  .request()
                                  .isGranted) {
                                // _pickImageFromGallery();
                                file = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                _selectedImageLists.add(File(file!.path));
                                String fileName = file!.path;
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();

                                Reference referenceDirImages =
                                    referenceRoot.child('images');

                                Reference referenceImageToUpload =
                                    referenceDirImages
                                        .child('$fileName.donationImages');

                                try {
                                  await referenceImageToUpload
                                      .putFile(File(file!.path));
                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                } catch (error) {}
                                selectedImagesUrlLists.add(imageUrl);
                                setState(() {});
                              } else {
                                // Permission is not granted. Handle the scenario accordingly.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text("storage Permission Required"),
                                      content: Text(
                                          "Please grant stroage permission in settings to enable storage access."),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text("CANCEL"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text("SETTINGS"),
                                          onPressed: () {
                                            openAppSettings(); // This will open the app settings where the user can enable permissions.
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the contents vertically
                                children: [
                                  Icon(Icons.photo_library,
                                      size: 40,
                                      color: Colors.grey[
                                          500]), // Adjust size and color as needed
                                  SizedBox(
                                      height:
                                          10), // Add some space between the icon and the text
                                  Text(
                                    "Upload Donation Photos",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 16,
                                        fontFamily:
                                            'Poppins'), // Adjust text style as needed
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.grey[50],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    color: const Color(0xFF37A980), width: 2),
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Color(0xFF37A980)),
                            SizedBox(width: 5),
                            Text(
                              'Open Camera & Take Photo',
                              style: TextStyle(
                                  color: Color(0xFF37A980),
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            file = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            _selectedImageLists.add(File(file!.path));
                            String fileName = file!.path;
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();

                            Reference referenceDirImages =
                                referenceRoot.child('images');

                            Reference referenceImageToUpload =
                                referenceDirImages
                                    .child('$fileName.donationImages');

                            try {
                              await referenceImageToUpload
                                  .putFile(File(file!.path));
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                            } catch (error) {}
                            selectedImagesUrlLists.add(imageUrl);
                            setState(() {});
                          } else {
                            // Permission is not granted. Handle the scenario accordingly.
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Camera Permission Required"),
                                  content: Text(
                                      "Please grant camera permission in settings to enable camera access."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("CANCEL"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text("SETTINGS"),
                                      onPressed: () {
                                        openAppSettings(); // This will open the app settings where the user can enable permissions.
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.green[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      )),

                  const SizedBox(height: 10),

                  imageCarousel(_selectedImageLists),

                  const SizedBox(height: 10),

                  // file != null
                  //     ? Image.file(File(file!.path))
                  //     : Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text("Please select an image",
                  //               style: TextStyle(
                  //                   fontFamily: 'Poppins', color: Colors.red))
                  //         ],
                  //       ),
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
                          try {
                            setState(() {
                              _isLoading = true;
                            });

                            String? donationId = generateRandomString(28);
                            DonationModel donationDetails = DonationModel(
                                categories: _selectedDonationType,
                                isPickupOrDropoff: _selectedModeOfDelivery,
                                id: donationId,
                                donatorId: userId,
                                contactNo: _selectedContactNum.toString(),
                                organizationId: widget.organizationId,
                                weight: _selectedWeight,
                                pickupAddresses: _addresses,
                                imagesOfDonationsList: selectedImagesUrlLists,
                                dateTime: DateFormat('dd/MM/yyyy').parse(
                                    DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate!)),
                                status: 'Pending');
                            Map<String, dynamic> result;

                            result = await context
                                .read<DonorProvider>()
                                .addDonationModel(donationDetails);

                            if (!result['success']) {
                              throw result['error'];
                            }

                            if (context.mounted) {
                              result = await context
                                  .read<UserProvider>()
                                  .updateUserModel(userId!, {
                                'donationsList':
                                    FieldValue.arrayUnion([donationId]),
                              });

                              if (!result['success']) {
                                throw result['error'];
                              }
                            }

                            if (context.mounted) {
                              result = await context
                                  .read<UserProvider>()
                                  .updateUserModel(widget.organizationId!, {
                                'donationsList':
                                    FieldValue.arrayUnion([donationId]),
                              });
                              if (!result['success']) {
                                throw result['error'];
                              }
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Donation added successfully!'),
                                backgroundColor: Colors.green,
                              ));
                            }

                            if (context.mounted) {
                              Navigator.pop(context);
                            }

                            setState(() {
                              _isLoading = false;
                            });
                          } catch (error) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error.toString()),
                                backgroundColor: Colors.red,
                              ));
                            }

                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: _isLoading
                          ? Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(4),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Confirm',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "Poppins")),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
