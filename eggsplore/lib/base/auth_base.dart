import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/widget/bottomAuth.dart';
import 'package:eggsplore/widget/richText.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatelessWidget {
  final String title;
  final String? accentTitle;
  final String subtitle;
  final List<Widget> fields;
  final String buttonText;
  final String? footerText;
  final VoidCallback onButtonPressed;

  const AuthPage({
    super.key,
    required this.title,
    this.accentTitle,
    required this.subtitle,
    required this.fields,
    required this.buttonText,
    this.footerText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    String finalAccentTitle = accentTitle ?? AppStrings.account;
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Image.asset(
              'assets/images/loginBackground.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 45, right: 45, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + optional accent
                    if (finalAccentTitle != 'Account')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: AppTextStyle.mainTitle),
                          Text(finalAccentTitle, style: AppTextStyle.accentTitle),
                        ],
                      )
                    else
                      richTextTitle(
                        mainTitle: title,
                        accentTitle: AppStrings.account,
                        fontSize: Appsized.fontxxl,),
                    
                    const SizedBox(height: Appsized.xs),
                    Text(subtitle, style: AppTextStyle.subtitle),
                    const SizedBox(height: Appsized.xxxl),

                    // Form fields
                    ...fields,
                    const SizedBox(height: 50),

                    // Bottom button + footer
                    Column(
                      children: [
                        BottomAuth(
                          text: buttonText,
                          onPressed: onButtonPressed,
                        ),
                        if (footerText != null) ...[
                          const SizedBox(height: Appsized.xs),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: AppStrings.notRegister,
                                style: AppTextStyle.footer,
                                children: [
                                  TextSpan(
                                    text: ' ${AppStrings.createAccount}',
                                    style: AppTextStyle.footerAccent,
                                    recognizer: TapGestureRecognizer()
                                    ..onTap =() {
                                       Navigator.pushNamed(context, AppRoutes.register);
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}