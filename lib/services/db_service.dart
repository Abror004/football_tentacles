import 'package:hive/hive.dart';


class _StorageKeys {
  static const SOUND = 'SOUND';
  static const VIBRATION = 'VIBRATION';
  static const LEVEL1 = 'LEVEL1';
  static const LEVEL2 = 'LEVEL2';
  static const LEVEL3 = 'LEVEL3';

}
class DBService{

  static String DB_NAME = "puzzle_game";
  static Box box = Hive.box(DB_NAME);

  static Future<void>storeSound(bool soundActive)async{
    await box.put(_StorageKeys.SOUND,soundActive);
  }

  static Future<bool>getSound()async{
    return box.get(_StorageKeys.SOUND,defaultValue: true);
  }

  static Future<void>storeVibration(bool vibrationActive)async{
    await box.put(_StorageKeys.SOUND,vibrationActive);
  }

  static Future<bool>getVibration()async{
    return box.get(_StorageKeys.VIBRATION,defaultValue: true);
  }

  static Future<void> storeLevel1(Map<String,bool> level1)async{
    await box.put(_StorageKeys.LEVEL1, level1);
  }

  static Future< dynamic> getLevel1()async{
    print("-------------------------------------------------->");
    print(box.get(_StorageKeys.LEVEL1,defaultValue:null));
    var map =await box.get(_StorageKeys.LEVEL1,defaultValue:null);
    return map ;
  }

  static deleteLevel1(){
    box.delete(_StorageKeys.LEVEL1);
  }

}