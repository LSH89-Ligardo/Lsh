class BankAccount {
  String _accountNumber;
  double _balance = 0.0;

  BankAccount(this._accountNumber);

  // Getter 내부 데이터 접근 제한 ( 데이터 은닉 )
  String get accountNumber => _accountNumber;
  double get balance => _balance;

  // 입금 메서드
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('입금: $amount');
      print('잔액: $_balance');
    }
  }

  // 출금 메서드
  bool withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('출금: $amount');
      print('잔액: $_balance');
      return true;
    } else {
      print('출금 실패: $amount');
      print('잔액: $_balance');
      return false;
    }
  }
}

void main() {
  var account = BankAccount('123-456-789');
  print('계좌번호: ${account.accountNumber}');
  print('잔액: ${account.balance}');
  account.deposit(100.0);
  account.withdraw(50.0);
  account.withdraw(100.0);
}
