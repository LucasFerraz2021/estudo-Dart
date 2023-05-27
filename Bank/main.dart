void main(){
  //AccountCurrent p1 = AccountCurrent();
  //p1.AbrirConta('Joao vitor');
  AccountSpecial p2 = AccountSpecial();
  p2.AbrirConta('Ivina');
  p2.Depositar(100);
  p2.Sacar(1000);
  print(Account.contas);
}

abstract class Account {
  String tipo = '';
  String nome = '';
  int agencia = 1000;
  static int controleContas = 0;
  static Map contas = {};
  
  Account({this.tipo = ''});
  
  void AbrirConta(String n){
    nome = n;
    controleContas++;
    contas[n] = {
      'titular':nome,
      'agencia': agencia,
      'numeroConta': controleContas,
      'saldo': 0,
      'tipo': tipo,
    };
    if (contas[nome]['tipo'] == 'special'){
      contas[nome].putIfAbsent('limite', () => 1000);
    }
  }
  
  void FecharConta() => contas.remove(nome);
  
  void Depositar(int valor) => contas[nome]['saldo'] += valor;
  
  void Pagar_Sacar(int valor){
    int saldo = Account.contas[nome]['saldo'];
    
    if (saldo >= valor) {
      Account.contas[nome]['saldo'] -= valor;
    } else {
      print('Saldo insuficiente para completar a operação!!');
    }
  }
  
  void Sacar(int valor){
    Pagar_Sacar(valor);
  }
  
  void Pagar(int valor){
    Pagar_Sacar(valor);
  }
  
  void Transferir(Account pessoa, int valor){
    contas[nome]['saldo'] -= valor;
    contas[pessoa.nome]['saldo'] += valor;
  }
  
  String MostrarSaldo(){
    return 'Saldo: R\$${contas[nome]['saldo']}';
  }
}

class AccountCurrent extends Account {
  AccountCurrent([tipo = '']) : super(tipo: 'Corrente');
}

class AccountSpecial extends Account {
  
  AccountSpecial([tipo = '']) : super(tipo: 'special');
  
  void Pagar_Sacar(int valor) {
    int saldo = Account.contas[nome]['saldo'];
    int limite = Account.contas[nome]['limite'];
    
    if (saldo >= valor) {
      Account.contas[nome]['saldo'] -= valor;
    } else if((saldo + limite) > valor ) {
      Account.contas[nome]['saldo'] = 0;
      Account.contas[nome]['limite'] = (limite + saldo) - valor;
    } else if(valor > (saldo + limite)){
      print('Saldo insuficiente para completar a operação!!');
    }
  }
  
  @override
  void Sacar(int valor){
    
    Pagar_Sacar(valor);
  }
  
  @override
  void Pagar(int valor){
    Pagar_Sacar(valor);
  }
  
}




