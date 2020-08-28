import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// !!使用真机调试!!
/// !注意: 只要是返回Future的方法, 一律使用`await`修饰, 确保当前方法执行完成后再执行下一行, 在不能使用`await`修饰的环境下, 在`then`方法中执行下一步.
///
/// 初始化(0.17.0开始可以不用配置AndroidManifest.xml)
/// !!但是你如果你使用了amap_search_fluttify或amap_location_fluttify, 那么仍旧需要在AndroidManifest.xml中配置key!
/// AndroidManifest.xml配置key参考 https://lbs.amap.com/api/android-sdk/gettingstarted
//await AmapService.init(iosKey: '7a***********************f4', androidKey: '91911a3933be83e91b0dba5a1bf1b962');
///// 如果你觉得引擎的日志太多, 可以关闭Fluttify引擎的日志
//await enableFluttifyLog(false); // 关闭log

class AmapWidget extends StatefulWidget {
  @override
  AmapWidgetState createState() => AmapWidgetState();
}

class AmapWidgetState extends State<AmapWidget> {
  AmapController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AmapView(
        mapType: MapType.Standard,
        showZoomControl: false,
        maskDelay: Duration(milliseconds: 50),
        onMapCreated: (controller) async {
          _controller = controller;
//          _controller.setAllGesturesEnabled(false);
          _controller.setCenterCoordinate(LatLng(31.192794,120.942129));
          _controller.showMyLocation(MyLocationOption());
        },
      ),
    );
  }
}

extension on AmapController {
  /// 本方法只是演示了如何通过dart extension去实现一个功能.
  ///
  /// AmapController开放了内部的[androidController]和[iosController].
  /// 意味着插件使用者可以通过对[AmapController]进行扩展可以获得插件已提供能力之外的能力.
  /// 如果插件使用者觉得自行扩展的能力已经足够完善, 那么可以把这个扩展方法pr到主仓库合并进[AmapController]类.
  Future<LatLng> getLocationX() {
    final interval = const Duration(milliseconds: 500);
    final timeout = const Duration(seconds: 10);
    return platform(
      android: (pool) async {
        final map = await androidController.getMap();
        return Stream.periodic(interval, (_) => _)
            .asyncMap(
              (count) async {
            final coord = await map.getMyLocation();

            if (coord == null) {
              return null;
            } else {
              return LatLng(await coord.latitude, await coord.longitude);
            }
          },
        )
            .take(timeout.inMilliseconds ~/ interval.inMilliseconds)
            .firstWhere((location) => location != null)
            .timeout(timeout, onTimeout: () => null);
      },
      ios: (pool) {
        return Stream.periodic(interval, (_) => _)
            .asyncMap(
              (count) async {
            final location = await iosController.get_userLocation();
            final coord = await location.get_coordinate();

            if (coord == null) {
              return null;
            } else {
              return LatLng(await coord.latitude, await coord.longitude);
            }
          },
        )
            .take(timeout.inMilliseconds ~/ interval.inMilliseconds)
            .firstWhere((location) => location != null)
            .timeout(timeout, onTimeout: () => null);
      },
    );
  }
}

