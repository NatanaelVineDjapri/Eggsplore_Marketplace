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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: Appsized.none,
            // left: Appsized.lg,
            // right: Appsized.lg,
            bottom: Appsized.lg
          ),
          child: Column(
            children: [
              //Image Big Logo
              Image(
                image: AssetImage(AppImages.introLogo),
                width: double.infinity,
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
              SizedBox(
                width: 300,
                height: 50,
                child: TextButton(
                  onPressed:(){
                    //login action, nanti diisi disini
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    // foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.2)
                  ) 
                
                , child: const Text(
                    AppStrings.login,
                    style: TextStyle(
                      fontSize: Appsized.fontLg,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                )),
              ),

              SizedBox(height: Appsized.lg,),
              //register button
              SizedBox(
                width: 300,
                height: 50,
                child: TextButton(
                  onPressed:(){
                    //Register action, nanti diisi disini
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    // foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.2)
                  ) 
                
                , child: const Text(
                    AppStrings.register,
                    style: TextStyle(
                      fontSize: Appsized.fontLg,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                )),
              ),
            ],
          ),
        ),
      ),
         bottomNavigationBar: const BottomBanner(),
    );
  }
}

