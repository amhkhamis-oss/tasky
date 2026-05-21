import 'package:flutter/material.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/screens/main_screen.dart';
import 'package:tasky3/widget/custom_svg_picture.dart';
import 'package:tasky3/widget/custom_text_form_field.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withoutColor(
                        path: 'assets/images/logo.svg',
                        height: 42,
                        widht: 42,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: 8),
                      CustomSvgPicture.withoutColor(
                        path: 'assets/images/hand.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your productivity journey starts here.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 24),
                  CustomSvgPicture.withoutColor(
                    path: 'assets/images/pana.svg',
                    height: 205,
                    widht: 215,
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: controller,
                          hintText: 'e.g. Sarah Khalid',
                          text: 'Full Name',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter Your Full Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              45,
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await PrefrenceManager().setString(
                                'username',
                                controller.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please Enter Your Name"),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Let’s Get Started",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
