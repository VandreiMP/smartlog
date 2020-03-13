define(['dart_sdk', 'packages/path_provider_platform_interface/path_provider_platform_interface'], function(dart_sdk, packages__path_provider_platform_interface__path_provider_platform_interface) {
  'use strict';
  const core = dart_sdk.core;
  const io = dart_sdk.io;
  const async = dart_sdk.async;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  const path_provider_platform_interface = packages__path_provider_platform_interface__path_provider_platform_interface.path_provider_platform_interface;
  var path_provider = Object.create(dart.library);
  var $map = dartx.map;
  var $toList = dartx.toList;
  var StringToDirectory = () => (StringToDirectory = dart.constFn(dart.fnType(io.Directory, [core.String])))();
  var ListOfDirectory = () => (ListOfDirectory = dart.constFn(core.List$(io.Directory)))();
  const CT = Object.create(null);
  path_provider.getTemporaryDirectory = function getTemporaryDirectory() {
    return async.async(io.Directory, function* getTemporaryDirectory() {
      let path = (yield path_provider._platform.getTemporaryPath());
      if (path == null) {
        return null;
      }
      return io.Directory.new(path);
    });
  };
  path_provider.getApplicationSupportDirectory = function getApplicationSupportDirectory() {
    return async.async(io.Directory, function* getApplicationSupportDirectory() {
      let path = (yield path_provider._platform.getApplicationSupportPath());
      if (path == null) {
        return null;
      }
      return io.Directory.new(path);
    });
  };
  path_provider.getLibraryDirectory = function getLibraryDirectory() {
    return async.async(io.Directory, function* getLibraryDirectory() {
      let path = (yield path_provider._platform.getLibraryPath());
      if (path == null) {
        return null;
      }
      return io.Directory.new(path);
    });
  };
  path_provider.getApplicationDocumentsDirectory = function getApplicationDocumentsDirectory() {
    return async.async(io.Directory, function* getApplicationDocumentsDirectory() {
      let path = (yield path_provider._platform.getApplicationDocumentsPath());
      if (path == null) {
        return null;
      }
      return io.Directory.new(path);
    });
  };
  path_provider.getExternalStorageDirectory = function getExternalStorageDirectory() {
    return async.async(io.Directory, function* getExternalStorageDirectory() {
      let path = (yield path_provider._platform.getExternalStoragePath());
      if (path == null) {
        return null;
      }
      return io.Directory.new(path);
    });
  };
  path_provider.getExternalCacheDirectories = function getExternalCacheDirectories() {
    return async.async(ListOfDirectory(), function* getExternalCacheDirectories() {
      let paths = (yield path_provider._platform.getExternalCachePaths());
      return paths[$map](io.Directory, dart.fn(path => io.Directory.new(path), StringToDirectory()))[$toList]();
    });
  };
  path_provider.getExternalStorageDirectories = function getExternalStorageDirectories(opts) {
    let type = opts && 'type' in opts ? opts.type : null;
    return async.async(ListOfDirectory(), function* getExternalStorageDirectories() {
      let paths = (yield path_provider._platform.getExternalStoragePaths({type: type}));
      return paths[$map](io.Directory, dart.fn(path => io.Directory.new(path), StringToDirectory()))[$toList]();
    });
  };
  path_provider.getDownloadsDirectory = function getDownloadsDirectory() {
    return async.async(io.Directory, function* getDownloadsDirectory() {
      let path = (yield path_provider._platform.getDownloadsPath());
      if (path == null) {
        return null;
      }
      return io.Directory.new(path);
    });
  };
  dart.copyProperties(path_provider, {
    get _platform() {
      return path_provider_platform_interface.PathProviderPlatform.instance;
    }
  });
  dart.trackLibraries("packages/path_provider/path_provider", {
    "package:path_provider/path_provider.dart": path_provider
  }, {
  }, '{"version":3,"sourceRoot":"","sources":["path_provider.dart"],"names":[],"mappings":";;;;;;;;;;;;;;;AAyBuC;AACxB,kBAAO,MAAM,AAAU;AACpC,UAAI,AAAK,IAAD,IAAI;AACV,cAAO;;AAET,YAAO,kBAAU,IAAI;IACvB;;;AAYgD;AACjC,kBAAO,MAAM,AAAU;AACpC,UAAI,AAAK,IAAD,IAAI;AACV,cAAO;;AAGT,YAAO,kBAAU,IAAI;IACvB;;;AAOqC;AACtB,kBAAO,MAAM,AAAU;AACpC,UAAI,AAAK,IAAD,IAAI;AACV,cAAO;;AAET,YAAO,kBAAU,IAAI;IACvB;;;AAWkD;AACnC,kBAAO,MAAM,AAAU;AACpC,UAAI,AAAK,IAAD,IAAI;AACV,cAAO;;AAET,YAAO,kBAAU,IAAI;IACvB;;;AAU6C;AAC9B,kBAAO,MAAM,AAAU;AACpC,UAAI,AAAK,IAAD,IAAI;AACV,cAAO;;AAET,YAAO,kBAAU,IAAI;IACvB;;;AAemD;AAC9B,mBAAQ,MAAM,AAAU;AAE3C,YAAO,AAAM,AAAsC,MAAvC,qBAAK,QAAQ,QAAS,iBAAU,IAAI;IAClD;;;QAiBmB;AAHkC;AAKhC,mBACf,MAAM,AAAU,uDAA8B,IAAI;AAEtD,YAAO,AAAM,AAAsC,MAAvC,qBAAK,QAAQ,QAAS,iBAAU,IAAI;IAClD;;;AAOuC;AACxB,kBAAO,MAAM,AAAU;AACpC,UAAI,AAAK,IAAD,IAAI;AACV,cAAO;;AAET,YAAO,kBAAU,IAAI;IACvB;;;;AA3IsC,YAAqB;IAAQ","file":"path_provider.ddc.js"}');
  // Exports:
  return {
    path_provider: path_provider
  };
});

//# sourceMappingURL=path_provider.ddc.js.map
