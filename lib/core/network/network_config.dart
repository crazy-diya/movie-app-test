class IPAddress {
  static const String dev = "";
}

class ServiceProtocol {
  static const String dev = "";
}

class ContextRoot {
  static const String dev = "";
}

class NetworkConfig {
  static String getNetworkConfig() {
    return _getServiceProtocol() + _getIpAddress() + _getContextRoot();
  }

  static String _getIpAddress() {
    return IPAddress.dev;
  }

  static String _getContextRoot() {
    return ContextRoot.dev;
  }

  static String _getServiceProtocol() {
    return ContextRoot.dev;
  }
}