import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/features/auth/controllers/auth_controller.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/images.dart';
import 'package:vv_admin/utill/styles.dart';
import 'package:vv_admin/features/auth/screens/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthController>(context, listen: false).isActiveRememberMe;
    return Scaffold(
      body: Consumer<AuthController>(builder: (context, auth, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 12,
                          bottom: 38),
                      child: Column(
                        children: [
                          Hero(
                            tag: 'logo',
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeExtraLarge,
                              ),
                              child: Image.asset(
                                Images.logo,
                                width: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: Text(
                  getTranslated('login', context)!,
                  style: titilliumBold.copyWith(
                    fontSize: Dimensions.fontSizeOverlarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                child: Text(
                  getTranslated('manage_your_business_from_app', context)!,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              const LoginScreen()
            ],
          ),
        );
      }),
    );
  }
}
