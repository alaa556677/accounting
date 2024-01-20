import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate (BlocBase bloc) { // which the state opens now
    super.onCreate(bloc);
    print ('onCreate -- ${bloc.runtimeType}');}
  @override
  void onChange (BlocBase bloc, Change change) { // what happen to state
    super.onChange(bloc, change);
    print ('onChange -- ${bloc.runtimeType}, $change');}
  @override
  void onError (BlocBase bloc, Object error, StackTrace stackTrace) { // the error
    print ('onError -- ${bloc.runtimeType}, $error');
    super.onError (bloc, error, stackTrace);} // stackTrace: what should I do
  @override
  void onClose (BlocBase bloc) { // what happens when the bloc close
    super.onClose (bloc);
    print ('onClose -- ${bloc.runtimeType}');}}
