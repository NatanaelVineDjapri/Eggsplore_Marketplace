import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/constants/images.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:eggsplore/constants/text_style.dart';
import 'package:eggsplore/widget/bottomAuth.dart';
import 'package:eggsplore/widget/eggsy.dart';
import 'package:eggsplore/widget/handImage.dart';
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
  final VoidCallback? onButtonPressed;
  final String imagePaths;

  const AuthPage({
    super.key,
    required this.title,
    this.accentTitle,
    required this.subtitle,
    required this.fields,
    required this.buttonText,
    this.footerText,
    this.onButtonPressed,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Appsized(context);
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    String finalAccentTitle = accentTitle ?? AppStrings.account;
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  AppImages.loginBackground,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  cacheWidth: 1080,
                ),
                Stack(children: [Eggsy(imagePath: imagePaths)]),
              ],
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
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 45,
                      right: 45,
                      top: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (finalAccentTitle != 'Account')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: AppTextStyle.mainTitle),
                              Text(
                                finalAccentTitle,
                                style: AppTextStyle.accentTitle,
                              ),
                            ],
                          )
                        else
                          richTextTitle(
                            mainTitle: title,
                            accentTitle: AppStrings.account,
                            fontSize: Appsized.fontxxl,
                          ),

                        SizedBox(height: spacing.xss),
                        Text(subtitle, style: AppTextStyle.subtitle),
                        SizedBox(height: spacing.xl),

                        ...fields,
                        const SizedBox(height: 50),

                        Column(
                          children: [
                            if (!isKeyboardVisible)
                              BottomAuth(
                                text: buttonText,
                                onPressed: onButtonPressed,
                              ),
                            if (footerText != null) ...[
                              SizedBox(height: spacing.xs),
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
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                              context,
                                              AppRoutes.register,
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isKeyboardVisible) ...[
            Handimage(isLeft: true),
            Handimage(isLeft: false),
          ],
        ],
      ),
    );
  }
}
