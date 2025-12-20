class BtDevicesClassifier {
  static final Set<String> printerServices = {
    "1101", // Serial Port Profile (SPP)
  };

  static final Set<String> audioServices = {
    "110a", // Audio Source
    "110b", // Audio Sink
    "110c", // A/V Remote Target
    "110e", // A/V Remote
    "110f", // A/V Remote Controller
    "111e", // Handsfree
    "1108", // Headset
    "1112", // Headset Audio Gateway
  };

  static final Set<String> inputServices = {
    "1124", // HID
  };

  static final Set<String> phoneServices = {
    "112f", // PBAP
    "1132", // MAP
    "1133", // Message Notification
  };

  static final Set<String> networkServices = {
    "1115", // PAN User
    "1116", // PAN NAP
    "1117", // PAN Group
  };

  static final Set<String> fileTransferServices = {
    "1105", // OBEX Object Push
    "1106", // OBEX File Transfer
  };

  static String? _extractServiceId(String uuid) {
    // example of device uid "00001101-0000-1000-8000-00805f9b34fb"
    //this is bt standers to find printer
    final String printersUuidSegment = "00805f9b34fb";
    final List<String> u = uuid.toLowerCase().split("-");

    if (u.last != printersUuidSegment) return null;
    //this serviceId from the first device uuid segments 4 bytes
    final String serviceId = u.first.substring(4, 8);
    return serviceId;
  }

  static DeviceType classifyByUuids(List<String>? uuids) {
    if (uuids == null || uuids.isEmpty) {
      return DeviceType.unknown;
    }

    final serviceIds = <String>{};

    for (final uuid in uuids) {
      final id = _extractServiceId(uuid);
      if (id != null) {
        serviceIds.add(id);
      }
    }

    // Order matters (reject non-printers first)
    if (serviceIds.any(audioServices.contains)) {
      return DeviceType.audio;
    }

    if (serviceIds.any(inputServices.contains)) {
      return DeviceType.input;
    }

    if (serviceIds.any(phoneServices.contains)) {
      return DeviceType.phone;
    }

    if (serviceIds.any(networkServices.contains)) {
      return DeviceType.network;
    }

    if (serviceIds.any(fileTransferServices.contains)) {
      return DeviceType.fileTransfer;
    }

    if (serviceIds.any(printerServices.contains)) {
      return DeviceType.printer;
    }

    return DeviceType.unknown;
  }
}

enum DeviceType {
  printer,
  audio,
  input,
  phone,
  network,
  fileTransfer,
  unknown,
}
