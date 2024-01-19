import 'package:accounting/shared/cubit/register_cubit.dart';
import 'package:accounting/shared/cubit/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../shared/components/snac_bar.dart';
import '../shared/components/text_form_field.dart';
import '../shared/components/text_widget.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/text_style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  ////////////////////////////////// variables
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ensurePasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var formKey = GlobalKey <FormState> ();
  RegisterCubit? registerCubit;
  ///////////////////////////////// Build Method
  @override
  Widget build(BuildContext context) {
    return BlocProvider <RegisterCubit> (
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer <RegisterCubit, RegisterStates> (
        listener: (context, state){},
        builder: (context, state){
        registerCubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: DefaultText(
              text: 'Register',
              fontSize: 28,
              fontColor: Colors.black,
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ConditionalBuilder(
                        condition: true,
                        builder: (context) => Center(
                          child: GestureDetector(
                              onTap: () async {
                                registerCubit!.uploadImage();
                              },
                              child: SvgPicture.asset('assets/images/icon_camera.svg')
                          ),
                        ),
                        fallback: (BuildContext context) => const Center(child: CircularProgressIndicator(),),
                      ),
                      SizedBox(height: 14),
                      DefaultTextField(
                        controller: emailController,
                        color:  Theme.of(context).focusColor,
                        hintText: 'Email or phone number',
                        prefix: Icon(Icons.person, color: silverColor,),
                        textInputType: TextInputType.emailAddress,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Required Field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      Row(
                        children: [
                          Expanded(
                            child: DefaultTextField(
                              color:  Theme.of(context).focusColor,
                              controller: firstNameController,
                              hintText: 'First name',
                              prefix: Icon(Icons.person, color: silverColor,),
                              textInputType: TextInputType.name,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'Required Field';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: DefaultTextField(
                              color:  Theme.of(context).focusColor,
                              controller: lastNameController,
                              hintText: 'Last name',
                              prefix: Icon(Icons.person, color: silverColor,),
                              textInputType: TextInputType.name,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'Required Field';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DefaultTextField(
                        color: Theme.of(context).focusColor,
                        hintText: 'Password',
                        controller: passwordController,
                        prefix: Icon(Icons.lock, color: silverColor,),
                        obscureText: true,
                        suffix: GestureDetector(
                          onTap: (){},
                          //child: loginCubit.isPasswordRegisterNormal? Icon(Icons.visibility_off, color: silverColor,) : Icon(Icons.visibility, color: silverColor,),
                          child: Icon(Icons.visibility, color: silverColor,),
                        ),
                        textInputType: TextInputType.number,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Required Field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      DefaultTextField(
                        color: Theme.of(context).focusColor,
                        controller: ensurePasswordController,
                        obscureText: true,
                        hintText: 'Confirm Password',
                        prefix: Icon(Icons.lock, color: silverColor,),
                        suffix: GestureDetector(
                          onTap: (){},
                          //child: loginCubit.isEnsurePasswordRegister? Icon(Icons.visibility_off, color: silverColor,) : Icon(Icons.visibility, color: silverColor,),
                          child: Icon(Icons.visibility, color: silverColor,),
                        ),
                        textInputType: TextInputType.number,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Required Field';
                          }else if (passwordController.text != ensurePasswordController.text){
                            return 'The password Not matching';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      DefaultTextField(
                        color: Theme.of(context).focusColor,
                        controller: dateController,
                        hintText: 'Birthdate dd / mm / yy',
                        prefix: Icon(Icons.date_range, color: silverColor,),
                        textInputType: TextInputType.none,
                        onTap: (){
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse('1990-01-01'),
                            lastDate:  DateTime.now(),
                          ).then((value){
                            dateController.text = DateFormat.yMMMd().format(value!);
                          });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return 'Required Field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(right: 63),
                        child: RichText(
                          text: TextSpan(
                            style: defaultStyle,
                            children:<TextSpan> [
                              const TextSpan(text: '. By clicking the'),
                              TextSpan(text: ' Register', style: linkStyle,),
                              const TextSpan(text: ' button,you agree to\n'),
                              TextSpan(text: '  the public offer', style: defaultStyle ,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      Row(
                        children: [
                          Expanded(
                              child: DefaultText(
                            text: 'Register',
                                fontColor: Colors.black,)),
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => GestureDetector(
                                onTap: (){
                                  if (formKey.currentState!.validate ()){
                                    if (passwordController.text != ensurePasswordController.text){
                                      defaultSnackBar(
                                          context: context,
                                          text: 'Two password not matching',
                                          color: Colors.red
                                      );
                                    }else{
                                    }
                                  }
                                },
                                child: SvgPicture.asset('assets/images/icon_arrow_right.svg')),
                            fallback: (context) => const Center(child: CircularProgressIndicator(),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
);
  }
}
