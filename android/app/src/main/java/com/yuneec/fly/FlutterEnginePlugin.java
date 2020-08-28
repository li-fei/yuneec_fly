package com.yuneec.fly;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FlutterEnginePlugin implements MethodChannel.MethodCallHandler {
    private static final String CHANNEL = "com.yuneec.fly";

    static public void registerWith(FlutterEngine flutterEngine) {
        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL);
        channel.setMethodCallHandler(new FlutterEnginePlugin());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("isChinese")) {
            boolean isChinese = true;
            result.success(isChinese);
        } else if (call.method.equals("yuneecFly")) {
            result.success("yuneecFly");
        } else {
            result.notImplemented();
        }
    }

}
