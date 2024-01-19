
import 'package:flutter/cupertino.dart';


class CreateEnvironmentProvider with ChangeNotifier{

  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}
