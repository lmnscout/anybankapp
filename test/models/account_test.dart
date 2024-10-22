import 'package:anybank/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Account account;
  setUp(() {
    // Arrange
    account = Account(id: 1, name: 'Alex', cpf: '123.456.789-00', balance: 100.0);
  });

  group('Account Transfer Tests:', () {
    test('Deve efetuar a transferencia quando o valor for valido', () {
      // Act
      account.transfer(100.0);
      // Assert
      expect(account.balance, 0.0);
    });

    test('Deve lançar InvalidAmountException quando o valor for zero', () {
      // Act
      transfer() => account.transfer(0.0);
      // Assert
      expect(transfer, throwsA(isA<InvalidAmountException>()));
    });

    test('Deve lançar InsufficientBalanceException quando o saldo for insuficiente', () {
      // Act
      transfer() => account.transfer(200.0);
      // Assert
      expect(transfer, throwsA(isA<InsufficientBalanceException>()));
    });

    test('Deve lançar InvalidAmountException quando o valor for negativo', () {
      // Act
      transfer() => account.transfer(-100.0);
      // Assert
      expect(transfer, throwsA(isA<InvalidAmountException>()));
    });

    test('Deve lançar NullAmountException quando o valor for nulo', () {
      // Act
      transfer() => account.transfer(null);
      // Assert
      expect(transfer, throwsA(isA<NullAmountException>()));
    });
  });

  group('Account Interest Tests:', () {
    test('Deve aplicar um juros de 1% para a conta do tipo corrente', () {
      account.applyInterest();

      expect(account.balance, 101.0);
    });

    test('Deve aplicar um juros de 3% para a conta do tipo poupança', () {
      account.accountType = AccountType.savings;
      account.applyInterest();

      expect(account.balance, 103.0);
    });

    test('Deve aplicar um juros de 7% para a conta do tipo investimento', () {
      account.accountType = AccountType.investiment;
      account.applyInterest();

      expect(account.balance, 107.0);
    });

    test('Deve lançar InsuficcientBalanceException para saldo menor ou igual a zero', () {
      account.balance = 0.0;

      applyInterest() => account.applyInterest();

      expect(applyInterest, throwsA(isA<InsufficientBalanceException>()));
    });
  });
}
