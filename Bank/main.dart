void main(){
  AccountCurrent p1 = AccountCurrent();
  AccountCurrent p2 = AccountCurrent();
  p1.AbrirConta('Joao vitor');
  p2.AbrirConta('Ivina');
  p1.Depositar(100);
  p1.Transferir(p2, 50);
  p1.Sacar(100);
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
  }
  
  void FecharConta(){
    contas.remove(nome);
  }
  
  void Depositar(int valor){
    contas[nome]['saldo'] += valor;
  }
  
  void Sacar(int valor);
  
  void Pagar(int valor){
    contas[nome]['saldo'] -= valor;
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
  
  @override
  void Sacar(int valor){
    int saldo = Account.contas[nome]['saldo'];
    
    if (saldo >= valor) {
      Account.contas[nome]['saldo'] -= valor;
    } else {
      print('Saldo insuficiente para completar a operação!!');
    }
  }
}
