import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:diary/constants/AppConstants.dart';
import 'package:diary/constants/AppConstants.dart';

class Paras {


  final String lPARA_TYPE;
  final String lPARA_DATA;
  final String lPARA_FONT;
  final Timestamp lPARA_TIMESTAMP;
  final String lPARA_WRITER;
  final String lPARA_CREATOR_URL;

  Paras(this.lPARA_TYPE, this.lPARA_DATA, this.lPARA_FONT, this.lPARA_TIMESTAMP,
      this.lPARA_WRITER, this.lPARA_CREATOR_URL);


  static List<Paras> getParaList(List<DocumentSnapshot> snapshot)
  {
   List<Paras> paraList = new List();
   for (int i = 0; i < snapshot.length; i++) {
     paraList.add(new Paras(
         snapshot[i][PARA_TYPE],
         snapshot[i][PARA_DATA],
         snapshot[i][PARA_FONT],
         snapshot[i][PARA_TIMESTAMP],
         snapshot[i][PARA_WRITER],
         snapshot[i][PARA_CREATOR_URL],
         ));
   }
   print('Paras.getParaList   '+paraList.length.toString());
   return paraList;
  }



}