void main(){
  
  String file1 =
  '''
  id,name,email,phone
  1020,Ana Célia Souza,anasouza@email.com,85992219030
  2055,Carlos Alberto Souza,carlos@email.com,86992201122
  3090,Zelia da Silva Melo,zelia@email.com,86988701020
  4450,Paulo Martins Farias,,86994415088
  5588,Patrícia Soares,patty@email.com,85988771122
  ''';
  
  String file2 = 
  '''
  Nome\tIdade\tCidade
  Alice\t25\tSão Paulo
  Bob\t30\tRio de Janeiro
  Carlos\t35\tBelo Horizonte
  ''';
  
  String file3 =
  '''
  id	name	email	phone
  1020	Ana Célia Souza	anasouza@email.com	85992219030
  2055	Carlos Alberto Souza	carlos@email.com	86992201122
  3090	Zelia da Silva Melo	zelia@email.com	86988701020
  ''';
  
  String file4 = 
  '''
  <?xml version="1.0" encoding="UTF-8"?>
  <data>
    <record id="1020" name="Ana Célia Souza" email="anasouza@email.com" phone="85992219030" />
    <record id="2055" name="Carlos Alberto Souza" email="carlos@email.com" phone="86992201122"/>
    <record id="3090" name="Zelia da Silva Melo" email="zelia@email.com" phone="86988701020"/>
  </data>
  ''';
  
  //print(file4);

  convertXml(file4);

}

//converter csv para lista de map//
List convertCsv(String file){
  
    List data = [];
    List fileList = file.split('\n');
    for (int i = 0; i < fileList.length; i++){
      fileList[i] = fileList[i].trim();
    }
    List listKeys = fileList[0].split(',');
    for (int i = 1; i < fileList.length - 1; i++) {
      List listValues = fileList[i].split(',');
      Map map = {};
      for (int j = 0; j < listKeys.length; j++) {
        map[listKeys[j]] = listValues[j];
      }
      data.add(map);
    }
    return data;
  }

//converter xml para lista
void convertXml(String file){
  List data = [];
  List fileList = file.split('\n');
  for (int i = 0; i < fileList.length; i++){
    fileList[i] = fileList[i].trim();
  }
 
  fileList.removeAt(0);
  fileList.removeAt(0);
  fileList.removeAt(fileList.length - 1);
  fileList.removeAt(fileList.length - 1);
  
  
  for (int i = 0; i < fileList.length; i++){
    fileList[i] = fileList[i].replaceAll('<record ', '');
    fileList[i] = fileList[i].replaceAll('/>', '');
    fileList[i] = fileList[i].replaceAll('="', '-');
  }
  
  List filtro1 = [];
  for (var i in fileList) {
    filtro1.add(i.split('"'));
  }
 
  List filtro2 = [];
  for (int i = 0; i < filtro1.length; i++){
    Map map = {};
    for (int j = 0; j < 4; j++) {
      List keyValue = filtro1[i][j].split('-');
      map[keyValue[0]] = keyValue[1];
    }
    filtro2.add(map);
  }
  
  print(filtro2);
  
}

//converter Lista de maps para csv//
String encodeCsv(List data){
  String csvString = '';
  
  var listKeys = data[0].keys.toList();
  List geral = [listKeys];
  for (int i = 1; i < data.length; i++) {
    geral.add(data[i].values.toList());
  }
  for (var i in geral) {
    csvString += '${i.join(',')}\n';
  }
  return csvString.trim();
}

// converter lista para tsv
String encodeTsv(List data){
  String tsvString = '';
  
  var listKeys = data[0].keys.toList();
  List geral = [listKeys];
  for (int i = 1; i < data.length; i++){
    geral.add(data[i].values.toList());
  }
  for (var i in geral) {
    tsvString += '${i.join('\t')}\n';
  }
  return tsvString.trim();
}

//converter Tsv para lista de maps
List convertTsv(String file){
  List data = [];
  List fileList = file.split('\n');
  for (int i = 0; i < fileList.length; i++){
    fileList[i] = fileList[i].trim();
  }
  List listKeys = fileList[0].split('\t');
  for (int i = 1; i < fileList.length - 1; i++) {
    List listValues = fileList[i].split('\t');
    Map map = {};
    for (int j = 0; j < listKeys.length; j++) {
      map[listKeys[j]] = listValues[j];
    }
    data.add(map);
  }
  return data;
}
