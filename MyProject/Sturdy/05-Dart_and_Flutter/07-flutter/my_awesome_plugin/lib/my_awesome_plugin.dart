
import 'my_awesome_plugin_platform_interface.dart';

class MyAwesomePlugin {
  Future<String?> getPlatformVersion() {
    return MyAwesomePluginPlatform.instance.getPlatformVersion();
  }
}
