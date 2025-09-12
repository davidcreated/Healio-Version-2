/// Model class for wallet information
class WalletInfo {
  final double balance;
  final String currency;
  final bool isVerified;

  WalletInfo({
    required this.balance,
    this.currency = '₦',
    this.isVerified = true,
  });

  String get formattedBalance {
    return '$currency${balance.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
      (Match m) => '${m[1]},'
    )}';
  }
}
