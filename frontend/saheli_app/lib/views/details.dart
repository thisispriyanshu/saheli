import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common/widgets/customBtn.dart';
import '../services/localDb/localDb.dart';
import '../widgets/bottomNavBar.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final List<String> gender = ['Female', 'Male'];
  String? dropDownValue1;
  String _gender = 'Female';
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  bool loading = false;
  DateTime selectedDate = DateTime.now();

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ListView(
        shrinkWrap: true,
        children: [Column(
          children: [
            SizedBox(
              width: 270,
              height: 270,
              child: SingleChildScrollView(

                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Enter Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Phone Number",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone number cannot be empty";
                            }
                            if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                                .hasMatch(value)) {
                              return ("Please enter a valid phone number");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                DropdownButton<String>(
                                  hint: Text("Female", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 25),),
                                  value: dropDownValue1,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                  items: gender
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: Colors.black, fontSize: 20),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      dropDownValue1 = item as String;
                                      _gender = item;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Age",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                TextFormField(
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.primary),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.primary),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Age cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.number,
                                ),
                                // InkWell(
                                //   onTap: () => _selectDate(context),
                                //   child: Container(
                                //     width: 200,
                                //     height: 100,
                                //     child: InputDecorator(
                                //       decoration: InputDecoration(
                                //         hintText: 'Select Date of Birth',
                                //         enabledBorder: OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //               color: Theme.of(context).colorScheme.primary),
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //         border: OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //               color: Theme.of(context).colorScheme.primary),
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //       ),
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: <Widget>[
                                //           Text(
                                //             "${selectedDate.toLocal()}"
                                //                 .split(' ')[0],
                                //             style: TextStyle(fontSize: 16, color: Colors.black),
                                //           ),
                                //           Icon(Icons.calendar_today_rounded, color: Theme.of(context).colorScheme.primary,),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        ),
                        CustomBtn(
                            msg: "Submit",
                            loading: loading,
                            color: Theme.of(context).colorScheme.primary,
                            onTap: () {
                              submit(
                                  phoneNumberController.text,
                                  _gender,
                                  ageController.text);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),],
      ),
    );
  }
  void submit(String mobile, String gender, String age) async {
    const CircularProgressIndicator();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
    if (_formkey.currentState!.validate()) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = _auth.currentUser;
      CollectionReference ref = firebaseFirestore.collection('users');
      ref
          .doc(user!.uid)
          .update({'mobile number': mobile, 'gender': gender, 'dob': age});
      await LocalDb.saveMobile(mobile);
      await LocalDb.saveGender(gender);
      await LocalDb.saveAge(age);
      Fluttertoast.showToast(
          msg: "Details Submitted", toastLength: Toast.LENGTH_SHORT);
    }
  }
}
