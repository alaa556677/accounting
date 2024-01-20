import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'register_states.dart';
import 'dart:io';
import 'package:path/path.dart';

class RegisterCubit extends Cubit <RegisterStates>{
  RegisterCubit() : super(InitialLoginState());
  static RegisterCubit get(context) => BlocProvider.of(context);
/////////////////////////////////////////////////////////////////////////////////////////// upload image
  File? file;
  var imagePicker = ImagePicker();
  String? url;
  uploadImage() async {
    emit(UploadImageRegisterLoading());
    try {
      XFile? imgPicked = await imagePicker.pickImage(source: ImageSource.gallery);
      var nameImage = basename(imgPicked!.path);
      if (imgPicked != null) {
        file = File(imgPicked.path);
        var random = Random().nextInt(10000);
        nameImage = '$random$nameImage';
        var refStorage = FirebaseStorage.instance.ref("images/$nameImage");
        print(file);
        await refStorage.putFile(file!);
        url = await refStorage.getDownloadURL();
        print('Url Image : $url');
      }
      emit(UploadImageRegisterSuccess());
    } catch (e) {
      debugPrint('error is $e');
      emit(UploadImageRegisterError());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////// register
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  createUser(String email, password , BuildContext context) async {
    emit(RegisterLoading());
    userCredential = await auth.createUserWithEmailAndPassword( email: email, password: password
    ).then((value) {
      emit(RegisterSuccess());
    }).catchError((e){
      print("error ${e.toString()}");
      emit(RegisterError(e.toString()));
    });
  }

}