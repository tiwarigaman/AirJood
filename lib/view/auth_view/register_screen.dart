import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../res/components/color.dart';
import '../../res/components/datebutton.dart';
import '../../res/components/dropdownbutton.dart';
import '../../res/components/mainbutton.dart';
import '../../res/components/maintextfild.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  final String? mobile;
  const RegisterScreen({super.key, this.mobile});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
      });
    }
  }

  String? formattedDate;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
              weight: 2,
            ),
          ),
          const Spacer(),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 15, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: GoogleFonts.nunito(
                color: AppColors.splashTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Enter your details below',
              style: GoogleFonts.nunito(
                color: AppColors.greyTextColor,
                fontSize: 16,
                //fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MainTextFild(
              controller: nameController,
              labelText: 'Enter your full name *',
              prefixIcon: const Icon(
                CupertinoIcons.person,
                color: AppColors.textFildHintColor,
                weight: 5,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            MainTextFild(
              controller: emailController,
              labelText: 'Enter your email address',
              prefixIcon: const Icon(
                CupertinoIcons.envelope,
                color: AppColors.textFildHintColor,
                weight: 5,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomDropdownButton(
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value as String?;
                    });
                  },
                  value: selectedItem,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: DateButton(
                  data: 'Select DOB',
                  onTap: () {
                    _selectDate(context);
                  },
                  formattedDate: formattedDate,
                )),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (nameController.text.isEmpty) {
                  Utils.toastMessage('Please enter full name');
                } else if (emailController.text.isEmpty ||
                    !EmailValidator.validate(emailController.text)) {
                  Utils.toastMessage('please enter valid email !');
                } else if (selectedItem == null) {
                  Utils.toastMessage('Please select Gender');
                } else if (formattedDate == null) {
                  Utils.toastMessage('Please select BOD');
                } else {
                  Map<String, String> data = {
                    'name': nameController.text.toString(),
                    'email': emailController.text.toString(),
                    "contact_no": "${widget.mobile}",
                    "gender": "$selectedItem",
                    "dob": "$formattedDate"
                  };
                  authViewModel.registerApi(data, context);
                }
                // Navigator.pushNamed(context, RoutesName.navigation);
              },
              child: Center(
                child: MainButton(
                  loading: authViewModel.RegisterLoading,
                  data: 'Let’s Explore',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
