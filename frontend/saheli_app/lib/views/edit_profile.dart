import 'package:Saheli/widgets/custom_widgets/customTextFormField.dart';
import 'package:Saheli/widgets/custom_widgets/custom_appBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../common/utils/colors.dart';
import '../common/utils/utils.dart';
import '../common/widgets/customBtn.dart';
import '../services/auth/fireDb.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String userName = '';
  String userEmail = '';
  String photoUrl = '';
  String contactNumber = '';
  String gender = '';
  String age = '';
  bool _edit = false;
  bool updatingLogo = false;

  XFile? profileImage;
  String imageUrl = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String selectedGender = '';
  String dialCode = '+91';
  Widget countryFlag = Image.asset('lib/assets/images/indianFlag.png');
  final countryPicker = const FlCountryCodePicker();
  String warningMessage = '';
  bool enable = false;
  int _tabTextIndexSelected = 0;

  final List<String> _listTextTabToggle = ['Female', 'Male'];

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      Map<String, dynamic>? data = await FireDb().fetchUserDetails(user!.uid);
      if (data!.isNotEmpty) {
        setState(() {
          userName = data['name'];
          userEmail = data['email'];
          photoUrl = data['photoURL'];
          contactNumber = data['phone_number'];
          gender = data['gender'];
          age = data['age'];
          if(gender == 'Female') {
            _tabTextIndexSelected = 0;
          } else {
            _tabTextIndexSelected = 1;
          }
          selectedGender = gender;
        });
        print('User Display Name: $userName');
        print('User Email: $userEmail');
        print('User Photo URL: $photoUrl');
        print('User number: $contactNumber');
        print('User gender: $gender');
        print('User age: $age');
      } else {
        print('User is not signed in.');
      }
    } catch (e) {
      print('Error while fetching user data: $e');
    }
  }

  pickAndUploadImage() async {
    profileImage = await captureImage(ImageSource.gallery);
    if (profileImage != null) {
      setState(() {
        updatingLogo = true;
      });
      imageUrl = await uploadFileToStorage("image", profileImage);
      if (imageUrl == null || imageUrl.isEmpty) {
        debugPrint('Image upload failed \nReason: Image url is null');
        showSnackBar(
          context,
          "Image upload failed \nReason: Image url is null",
          failureColor,
        );
      } else {
        debugPrint("image url: $imageUrl");
        showSnackBar(
          context,
          "Profile photo updated",
          successColor,
        );
        setState(() {
          photoUrl = imageUrl;
          updatingLogo = false;
        });
      }
    }
  }

  void _checkNumber(String value) {
    if(value.isEmpty) return;
    if (value.length == 10) {
      setState(() {
        warningMessage = 'The number has now reached 10 digits';
        if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && ageController.text.isNotEmpty){
          enable = true;
        }
      });
    } else if(value.length > 0 && value.length <10) {
      setState(() {
        warningMessage = 'The number should be exactly 10 digits';
        enable = false;
      });
    }
  }

  updateDetails() async {
    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      User user = _auth.currentUser!;
      final userDoc = _firestore.collection('users').doc(user.uid);
      await userDoc.update({
        'name': nameController.text,
        'email': emailController.text,
        'age': ageController.text,
        'gender': selectedGender,
        'phone_number': dialCode+contactController.text,
        'photoURL': photoUrl
      });
      showSnackBar(context, 'Profile Updated successfully', successColor);
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(context, 'e', failureColor);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details', style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600, fontSize: 24),),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: !updatingLogo ? CachedNetworkImage(
                          imageUrl: photoUrl.isNotEmpty
                              ? photoUrl
                              : 'https://coenterprises.com.au/wp-content/uploads/2018/02/male-placeholder-image.jpeg',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ) : const Center(child: CircularProgressIndicator(),)),
                    Positioned(
                        bottom: 2,
                        right: 2,
                        child: InkWell(
                          onTap: () async {
                            await pickAndUploadImage();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )),
                        )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    CustomTextFormField(hint: userName, controller: nameController, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 5,),
                    Text(
                      "Email",
                      style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    CustomTextFormField(hint: userEmail, controller: emailController, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 5,),
                    Text(
                      "Age",
                      style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                    CustomTextFormField(hint: age, controller: ageController, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 5,),
                    Text(
                      "Contact Number",
                      style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500),
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
                            });
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
                              hintText: contactNumber,
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
                          selectedGender = _listTextTabToggle[index];
                        });
                      },
                      isScroll: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomBtn(
                    msg: 'Save',
                    textColor: Colors.white,
                    color: enable ? Theme.of(context).colorScheme.primary : inactive,
                    onTap: enable ? () async {
                      await updateDetails();
                    } : () {}),
              )
            ]
          ),
        ),
      ),
    );
  }
}
