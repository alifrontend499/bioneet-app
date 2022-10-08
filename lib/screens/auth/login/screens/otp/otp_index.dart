import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// routes
import 'package:app/utilities/routing/routing_consts.dart';

// screen styles
import 'package:app/screens/auth/login/styles/screenStyles.dart';

// package | firebase auth
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OTPScreen({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();
  bool buttonLoading = false;
  String otpCode = '';


  // submit form
  void onSubmit() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      // loading
      setState(() => buttonLoading = true);

      // verifying otp
      if(widget.verificationId != '' && otpCode != '') {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otpCode
        );
        FirebaseAuth.instance.signInWithCredential(credential).catchError((err) {
          // loading
          setState(() => buttonLoading = false);

          // showing message
          final snackBar = SnackBar(
            content: Text('Some error occurred ${err.message}'),
            backgroundColor: Colors.redAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }).then((value) {
          // showing message
          const snackBar = SnackBar(
            content: Text('Verification successful'),
            backgroundColor: Colors.greenAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // navigation to login page and remove previous history
          Navigator.pushNamedAndRemoveUntil(context, mainContentScreenRoute, (Route<dynamic> route) => false);
        });
      }
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
                              'Verification',
                              style: stylesPageHeaderHeading,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 8),

                            Text(
                              'Please enter the OTP we have sent on your phone number',
                              style: stylesPageHeaderDescription,
                              textAlign: TextAlign.left,
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Text(
                                  "+91 ${widget.phoneNumber}",
                                  style: stylesPageHeaderNumber,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(context, loginScreenRoute),
                                  child: Text(
                                    'Change phone number?',
                                    style: stylesPageLink,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 25),

                        // child | form
                        Form(
                          key: formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              otpField(),

                              otpField(),

                              otpField(),

                              otpField(),

                              otpField(),

                              otpField(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Text(
                              "Didn't get the code?",
                              style: stylesPageHeaderNumber,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => Navigator.pushNamed(context, loginScreenRoute),
                              child: Text(
                                'Resend Code',
                                style: stylesPageLink,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
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
                          ) : const Text('PROCEED')
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget otpField() => SizedBox(
    width: 55,
    child: TextFormField(
      keyboardType: TextInputType.number,
      style: stylesInput,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red, width: 3.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        errorStyle: stylesInputError,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],

      onChanged: (value) {
        if(value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
      onSaved: (value) => setState(() => otpCode += value!),
      validator: (value) {
        if (value!.isEmpty) {
          return '';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    ),
  );
}
