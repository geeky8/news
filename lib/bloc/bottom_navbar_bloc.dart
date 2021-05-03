import 'dart:async';


enum NavbarItem{HOME,SOURCES,SEARCH}

class BottomNavBarBloc{
  final StreamController<NavbarItem> _navBarController =
      StreamController<NavbarItem>.broadcast();
  NavbarItem defaultItem = NavbarItem.HOME;

  Stream<NavbarItem> get itemStream => _navBarController.stream;

  void pickItem(int i){
    switch(i){
      case 0 :
        _navBarController.sink.add(NavbarItem.HOME);
        break;
      case 1 :
        _navBarController.sink.add(NavbarItem.SOURCES);
        break;
      case 2 :
        _navBarController.sink.add(NavbarItem.SEARCH);
        break;
    }
  }

  close(){
    _navBarController?.close();
  }
}