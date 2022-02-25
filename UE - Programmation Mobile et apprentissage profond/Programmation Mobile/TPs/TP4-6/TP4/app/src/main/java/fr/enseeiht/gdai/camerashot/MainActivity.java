package fr.enseeiht.gdai.camerashot;

import android.os.Bundle;

import android.app.Activity;
import android.widget.FrameLayout;

public class MainActivity extends Activity {
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        cameraPreview mPreview = new cameraPreview(this);
        FrameLayout preview = (FrameLayout) findViewById(R.id.cameraPreviewLayout);
        preview.addView(mPreview);
    }
}