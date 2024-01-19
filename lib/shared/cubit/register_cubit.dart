import 'dart:math';
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

}