import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  bool _showFavorite = false;

  bool get showFavorite {
    return _showFavorite;
  }

  toggleFavorite() {
    _showFavorite = !_showFavorite;
    notifyListeners();
  }
} 