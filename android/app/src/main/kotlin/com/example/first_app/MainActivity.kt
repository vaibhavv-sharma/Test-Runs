package com.example.first_app

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

private const val kChannel = 'flavor'
private const val kMethodFlavor = 'getFlavor'

class MainActivity: FlutterActivity() {
    override fun configFlutterEngine(@NonNull FlutterEngine: FlutterEngine){
        GeneratedPluginRegistrant.registerWith(FlutterEngine);
        MethodChannel(FlutterEngine.dartExecutor.binaryMessenger, kChannel).setMethodCallHandler {
            call, result ->
            if(call.method == kMethodFlavor) {
                result.success(BuildConfig.FLAVOR)
            }
        }        

    }
}
