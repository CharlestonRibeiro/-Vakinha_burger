class Keys {
  static Keys? _instance;
  Keys._();
  static Keys get instance{
    _instance??=  Keys._();
    return _instance!;
   }

 static const accessToken = 'accessToken';
 static const refreshToken = 'refreshToken';

}