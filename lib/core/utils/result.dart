// core/result.dart

// Result tipini tanımlıyoruz
class Result<T> {
  final T? _data;
  final String? _error;
  final bool _isSuccess;

  // Başarı durumu
  Result.success(this._data) : _isSuccess = true, _error = null;

  // Hata durumu
  Result.failure(this._error) : _isSuccess = false, _data = null;

  // Başarılı mı?
  bool get isSuccess => _isSuccess;

  // Başarısız mı?
  bool get isFailure => !_isSuccess;

  // Veri alınması
  T? get data => _data;

  // Hata mesajı
  String? get error => _error;
}
