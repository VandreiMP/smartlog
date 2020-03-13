define(['dart_sdk', 'packages/plugin_platform_interface/plugin_platform_interface', 'packages/flutter/src/gestures/arena', 'packages/platform/platform'], function(dart_sdk, packages__plugin_platform_interface__plugin_platform_interface, packages__flutter__src__gestures__arena, packages__platform__platform) {
  'use strict';
  const core = dart_sdk.core;
  const async = dart_sdk.async;
  const _js_helper = dart_sdk._js_helper;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  const plugin_platform_interface = packages__plugin_platform_interface__plugin_platform_interface.plugin_platform_interface;
  const platform_channel = packages__flutter__src__gestures__arena.src__services__platform_channel;
  const local_platform = packages__platform__platform.src__interface__local_platform;
  const platform = packages__platform__platform.src__interface__platform;
  var path_provider_platform_interface = Object.create(dart.library);
  var enums = Object.create(dart.library);
  var method_channel_path_provider = Object.create(dart.library);
  var IdentityMapOfString$dynamic = () => (IdentityMapOfString$dynamic = dart.constFn(_js_helper.IdentityMap$(core.String, dart.dynamic)))();
  var ListOfString = () => (ListOfString = dart.constFn(core.List$(core.String)))();
  const CT = Object.create(null);
  dart.defineLazy(CT, {
    get C0() {
      return C0 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.music",
        index: 0
      });
    },
    get C1() {
      return C1 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.podcasts",
        index: 1
      });
    },
    get C2() {
      return C2 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.ringtones",
        index: 2
      });
    },
    get C3() {
      return C3 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.alarms",
        index: 3
      });
    },
    get C4() {
      return C4 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.notifications",
        index: 4
      });
    },
    get C5() {
      return C5 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.pictures",
        index: 5
      });
    },
    get C6() {
      return C6 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.movies",
        index: 6
      });
    },
    get C7() {
      return C7 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.downloads",
        index: 7
      });
    },
    get C8() {
      return C8 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.dcim",
        index: 8
      });
    },
    get C9() {
      return C9 = dart.const({
        __proto__: enums.StorageDirectory.prototype,
        [_name$]: "StorageDirectory.documents",
        index: 9
      });
    },
    get C10() {
      return C10 = dart.constList([C0 || CT.C0, C1 || CT.C1, C2 || CT.C2, C3 || CT.C3, C4 || CT.C4, C5 || CT.C5, C6 || CT.C6, C7 || CT.C7, C8 || CT.C8, C9 || CT.C9], enums.StorageDirectory);
    },
    get C11() {
      return C11 = dart.const({
        __proto__: local_platform.LocalPlatform.prototype
      });
    }
  });
  path_provider_platform_interface.PathProviderPlatform = class PathProviderPlatform extends plugin_platform_interface.PlatformInterface {
    static get instance() {
      return path_provider_platform_interface.PathProviderPlatform._instance;
    }
    static set instance(instance) {
      plugin_platform_interface.PlatformInterface.verifyToken(instance, path_provider_platform_interface.PathProviderPlatform._token);
      path_provider_platform_interface.PathProviderPlatform._instance = instance;
    }
    getTemporaryPath() {
      dart.throw(new core.UnimplementedError.new("getTemporaryPath() has not been implemented."));
    }
    getApplicationSupportPath() {
      dart.throw(new core.UnimplementedError.new("getApplicationSupportPath() has not been implemented."));
    }
    getLibraryPath() {
      dart.throw(new core.UnimplementedError.new("getLibraryPath() has not been implemented."));
    }
    getApplicationDocumentsPath() {
      dart.throw(new core.UnimplementedError.new("getApplicationDocumentsPath() has not been implemented."));
    }
    getExternalStoragePath() {
      dart.throw(new core.UnimplementedError.new("getExternalStoragePath() has not been implemented."));
    }
    getExternalCachePaths() {
      dart.throw(new core.UnimplementedError.new("getExternalCachePaths() has not been implemented."));
    }
    getExternalStoragePaths(opts) {
      let type = opts && 'type' in opts ? opts.type : null;
      dart.throw(new core.UnimplementedError.new("getExternalStoragePaths() has not been implemented."));
    }
    getDownloadsPath() {
      dart.throw(new core.UnimplementedError.new("getDownloadsPath() has not been implemented."));
    }
  };
  (path_provider_platform_interface.PathProviderPlatform.new = function() {
    path_provider_platform_interface.PathProviderPlatform.__proto__.new.call(this, {token: path_provider_platform_interface.PathProviderPlatform._token});
    ;
  }).prototype = path_provider_platform_interface.PathProviderPlatform.prototype;
  dart.addTypeTests(path_provider_platform_interface.PathProviderPlatform);
  dart.setMethodSignature(path_provider_platform_interface.PathProviderPlatform, () => ({
    __proto__: dart.getMethods(path_provider_platform_interface.PathProviderPlatform.__proto__),
    getTemporaryPath: dart.fnType(async.Future$(core.String), []),
    getApplicationSupportPath: dart.fnType(async.Future$(core.String), []),
    getLibraryPath: dart.fnType(async.Future$(core.String), []),
    getApplicationDocumentsPath: dart.fnType(async.Future$(core.String), []),
    getExternalStoragePath: dart.fnType(async.Future$(core.String), []),
    getExternalCachePaths: dart.fnType(async.Future$(core.List$(core.String)), []),
    getExternalStoragePaths: dart.fnType(async.Future$(core.List$(core.String)), [], {type: enums.StorageDirectory}, {}),
    getDownloadsPath: dart.fnType(async.Future$(core.String), [])
  }));
  dart.setLibraryUri(path_provider_platform_interface.PathProviderPlatform, "package:path_provider_platform_interface/path_provider_platform_interface.dart");
  dart.defineLazy(path_provider_platform_interface.PathProviderPlatform, {
    /*path_provider_platform_interface.PathProviderPlatform._token*/get _token() {
      return new core.Object.new();
    },
    /*path_provider_platform_interface.PathProviderPlatform._instance*/get _instance() {
      return new method_channel_path_provider.MethodChannelPathProvider.new();
    },
    set _instance(_) {}
  });
  var _name$ = dart.privateName(enums, "_name");
  var C0;
  var C1;
  var C2;
  var C3;
  var C4;
  var C5;
  var C6;
  var C7;
  var C8;
  var C9;
  var C10;
  enums.StorageDirectory = class StorageDirectory extends core.Object {
    toString() {
      return this[_name$];
    }
  };
  (enums.StorageDirectory.new = function(index, _name) {
    this.index = index;
    this[_name$] = _name;
    ;
  }).prototype = enums.StorageDirectory.prototype;
  dart.addTypeTests(enums.StorageDirectory);
  dart.setLibraryUri(enums.StorageDirectory, "package:path_provider_platform_interface/src/enums.dart");
  dart.setFieldSignature(enums.StorageDirectory, () => ({
    __proto__: dart.getFields(enums.StorageDirectory.__proto__),
    index: dart.finalFieldType(core.int),
    [_name$]: dart.finalFieldType(core.String)
  }));
  dart.defineExtensionMethods(enums.StorageDirectory, ['toString']);
  enums.StorageDirectory.music = C0 || CT.C0;
  enums.StorageDirectory.podcasts = C1 || CT.C1;
  enums.StorageDirectory.ringtones = C2 || CT.C2;
  enums.StorageDirectory.alarms = C3 || CT.C3;
  enums.StorageDirectory.notifications = C4 || CT.C4;
  enums.StorageDirectory.pictures = C5 || CT.C5;
  enums.StorageDirectory.movies = C6 || CT.C6;
  enums.StorageDirectory.downloads = C7 || CT.C7;
  enums.StorageDirectory.dcim = C8 || CT.C8;
  enums.StorageDirectory.documents = C9 || CT.C9;
  enums.StorageDirectory.values = C10 || CT.C10;
  var _platform = dart.privateName(method_channel_path_provider, "_platform");
  var C11;
  var methodChannel = dart.privateName(method_channel_path_provider, "MethodChannelPathProvider.methodChannel");
  method_channel_path_provider.MethodChannelPathProvider = class MethodChannelPathProvider extends path_provider_platform_interface.PathProviderPlatform {
    get methodChannel() {
      return this[methodChannel];
    }
    set methodChannel(value) {
      this[methodChannel] = value;
    }
    setMockPathProviderPlatform(platform) {
      this[_platform] = platform;
    }
    getTemporaryPath() {
      return this.methodChannel.invokeMethod(core.String, "getTemporaryDirectory");
    }
    getApplicationSupportPath() {
      return this.methodChannel.invokeMethod(core.String, "getApplicationSupportDirectory");
    }
    getLibraryPath() {
      if (!dart.test(this[_platform].isIOS) && !dart.test(this[_platform].isMacOS)) {
        dart.throw(new core.UnsupportedError.new("Functionality only available on iOS/macOS"));
      }
      return this.methodChannel.invokeMethod(core.String, "getLibraryDirectory");
    }
    getApplicationDocumentsPath() {
      return this.methodChannel.invokeMethod(core.String, "getApplicationDocumentsDirectory");
    }
    getExternalStoragePath() {
      if (!dart.test(this[_platform].isAndroid)) {
        dart.throw(new core.UnsupportedError.new("Functionality only available on Android"));
      }
      return this.methodChannel.invokeMethod(core.String, "getStorageDirectory");
    }
    getExternalCachePaths() {
      if (!dart.test(this[_platform].isAndroid)) {
        dart.throw(new core.UnsupportedError.new("Functionality only available on Android"));
      }
      return this.methodChannel.invokeListMethod(core.String, "getExternalCacheDirectories");
    }
    getExternalStoragePaths(opts) {
      let type = opts && 'type' in opts ? opts.type : null;
      return async.async(ListOfString(), (function* getExternalStoragePaths() {
        let t0;
        if (!dart.test(this[_platform].isAndroid)) {
          dart.throw(new core.UnsupportedError.new("Functionality only available on Android"));
        }
        return this.methodChannel.invokeListMethod(core.String, "getExternalStorageDirectories", new (IdentityMapOfString$dynamic()).from(["type", (t0 = type, t0 == null ? null : t0.index)]));
      }).bind(this));
    }
    getDownloadsPath() {
      if (!dart.test(this[_platform].isMacOS)) {
        dart.throw(new core.UnsupportedError.new("Functionality only available on macOS"));
      }
      return this.methodChannel.invokeMethod(core.String, "getDownloadsDirectory");
    }
  };
  (method_channel_path_provider.MethodChannelPathProvider.new = function() {
    this[methodChannel] = new platform_channel.MethodChannel.new("plugins.flutter.io/path_provider");
    this[_platform] = C11 || CT.C11;
    method_channel_path_provider.MethodChannelPathProvider.__proto__.new.call(this);
    ;
  }).prototype = method_channel_path_provider.MethodChannelPathProvider.prototype;
  dart.addTypeTests(method_channel_path_provider.MethodChannelPathProvider);
  dart.setMethodSignature(method_channel_path_provider.MethodChannelPathProvider, () => ({
    __proto__: dart.getMethods(method_channel_path_provider.MethodChannelPathProvider.__proto__),
    setMockPathProviderPlatform: dart.fnType(dart.void, [platform.Platform])
  }));
  dart.setLibraryUri(method_channel_path_provider.MethodChannelPathProvider, "package:path_provider_platform_interface/src/method_channel_path_provider.dart");
  dart.setFieldSignature(method_channel_path_provider.MethodChannelPathProvider, () => ({
    __proto__: dart.getFields(method_channel_path_provider.MethodChannelPathProvider.__proto__),
    methodChannel: dart.fieldType(platform_channel.MethodChannel),
    [_platform]: dart.fieldType(platform.Platform)
  }));
  dart.trackLibraries("packages/path_provider_platform_interface/path_provider_platform_interface", {
    "package:path_provider_platform_interface/path_provider_platform_interface.dart": path_provider_platform_interface,
    "package:path_provider_platform_interface/src/enums.dart": enums,
    "package:path_provider_platform_interface/src/method_channel_path_provider.dart": method_channel_path_provider
  }, {
  }, '{"version":3,"sourceRoot":"","sources":["path_provider_platform_interface.dart","src/enums.dart","src/method_channel_path_provider.dart"],"names":[],"mappings":";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;AA+B8C;IAAS;wBAIZ;AACQ,MAA7B,wDAAY,QAAQ,EAAE;AACpB,MAApB,kEAAY,QAAQ;IACtB;;AAK0E,MAAxE,WAAM,gCAAmB;IAC3B;;AAM8D,MAD5D,WAAM,gCACF;IACN;;AAKwE,MAAtE,WAAM,gCAAmB;IAC3B;;AAMgE,MAD9D,WAAM,gCACF;IACN;;AAO2D,MADzD,WAAM,gCACF;IACN;;AAQ0D,MADxD,WAAM,gCACF;IACN;;UAQmB;AAGyC,MAD1D,WAAM,gCACF;IACN;;AAK0E,MAAxE,WAAM,gCAAmB;IAC3B;;;AA7EyB,2FAAa;;EAAO;;;;;;;;;;;;;;;MAEzB,4DAAM;YAAG;;MAED,+DAAS;YAAG;;;;;;;;;;;;;;;;;;;ICsB1C;;gDA7CK;;;;EA6CL;;;;;;;;;;;;;;;;;;;;;;;;IC/BgB;;;;;;gCAW4B;AACpB,MAApB,kBAAY,QAAQ;IACtB;;AAGE,YAAO,AAAc,8CAAqB;IAC5C;;AAGE,YAAO,AAAc,8CAAqB;IAC5C;;AAGE,qBAAK,AAAU,qCAAU,AAAU;AACkC,QAAnE,WAAM,8BAAiB;;AAEzB,YAAO,AAAc,8CAAqB;IAC5C;;AAGE,YAAO,AACF,8CAAqB;IAC5B;;AAGE,qBAAK,AAAU;AACoD,QAAjE,WAAM,8BAAiB;;AAEzB,YAAO,AAAc,8CAAqB;IAC5C;;AAGE,qBAAK,AAAU;AACoD,QAAjE,WAAM,8BAAiB;;AAEzB,YAAO,AACF,kDAAyB;IAChC;;UAGmB;AADyB;;AAG1C,uBAAK,AAAU;AACoD,UAAjE,WAAM,8BAAiB;;AAEzB,cAAO,AAAc,kDACnB,iCACiB,0CAAC,cAAQ,IAAI,eAAJ,OAAM;MAEpC;;;AAGE,qBAAK,AAAU;AACkD,QAA/D,WAAM,8BAAiB;;AAEzB,YAAO,AAAc,8CAAqB;IAC5C;;;IAnEc,sBACV,uCAAc;IAKT;;;EA8DX","file":"path_provider_platform_interface.ddc.js"}');
  // Exports:
  return {
    path_provider_platform_interface: path_provider_platform_interface,
    src__enums: enums,
    src__method_channel_path_provider: method_channel_path_provider
  };
});

//# sourceMappingURL=path_provider_platform_interface.ddc.js.map
