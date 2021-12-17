import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MediaService{
  
  final  storageReference = firebase_storage.FirebaseStorage.instance;
  Future<String> uploadFile(File? _image) async {
  final fileName = DateTime.now().microsecondsSinceEpoch.toString();
  var path = storageReference.ref().child('products').child(fileName);
  var uploadTask = await path.putFile(_image!);
  return uploadTask.ref.getDownloadURL();
}
}