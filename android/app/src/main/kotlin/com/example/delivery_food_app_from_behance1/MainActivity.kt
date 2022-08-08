package com.example.delivery_food_app_from_behance1

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("ru") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("d2fda3ea-f495-4d7b-aa53-84721de9ed90") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
