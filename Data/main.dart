import 'dart:convert';
import 'package:xml/xml.dart';

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
  
  List<String> get fields;
  
}

class JSONData extends Data {
  
  @override
  void load(String fileName){
    String jsonString = json.encode(fileName);
    List<dynamic> dataList = jsonDecode(jsonString);
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
  
  @override
  List<String> get fields {
    return ['Por nquanto nada'];
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
  
  @override
  List<String> get fields {
    return ['Por nquanto nada'];
  }
  
}



  
  
  
  
