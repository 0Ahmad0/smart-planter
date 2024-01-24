import 'dart:io';



import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:smart_plans/app/controller/provider/profile_provider.dart';


class ProfileController{
  late ProfileProvider profileProvider;
  var context;
  ProfileController({required this.context}){
    profileProvider= Provider.of<ProfileProvider>(context);
  }
  // Future uploadImage({required File image}) async {
  //   try {
  //     String path = basename(image!.path);
  //     print(image!.path);
  //     File file =File(image!.path);
  //     //FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
  //     Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
  //     UploadTask storageUploadTask = storage.putFile(file);
  //     TaskSnapshot taskSnapshot = await storageUploadTask;
  //     //Const.LOADIG(context);
  //     String url = await taskSnapshot.ref.getDownloadURL();
  //     //Navigator.of(context).pop();
  //     print('url $url');
  //     return url;
  //   } catch (ex) {
  //     //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
  //   }
  // }
}