class Images {
  static Images? _instance;
  Images._();
  static Images get instance{
    _instance??=  Images._();
    return _instance!;
   }

 static const logo = 'assets/images/logo.png';
 static const lanche = 'assets/images/lanche.png';
 static const loading = 'assets/images/loading.gif';

}