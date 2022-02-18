import 'package:logger/logger.dart'
    show AnsiColor, LogEvent, LogPrinter, Logger, PrettyPrinter;

Logger getLogger1(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}

Logger getLogger(String className) {
  return Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        /* methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true*/
        ),
  );
}

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    AnsiColor color = PrettyPrinter.levelColors[event.level];
    String emoji = PrettyPrinter.levelEmojis[event.level];
    return [color('$emoji [$className]: ${event.message}')];
  }
}
