import 'package:eggsplore/app_routes.dart';
import 'package:eggsplore/widget/bottomAuth.dart';
import 'package:eggsplore/bar/buttom_banner.dart';
import 'package:eggsplore/constants/text_string.dart';
import 'package:flutter/material.dart';
import '../../constants/images.dart';
import '../../constants/sizes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: Appsized.none,
            bottom: Appsized.lg
          ),
          child: Column(
            children: [
              //Image Big Logo
              Image(
                image: AssetImage(AppImages.introLogo),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.fitWidth,
              ),
    
              const SizedBox(height: Appsized.xl),
              RichText(
                textAlign: TextAlign.center,
                text:TextSpan(
                  style: const TextStyle(
                    fontSize: Appsized.fontxl,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.introTitle_1
                    ),
                    TextSpan(
                      text: AppStrings.introTitle_2,
                      style: const TextStyle(
                        color: Colors.orange,
                      )
                    )
                  ]
                )
              ),

              const SizedBox(height: Appsized.md),
              //sub
              SizedBox(
                width: 300,
                child: Text(
                  AppStrings.introSub,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: Appsized.fontSm,
                    color: Colors.black54,
                  ),
                ),
              ),

            const SizedBox(height: Appsized.xl),

              //login button
            BottomAuth(
              text: AppStrings.login,
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),

            SizedBox(height: Appsized.lg,),
              //register button
            BottomAuth(
              text: AppStrings.register,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.register);
              },
             ),
            ],
          ),
        ),
      ),
         bottomNavigationBar: const BottomBanner(),
    );
  }
}

