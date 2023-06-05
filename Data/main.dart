import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:csv/csv.dart';
import 'dart:io';

//import 'dart:io';

void main(){
  String fileName = '';
  print('hello world!!');
}

abstract class Data{
  List _data = [];
  
  void load(String fileName);
  
  void save(String fileName);
  
  void clear(){
    _data.clear();
  }
  
  bool get hasData => data.isNotEmpty;
  
  String get data;
  
  set data(String data);
  
  List<String> get fields => _data[0].keys.toList();
  
}

class JSONData extends Data {
  
  @override
  void load(String fileName){
    //String jsonString = json.encode(fileName);
    //List<dynamic> dataList = jsonDecode(jsonString);
    
    List<Map<String, dynamic>> dataList = json.decode(fileName).cast<Map<String, dynamic>>();
    
    _data = dataList;
  }
  
  @override
  void save(String fileName){
    print('por enquanto, nada');
  }
  
  @override
  String get data {
    return json.encode(_data);
  }
  
  @override
  set data(String data){
    String jsonString = json.encode(data);
    List<dynamic> dataList = jsonDecode(jsonString);
    _data = dataList;
  }
  
}

class XMLData extends Data {
  
  @override
  void load(String fileName){
    XmlDocument xmlDoc = XmlDocument.parse(fileName);
    List<Map<String, String>> records = [];

    for (var recordNode in xmlDoc.findAllElements('record')) {
      Map<String, String> record = {};
      record['id'] = recordNode.getAttribute('id');
      record['name'] = recordNode.getAttribute('name');
      record['email'] = recordNode.getAttribute('email');
      record['phone'] = recordNode.getAttribute('phone');
      records.add(record);
    }
    _data = records; 
  }
  
  @override
  void save(String fileName){
    print('por enquanto, nada');
  }
  
  @override
  String get data {
    var builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('data', nest: () {
      for (var record in _data) {
        builder.element('record', nest: () {
          record.forEach((key, value) {
            builder.attribute(key, value);
          });
        });
      }
    });

    var xmlDoc = builder.build();
    var xmlString = xmlDoc.toXmlString(pretty: true);
    
    return xmlString;
  }
  
  @override
  set data(String data){
    XmlDocument xmlDoc = XmlDocument.parse(data);
    List<Map<String, String>> records = [];

    for (var recordNode in xmlDoc.findAllElements('record')) {
      Map<String, String> record = {};
      record['id'] = recordNode.getAttribute('id');
      record['name'] = recordNode.getAttribute('name');
      record['email'] = recordNode.getAttribute('email');
      record['phone'] = recordNode.getAttribute('phone');
      records.add(record);
    }
    _data = records; 
  }
  
}


abstract class DelimitedData extends Data{
  String get delimiter;
}

class CSVData extends DelimitedData {
  
  void load(String fileName) {
    
    List<List<dynamic>> csvList = CsvToListConverter().convert(fileName, shouldParseNumbers: false);

    List<String> headers = csvList[0].map((e) => e.toString()).toList();

    List<Map<String, dynamic>> records = csvList.sublist(1).map((row) {
      Map<String, dynamic> record = {};
      for (int i = 0; i < row.length; i++) {
        record[headers[i]] = row[i];
      }
      return record;
    }).toList();
    
    _data = records;
  }
  
  @override
  void save(String fileName){
    print('por enquanto, nada');
  }
  
  String get data {
    List<List<dynamic>> csvData = [];

    // Adicionar cabeçalhos
    csvData.add(_data[0].keys.toList());

    // Adicionar valores
    _data.forEach((map) {
      csvData.add(map.values.toList());
    });

    String csvString = ListToCsvConverter().convert(csvData);
    return csvString;
  }
  
  @override
  set data(String data) {
    List<List<dynamic>> csvList = CsvToListConverter().convert(data, shouldParseNumbers: false);

    List<String> headers = csvList[0].map((e) => e.toString()).toList();

    List<Map<String, dynamic>> records = csvList.sublist(1).map((row) {
      Map<String, dynamic> record = {};
      for (int i = 0; i < row.length; i++) {
        record[headers[i]] = row[i];
      }
      return record;
    }).toList();
    
    _data = records;
  }
  
  @override
  String get delimiter => ',';
  
}

class TSVData extends DelimitedData {
  
  void load(String fileName) {
    //String tsvFilePath = fileName;

    List<Map<String, dynamic>> dataList = [];

    final file = File(fileName);
    final lines = file.readAsLinesSync();

    List<String> headers = lines[0].split('\t');

    for (int i = 1; i < lines.length; i++) {
      List<String> values = lines[i].split('\t');
      Map<String, dynamic> map = {};

      for (int j = 0; j < headers.length; j++) {
        map[headers[j]] = values[j];
      }

      dataList.add(map);
    }
    
    _data = dataList;
  }
  
  @override
  void save(String fileName){
    print('por enquanto, nada');
  }
  
  String get data {
    List<List<dynamic>> tsvData = [];

    // Adicionar cabeçalhos
    tsvData.add(_data[0].keys.toList());

    // Adicionar valores
    _data.forEach((map) {
      tsvData.add(map.values.toList());
    });

    String tsvString = const ListToCsvConverter(fieldDelimiter: '\t').convert(tsvData);
    return tsvString;
  }
  
  @override
  set data(String data) {
    List<List<dynamic>> csvList = CsvToListConverter().convert(data, shouldParseNumbers: false);

    List<String> headers = csvList[0].map((e) => e.toString()).toList();

    List<Map<String, dynamic>> records = csvList.sublist(1).map((row) {
      Map<String, dynamic> record = {};
      for (int i = 0; i < row.length; i++) {
        record[headers[i]] = row[i];
      }
      return record;
    }).toList();
    
    _data = records;
  }
  
  @override
  String get delimiter => '\t';
  
}




  
  
  
  
