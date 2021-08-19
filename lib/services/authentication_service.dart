import 'package:firebase_auth/firebase_auth.dart';
import 'package:splasha/models/my_user.dart';
import 'package:splasha/services/database.dart';

class AuthenticationService{
final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;


MyUser _userFromFirebaseUser(User user){

  return user!=null? MyUser(uid: user.uid):null;
}

Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();




Future signIn({String email,String password})async{
try{

   var result =await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
   User user = result.user;
   return _userFromFirebaseUser(user);
} on FirebaseAuthException catch(e){
  return e.message;

}

}
Future signUp({String email,String password,String name, String contactNumber})async{
  try{

    var result=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    
    await DatabaseService(uid:user.uid).updateMyUserData(user.uid,name, contactNumber, email);
    return _userFromFirebaseUser(user);
  } on FirebaseAuthException catch(e){
    return e.message;

  }

}


Future getCurrentUser()async{
  return  _firebaseAuth.currentUser;
}

Future signOut()async{

  try{
    _firebaseAuth.signOut();
  } catch(e){

  }

}

}
