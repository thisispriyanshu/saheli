import 'package:Saheli/common/utils/colors.dart';
import 'package:Saheli/common/widgets/customBtn.dart';
import 'package:Saheli/widgets/PrivacyPolicy.dart';
import 'package:Saheli/widgets/bottomNavBar.dart';
import 'package:Saheli/widgets/custom_widgets/customTextFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserDetails extends StatefulWidget {
  const AddUserDetails({super.key});

  @override
  State<AddUserDetails> createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  int _tabTextIndexSelected = 0;
  String genderSelected = 'Female';
  final List<String> _listTextTabToggle = ['Female', 'Male'];
  String warningMessage = '';
  String dialCode = '+91';
  Widget countryFlag = Image.asset('lib/assets/images/indianFlag.png');
  final countryPicker = const FlCountryCodePicker();
  bool checkboxValue = false;
  bool enable = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addDetails() async {
    User user = _auth.currentUser!;
    final userDoc = _firestore.collection('users').doc(user.uid);
    await userDoc.update({'age': ageController.text, 'gender': genderSelected, 'phone_number': dialCode+contactController.text});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
  }

  void _checkNumber(String value) {
    if(value.isEmpty) return;
    if (value.length == 10) {
      setState(() {
        warningMessage = 'The number has now reached 10 digits';
        if(ageController.text.isNotEmpty) enable = true;
      });
    } else if(value.length > 0 && value.length <10) {
      setState(() {
        warningMessage = 'The number should be exactly 10 digits';
        enable = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    ageController.dispose();
    contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Age",
                      style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTextFormField(
                      hint: 'Enter you current age',
                      controller: ageController,
                      isInputTypeString: false,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Contact Number",
                      style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final picked =
                            await countryPicker.showPicker(context: context);
                            setState(() {
                              if(picked!.dialCode.isNotEmpty) {
                                dialCode = picked.dialCode;
                                countryFlag = picked.flagImage(fit: BoxFit.cover, width: 25);
                              }
                              countryCodeController.text = dialCode;
                            });
                            debugPrint(countryCodeController.text);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  countryFlag,
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: contactController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone Number cannot be empty";
                              }
                              final cleanedValue = value.replaceAll(' ', '');
                              if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                                  .hasMatch(cleanedValue)) {
                                return ("Please enter a valid number");
                              } else {
                                return null;
                              }
                            },
                            enabled: true,
                            onChanged: (value) {
                              contactController.text = value;
                              _checkNumber(value);
                            },
                            style: GoogleFonts.poppins(),
                            maxLines: 1,
                            cursorColor: Theme.of(context).colorScheme.primary,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintText: 'Enter you contact number',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.20000000298023224),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      warningMessage,
                      style: GoogleFonts.poppins(
                        color: warningMessage == 'The number has now reached 10 digits'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FlutterToggleTab(
                      width: 90,
                      height: 50,
                      borderRadius: 50,
                      selectedIndex: _tabTextIndexSelected,
                      selectedBackgroundColors: [
                        Theme.of(context).colorScheme.primary,
                      ],
                      selectedTextStyle: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      unSelectedTextStyle: GoogleFonts.outfit(
                          color: const Color(0xFF898989),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      labels: _listTextTabToggle,
                      selectedLabelIndex: (index) {
                        setState(() {
                          _tabTextIndexSelected = index;
                          genderSelected = _listTextTabToggle[index];
                        });
                      },
                      isScroll: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFF3F72AF),
                          side:
                          const BorderSide(color: Color(0xFF3F72AF), width: 1),
                          value: checkboxValue,
                          onChanged: (value) {
                            setState(() {
                              checkboxValue = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Wrap(
                          runSpacing: 4.0,
                          children: [
                            Text('I agree to ',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF090909),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PrivacyPolicyPage()));
                              },
                              child: Text('Terms and Condition',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF3F72AF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            Text(' and ',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF090909),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PrivacyPolicyPage()));
                              },
                              child: Text('Privacy Policy',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF3F72AF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBtn(
                  msg: 'Save',
                  textColor: Colors.white,
                  color: enable ? Theme.of(context).colorScheme.primary : inactive,
                  onTap: enable ? () async {
                    await addDetails();
                  } : () {})
            ],
          ),
        ),
      ),
    );
  }
}
