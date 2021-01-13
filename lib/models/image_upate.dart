import 'package:flutter/cupertino.dart';

class DataImageUp with ChangeNotifier {
  var _image;
  var _nameImage;

  get image {
    return _image;
  }

  set image(String image) {
    this._image = image;
    notifyListeners();
  }

  get nameImage {
    return _nameImage;
  }

  set nameImage(String nameImage) {
    _nameImage = nameImage;
    notifyListeners();
  }
}
