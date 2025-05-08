class FirebaseErrorHelper {
  static String getMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'Geçersiz e-posta adresi girdiniz.';
      case 'user-not-found':
        return 'Bu e-posta ile kayıtlı bir kullanıcı bulunamadı.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-posta adresi veya şifre hatalı.';
      case 'email-already-in-use':
        return 'Bu e-posta adresiyle zaten bir hesap oluşturulmuş.';
      case 'weak-password':
        return 'Şifreniz çok zayıf. Lütfen daha güçlü bir şifre belirleyin.';
      case 'too-many-requests':
        return 'Çok fazla deneme yapıldı. Lütfen daha sonra tekrar deneyin.';
      case 'network-request-failed':
        return 'İnternet bağlantısı sağlanamadı. Lütfen bağlantınızı kontrol edin.';
      case 'permission-denied':
        return 'Bu işlemi gerçekleştirmek için izniniz yok.';
      case 'unavailable':
        return 'Sunucu şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';
      case 'not-found':
        return 'İstenen kullanıcı verisi bulunamadı.';
      default:
        return 'Bir hata oluştu. Lütfen tekrar deneyin.';
    }
  }
}
