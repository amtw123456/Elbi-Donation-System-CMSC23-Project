import 'package:elbi_donation_app/views/org_views/org_home_page.dart';
import 'package:elbi_donation_app/views/user_views/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({super.key});

  @override
  _SignUpDonorPageState createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  // for showing if it's going to be an organization
  bool _isOrganization = false;

  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    passwordController.dispose();
    organizationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Help us get to know you',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const Text('Create your account so you can start donating.'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Personal',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: firstNameController,
                      validator: ValidationBuilder().build(),
                      decoration: const InputDecoration(
                        hintText: 'First name',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: lastNameController,
                      validator: ValidationBuilder().build(),
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: usernameController,
                      validator: ValidationBuilder().build(),
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: emailController,
                      validator: ValidationBuilder().email().build(),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: addressController,
                      validator: ValidationBuilder().build(),
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: contactNumberController,
                      validator: ValidationBuilder().build(),
                      decoration: const InputDecoration(
                        hintText: 'Contact number',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: ValidationBuilder().minLength(8).build(),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('Want to sign up as an organization?'),
                    value: _isOrganization,
                    onChanged: (bool? value) {
                      setState(() {
                        _isOrganization = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (_isOrganization) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        controller: organizationNameController,
                        validator: ValidationBuilder().build(),
                        decoration: const InputDecoration(
                          hintText: 'Organization name',
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Please provide a proof of legitimacy',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    IconButton.outlined(
                        onPressed: () {}, icon: const Icon(Icons.add)),
                    const SizedBox(height: 20),
                  ],
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: const Color(0xFF37A980),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              )),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                Map<String, dynamic> result;
                                result = await context
                                    .read<UserAuthProvider>()
                                    .signUp(emailController.text,
                                        passwordController.text);

                                if (!result['success']) {
                                  throw result['error'];
                                }

                                String id = result['uid'];
                                UserModel userModel = UserModel(
                                    id: id,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    username: usernameController.text,
                                    orgName: organizationNameController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    contactNumber: contactNumberController.text,
                                    type: _isOrganization ? "org" : "donor",
                                    isApprovedByAdmin:
                                        _isOrganization ? false : null);

                                if (context.mounted) {
                                  result = await context
                                      .read<UserProvider>()
                                      .addUserModel(userModel);
                                }

                                if (!result['success']) {
                                  throw result['error'];
                                }

                                // route depending on the user type
                                if (context.mounted) {
                                  if (userModel.type == 'org') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrgHomePage()));
                                  } else if (userModel.type == 'donor') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserHomePage()));
                                  } else {
                                    throw 'Error: User type inconsistency, cannot route.';
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(e.toString()),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Poppins"),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
