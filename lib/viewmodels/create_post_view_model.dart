import 'dart:io';

import 'package:CourseMate/utils/locator.dart';
import 'package:CourseMate/models/post.dart';
import 'package:CourseMate/services/analytics_service.dart';
import 'package:CourseMate/services/cloud_storage_service.dart';
import 'package:CourseMate/services/dialog_service.dart';
import 'package:CourseMate/services/firestore_service.dart';
import 'package:CourseMate/services/navigation_service.dart';
import 'package:CourseMate/utils/image_selector.dart';
import 'package:CourseMate/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Post _edittingPost;

  bool get _editting => _edittingPost != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      notifyListeners();
    }
  }

  Future addPost({@required String title}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_editting) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    }

    var result;

    if (!_editting) {
      result = await _firestoreService.addPost(Post(
        title: title,
        userId: currentUser.id,
        imageUrl: storageResult.imageUrl,
        imageFileName: storageResult.imageFileName,
      ));

      await _analyticsService.logPostCreated(hasImage: _selectedImage != null);
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        imageUrl: _edittingPost.imageUrl,
        imageFileName: _edittingPost.imageFileName,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
