import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk/configure.dart';
import 'package:talk/services/image/image_uploader.dart';
import 'package:talk/services/user/user_service_contract.dart';
import 'package:talk/services/user/user_service_impl.dart';
import 'package:talk/states_management/onboarding/onboarding_cubit.dart';
import 'package:talk/ui/pages/onboarding/onboarding.dart';

class CompositionRoot {
  static late String _url;
  static late IUserService _userService;

  static configure() async {
    _url = "127.0.0.1:8080";
    _userService = UserService(_url);
  }

  static Widget composeOnboardingUI() {
    ImageUploader imageUploader = ImageUploader(imageUploadUrl);

    OnboardingCubit onboradingCubit =
        OnboardingCubit(_userService, imageUploader);
    // ProfileImageCubit imageCubit = ProfileImageCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => onboradingCubit)),
        // BlocProvider(create: ((context) => imageCubit)),
      ],
      child: const Onboarding(),
    );
  }
}
