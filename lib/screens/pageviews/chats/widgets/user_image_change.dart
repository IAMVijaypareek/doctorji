import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorji/constants/strings.dart';
import 'package:doctorji/enum/view_state.dart';

import 'package:doctorji/models/entity_model/user.dart';
import 'package:doctorji/provider/image_upload_provider.dart';
import 'package:doctorji/provider/user_provider.dart';

import 'package:doctorji/resources/storage_methods.dart';

import 'package:doctorji/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageChange extends StatefulWidget {
  @override
  _ImageChangeState createState() => _ImageChangeState();
}

class _ImageChangeState extends State<ImageChange> {
  void _pickImage(userID, imageuploadProvider) async {
    File _selectedImage = await Utils.pickImage(source: ImageSource.gallery);

    _uploadImage(
        image: _selectedImage,
        userId: userID,
        imageUploadProvider: imageuploadProvider);
  }

  void _uploadImage({
    @required File image,
    @required String userId,
    @required ImageUploadProvider imageUploadProvider,
  }) async {
    final StorageMethods _storageMethods = StorageMethods();

    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();
    print("loading");

    // Get url from the image bucket
    String url = await _storageMethods.uploadImageToStorage(image);

    print("idele");
    // Hide loading
    imageUploadProvider.setToIdle();

    if (url != null) {
      Firestore.instance
          .collection(USERS_COLLECTION)
          .document(userId)
          .updateData({'profile_photo': url});
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ImageUploadProvider imageUploadProvider = ImageUploadProvider();
    imageUploadProvider.setToIdle();

    final User user = userProvider.getUser;
    if (user == null && user != null) return CircularProgressIndicator();

    return Scaffold(
        body: Container(
            child: Center(
                child: user != null && user.uid != null
                    ? StreamBuilder(
                        stream: Firestore.instance
                            .collection("users")
                            .document(user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          DocumentSnapshot ds = snapshot.data;
                          if (!snapshot.hasData) return Text("Loading..");
                          return ListTile(
                              onTap: () {
                                _pickImage(user.uid, imageUploadProvider);
                              },
                              title: imageUploadProvider.getViewState ==
                                      ViewState.LOADING
                                  ? LinearProgressIndicator()
                                  : Image.network(
                                      ds['profile_photo'] ?? noImageAvailable,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: LinearProgressIndicator(
                                           // semanticsValue: "100",
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                    ));
                        })
                    : CircularProgressIndicator())));
  }
}
