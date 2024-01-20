import 'package:accounting/shared/cubit/register_cubit.dart';
import 'package:accounting/shared/cubit/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../shared/components/button_custom_widget.dart';
import '../shared/components/text_form_field.dart';
import '../shared/components/text_widget.dart';
import '../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static String route = "RegisterScreen";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterCubit? registerCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Register Successfully'),
              backgroundColor: Colors.blue,
            ));
            emailController.clear();
            passwordController.clear();
            repeatPasswordController.clear();
          }
          if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Register Error ${state.message}'),
              backgroundColor: Colors.blue,
            ));
            emailController.clear();
            passwordController.clear();
            repeatPasswordController.clear();
          }
        },
        builder: (context, state) {
          registerCubit = RegisterCubit.get(context);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //color: mainColorLight2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/starry-night-sky.jpg'),
                  fit: BoxFit.fill,
                )),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              bottom: MediaQuery.of(context).size.height *
                                  (20 / 600),
                              top:
                                  MediaQuery.of(context).size.height * (1 / 9)),
                          child: ConditionalBuilder(
                            condition: state is! UploadImageRegisterLoading,
                            builder: (context) => GestureDetector(
                              onTap: () {
                                registerCubit!.uploadImage();
                              },
                              child: registerCubit!.file == null
                                  ? SvgPicture.asset(
                                      "assets/images/profilePicture.svg",
                                      color: greyColor,
                                      width: MediaQuery.of(context).size.width *
                                          (140 / 430),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (140 / 932),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          (140 / 430),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (140 / 932),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: FileImage(
                                                  registerCubit!.file!))),
                                    ),
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .65,
                            decoration: const BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustomWidget(
                                      text: "Sign Up",
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "poppins",
                                      fontColor: colorBlack,
                                    ),
                                    SizedBox(height: 30),
                                    DefaultTextForm(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'require';
                                        }
                                        return null;
                                      },
                                      label: "Email address",
                                      prefix: const Icon(Icons.email_outlined),
                                    ),
                                    SizedBox(height: 15),
                                    DefaultTextForm(
                                      controller: passwordController,
                                      label: "Password",
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'require';
                                        }
                                        return null;
                                      },
                                      prefix: const Icon(Icons.lock_outline),
                                    ),
                                    SizedBox(height: 15),
                                    DefaultTextForm(
                                      controller: repeatPasswordController,
                                      label: "Repeat Password",
                                      prefix: const Icon(Icons.lock_outline),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'require';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    ConditionalBuilder(
                                        condition: state is !RegisterLoading,
                                        builder: (context) => ButtonCustomWidget(
                                          buttonColor: mainColorDark,
                                          text: "Sign Up",
                                          color: colorWhite,
                                          buttonWidth:
                                          MediaQuery.of(context).size.width,
                                          buttonHeight: 48,
                                          onPressed: () {
                                            if (passwordController.text ==
                                                repeatPasswordController.text) {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                registerCubit!.createUser(
                                                    emailController.text,
                                                    passwordController.text,
                                                    context);
                                              }
                                            }
                                          },
                                        ),
                                        fallback: (context) => Center(child: CircularProgressIndicator(),)
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextCustomWidget(
                                          text: "Already have an account?",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                          fontColor: textOnBoardingColor,
                                          fontFamily: "poppins",
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: TextCustomWidget(
                                            text: "Sign In",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            fontColor: mainColorDark,
                                            fontFamily: "poppins",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
