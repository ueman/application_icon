package de.ju.application_icon

import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ApplicationIconPlugin */
class ApplicationIconPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var iconLoader: AppIconLoader

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        iconLoader = AppIconLoader(flutterPluginBinding.applicationContext)
        channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "application_icon")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            when (call.method) {
                "hasAdaptiveIcon" -> result.success(iconLoader.hasAdaptiveIcon())
                "bitmapIcon" -> result.success(iconLoader.loadBitmapIcon())
                "adaptiveForeground" -> result.success(iconLoader.loadAdaptiveIconForeground())
                "adaptiveBackground" -> result.success(iconLoader.loadAdaptiveIconBackground())
            }
        } else {
            when (call.method) {
                "hasAdaptiveIcon" -> result.success(false)
                "bitmapIcon" -> result.success(iconLoader.loadBitmapIcon())
                "adaptiveForeground" -> result.notImplemented()
                "adaptiveBackground" -> result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
