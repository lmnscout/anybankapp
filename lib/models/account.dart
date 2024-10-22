enum AccountType {
  checking,
  savings,
  investiment,
}

class Account {
  final int id;
  final String name;
  final String cpf;
  double balance;
  AccountType accountType;

  Account({
    required this.id,
    required this.name,
    required this.cpf,
    required this.balance,
    this.accountType = AccountType.checking,
  });

  void transfer(double? amount) {
    if (amount == null) {
      throw NullAmountException();
    }
    if (amount <= 0) {
      throw InvalidAmountException();
    }
    if (amount > balance) {
      throw InsufficientBalanceException();
    }
    balance -= amount;
  }

  void applyInterest() {
    if (balance <= 0) {
      throw InsufficientBalanceException();
    }
    double interest = 0.01;
    switch (accountType) {
      case AccountType.checking:
        break;
      case AccountType.savings:
        interest = 0.03;
        break;
      case AccountType.investiment:
        interest = 0.07;
        break;
    }
    balance *= (1 + interest);
  }
}

class NullAmountException implements Exception {
  @override
  String toString() {
    return 'Valor de transferência não pode ser nulo';
  }
}

class InvalidAmountException implements Exception {
  @override
  String toString() {
    return 'Valor de transferência deve ser maior que zero';
  }
}

class InsufficientBalanceException implements Exception {
  @override
  String toString() {
    return 'Saldo insuficiente';
  }
}
