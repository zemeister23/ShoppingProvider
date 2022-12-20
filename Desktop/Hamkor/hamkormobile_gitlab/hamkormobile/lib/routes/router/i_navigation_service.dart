abstract class INavigationService {
  // ABSTRACT METHOD
  Future pushNamed({required String routeName, Object? data});
  Future pushNamedRemoveUntil({required String routeName, Object? data});
  
}
