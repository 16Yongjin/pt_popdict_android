package com.example.pt_popdic;

import android.content.Intent;
import android.os.Bundle;

import java.nio.ByteBuffer;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.ActivityLifecycleListener;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class DictActivity extends FlutterActivity {

  private String sharedText;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    FlutterView view = getFlutterView();

    view.enableTransparentBackground();

    // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
    // Window w = getWindow();
    // w.setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
    // }

    Intent intent = getIntent();
    String action = intent.getAction();
    String type = intent.getType();

    // System.out.println("action");
    // System.out.println(action);
    // System.out.println(Intent.EXTRA_PROCESS_TEXT);
    // System.out.println(Intent.ACTION_SEND);
    
    if (type != null && "text/plain".equals(type)) {
      if (Intent.ACTION_PROCESS_TEXT.equals(action)) {
        handleSendText(intent, Intent.EXTRA_PROCESS_TEXT);
      } else if (Intent.ACTION_SEND.equals(action)) {
        handleSendText(intent, Intent.EXTRA_TEXT);
      }
    }

    new MethodChannel(getFlutterView(), "app.channel.shared.data").setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, MethodChannel.Result result) {
          if (call.method.contentEquals("getSharedText")) {
            result.success(sharedText);
            sharedText = null;
          }
        }
      });
  }

  void handleSendText(Intent intent, String action) {
    sharedText = intent.getStringExtra(action);
    System.out.println(sharedText);

  }
}
