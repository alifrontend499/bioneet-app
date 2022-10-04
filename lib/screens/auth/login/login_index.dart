import 'package:flutter/material.dart';

// screen styles
import 'package:app/screens/auth/login/styles/screenStyles.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldPhoneNumber = '';


  // submit form
  void onSubmit() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(top: 35, bottom: 15, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // child | scroll view
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // child | header
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login with mobile number',
                              style: stylesPageHeaderHeading,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 8),

                            Text(
                              'Please enter your mobile number and we will send an OTP for verification',
                              style: stylesPageHeaderDescription,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // child | form
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              buildPhoneNumberField()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // child | buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: onSubmit,
                      style: stylesSubmitBtn,
                      child: const Text('GET OTP'),
                    ),
                  ],
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  // field: phone
  Widget buildPhoneNumberField() => TextFormField(
    keyboardType: TextInputType.number,
    style: stylesInput,
    decoration: InputDecoration(
      hintText: "Enter Phone Number",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.red, width: 3.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      errorStyle: stylesInputError,
    ),
    onSaved: (value) => setState(() => fieldPhoneNumber = value!),
    validator: (value) {
      const phonePattern = r"^[0-9]{10}$";
      final regExpEmail = RegExp(phonePattern);

      if (value!.isEmpty) {
        // checking for empty value
        return "The field can not be empty";
      } else if (!regExpEmail.hasMatch(value)) {
        // checking for valid email
        return "Phone number should be valid";
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );
}
