define(['dart_sdk', 'packages/flutter/src/widgets/actions', 'packages/flutter/material', 'packages/flutter/src/painting/_network_image_web'], function(dart_sdk, packages__flutter__src__widgets__actions, packages__flutter__material, packages__flutter__src__painting___network_image_web) {
  'use strict';
  const core = dart_sdk.core;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  const framework = packages__flutter__src__widgets__actions.src__widgets__framework;
  const container = packages__flutter__src__widgets__actions.src__widgets__container;
  const widget_inspector = packages__flutter__src__widgets__actions.src__widgets__widget_inspector;
  const colors = packages__flutter__material.src__material__colors;
  const alignment = packages__flutter__src__painting___network_image_web.src__painting__alignment;
  var body = Object.create(dart.library);
  const CT = Object.create(null);
  dart.defineLazy(CT, {
    get C2() {
      return C2 = dart.const({
        __proto__: widget_inspector._Location.prototype,
        [_Location_parameterLocations]: null,
        [_Location_name]: "color",
        [_Location_column]: 7,
        [_Location_line]: 12,
        [_Location_file]: null
      });
    },
    get C3() {
      return C3 = dart.const({
        __proto__: widget_inspector._Location.prototype,
        [_Location_parameterLocations]: null,
        [_Location_name]: "alignment",
        [_Location_column]: 7,
        [_Location_line]: 13,
        [_Location_file]: null
      });
    },
    get C1() {
      return C1 = dart.constList([C2 || CT.C2, C3 || CT.C3], widget_inspector._Location);
    },
    get C0() {
      return C0 = dart.const({
        __proto__: widget_inspector._Location.prototype,
        [_Location_parameterLocations]: C1 || CT.C1,
        [_Location_name]: null,
        [_Location_column]: 12,
        [_Location_line]: 11,
        [_Location_file]: "org-dartlang-app:///packages/smartlogproject/Components/body.dart"
      });
    }
  });
  body.Body = class Body extends framework.StatefulWidget {
    createState() {
      return new body._BodyState.new();
    }
  };
  (body.Body.new = function(opts) {
    let $36creationLocationd_0dea112b090073317d4 = opts && '$creationLocationd_0dea112b090073317d4' in opts ? opts.$creationLocationd_0dea112b090073317d4 : null;
    body.Body.__proto__.new.call(this, {$creationLocationd_0dea112b090073317d4: $36creationLocationd_0dea112b090073317d4});
    ;
  }).prototype = body.Body.prototype;
  dart.addTypeTests(body.Body);
  dart.setMethodSignature(body.Body, () => ({
    __proto__: dart.getMethods(body.Body.__proto__),
    createState: dart.fnType(body._BodyState, [])
  }));
  dart.setLibraryUri(body.Body, "package:smartlogproject/Components/body.dart");
  var _Location_parameterLocations = dart.privateName(widget_inspector, "_Location.parameterLocations");
  var _Location_name = dart.privateName(widget_inspector, "_Location.name");
  var _Location_column = dart.privateName(widget_inspector, "_Location.column");
  var _Location_line = dart.privateName(widget_inspector, "_Location.line");
  var _Location_file = dart.privateName(widget_inspector, "_Location.file");
  var C2;
  var C3;
  var C1;
  var C0;
  body._BodyState = class _BodyState extends framework.State$(body.Body) {
    build(context) {
      return new container.Container.new({color: colors.Colors.red, alignment: alignment.Alignment.center, $creationLocationd_0dea112b090073317d4: C0 || CT.C0});
    }
  };
  (body._BodyState.new = function() {
    body._BodyState.__proto__.new.call(this);
    ;
  }).prototype = body._BodyState.prototype;
  dart.addTypeTests(body._BodyState);
  dart.setMethodSignature(body._BodyState, () => ({
    __proto__: dart.getMethods(body._BodyState.__proto__),
    build: dart.fnType(framework.Widget, [framework.BuildContext])
  }));
  dart.setLibraryUri(body._BodyState, "package:smartlogproject/Components/body.dart");
  dart.trackLibraries("packages/smartlogproject/Components/body", {
    "package:smartlogproject/Components/body.dart": body
  }, {
  }, '{"version":3,"sourceRoot":"","sources":["body.dart"],"names":[],"mappings":";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;AAI8B;IAAY;;;;;;EAC1C;;;;;;;;;;;;;;;;;UAI4B;AACxB,YAAO,qCACS,8BACO;IAEzB;;;;;EACF","file":"body.ddc.js"}');
  // Exports:
  return {
    Components__body: body
  };
});

//# sourceMappingURL=body.ddc.js.map
