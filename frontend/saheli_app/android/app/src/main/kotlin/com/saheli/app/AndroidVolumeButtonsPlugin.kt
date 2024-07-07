package com.saheli.app

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class AndroidVolumeButtonsPlugin : FlutterPlugin, EventChannel.StreamHandler {
    private lateinit var applicationContext: Context
    private lateinit var eventSink: EventChannel.EventSink

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        val methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_volume_buttons")
        val eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "android_volume_buttons_events")
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "setAccelerationSamplingPeriod" -> result.notImplemented() // Handle this if needed
                else -> result.notImplemented()
            }
        }
        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events ?: return
        val volumeChangeReceiver = VolumeChangeReceiver()
        val filter = IntentFilter()
        filter.addAction("android.media.VOLUME_CHANGED_ACTION")
        applicationContext.registerReceiver(volumeChangeReceiver, filter)
    }

    override fun onCancel(arguments: Any?) {
        applicationContext.unregisterReceiver(VolumeChangeReceiver())
    }

    private inner class VolumeChangeReceiver : android.content.BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == "android.media.VOLUME_CHANGED_ACTION") {
                val audioManager = context?.getSystemService(Context.AUDIO_SERVICE) as AudioManager
                val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
                eventSink.success(currentVolume)
            }
        }
    }
}
