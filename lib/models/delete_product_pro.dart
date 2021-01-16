import 'package:flutter/cupertino.dart';

class DeleteProductProvider with ChangeNotifier {
  var _image = '';
  var _nameImage = '';
  var _idProduct = '';
  var _nombreProducto = '';
  var _precio = '';

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

  get idProduct {
    return _idProduct;
  }

  set idProduct(String idProduct) {
    this._idProduct = idProduct;
    notifyListeners();
  }

  get nombreProducto {
    return _nombreProducto;
  }

  set nombreProducto(String nombreProducto) {
    this._nombreProducto = nombreProducto;
    notifyListeners();
  }

  get precio {
    return _precio;
  }

  set precio(String precio) {
    this._precio = precio;
    notifyListeners();
  }
}
