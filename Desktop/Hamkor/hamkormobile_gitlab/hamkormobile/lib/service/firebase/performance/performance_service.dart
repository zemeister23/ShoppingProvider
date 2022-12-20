// import 'package:firebase_performance/firebase_performance.dart';

class PerformanceService {
  static final PerformanceService _instance = PerformanceService._init();
  static PerformanceService get instance => _instance;
  PerformanceService._init();

  // FirebasePerformance performance = FirebasePerformance.instance;
  // Trace? _trace;
  Future<void> init(String nameTrace, bool isStart) async {
   // Trace _trace = performance.newTrace(nameTrace);
    
    if (isStart) {
   //   await _trace.start();
    } else {
  //    await _trace.stop();
    }
  }
}
