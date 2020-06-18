import 'dart:async';

class ResendOtpTimer {
  ResendOtpTimer({int duration}) : _duration = duration ?? 30;
  final int _duration;
  Timer _timer;
  int _runningTime = 0;
  bool _isStarted = false;
  StreamController<int> _timerStream;

  Stream<int> get resendOtpStates {
    return _timerStream.stream;
  }

  void start() {
    if (!_isStarted) {
      _timerStream = StreamController<int>();
      _isStarted = true;

      
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        final time = _duration - _runningTime;
        if (time == 0) {
          _timerStream.add(0);
          stop();
          return;
        } else {
          _timerStream
              .add(time);
        }
        _runningTime++;
      });
    }
  }

  void stop() {
    if (_timer != null) {
      _timer.cancel();
    }
    _isStarted = false;
    _runningTime = 0;
    _timerStream.close();
  }

  void dispode() {
    stop();
    _timerStream.close();
  }
}
