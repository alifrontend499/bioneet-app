import 'package:flutter/material.dart';

// routes
import 'package:app/utilities/routing/routing_consts.dart';

// screen styles
import 'package:app/screens/auth/login/styles/screenStyles.dart';

// package | firebase auth
import 'package:firebase_auth/firebase_auth.dart';

// screens
import 'package:app/screens/auth/login/screens/otp/otp_index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldPhoneNumber = '';
  bool buttonLoading = false;


  // submit form
  void onSubmit() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      // loading
      setState(() => buttonLoading = true);
      // blur the input focus
      FocusManager.instance.primaryFocus?.unfocus();

      // otp process
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 $fieldPhoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {
          // loading
          setState(() => buttonLoading = false);

          // showing message
          print('Firebase | verification completed!!');
        },
        verificationFailed: (FirebaseAuthException e) {
          // loading
          setState(() => buttonLoading = false);

          // showing message
          final snackBar = SnackBar(
            content: Text('Verification failed!! please try again ${e.code}'),
            backgroundColor: Colors.redAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? resendToken) {
          // loading
          setState(() => buttonLoading = false);

          // showing message
          const snackBar = SnackBar(
            content: Text('code sent successfully'),
            backgroundColor: Colors.greenAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // navigation to otp page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPScreen(
              verificationId: verificationId,
              phoneNumber: fieldPhoneNumber
            ))
          );

        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // loading
          setState(() {
            buttonLoading = false;
          });
        },
      );

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
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: !buttonLoading ? onSubmit : () {},
                        style: stylesSubmitBtn,
                        child: buttonLoading ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ) : const Text('GET OTP')
                      ),
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
