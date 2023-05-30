import 'dart:convert';
//json: '{"nome": "João", "idade": 25, "email": "joao@example.com"}'

void main(){
  
  var fileName = '{"nome": "João", "idade": 25, "email": "joao@example.com"}';
  
  var d1 = JSONData();
  d1.load(fileName);
  d1.save(fileName);
  //d1.clear();
  print(d1.memoria);
  print(d1.hasData());
  
}

abstract class Data {
  List memoria = [];
  String copyFileName = '';
  
  void load(String fileName){
    memoria.add(fileName);
  }
  
  void save(String fileName){
    fileName = '$memoria';
  }
  
  void clear(){
    memoria = [];
  }
  
  bool hasData(){
    return memoria.length > 0;
  }
  
  List get data => memoria;
}

class JSONData extends Data {
  
  @override
  void load(String fileName){
    this.memoria.add(jsonDecode(fileName));
  }
  
  @override
  void save(String fileName){
    fileName = jsonEncode(this.memoria);
    //fileName = '${this.memoria}';
  }
  
}

class XMLData extends Data {
}

abstract class DelimitedData extends Data {
}

class CSVData extends DelimitedData {
}

class TSVData extends DelimitedData {
}
