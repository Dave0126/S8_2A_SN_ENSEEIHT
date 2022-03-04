package fr.enseeiht.gdai.camerashot;

import android.hardware.Camera;
import android.net.Uri;
import android.os.Bundle;

import android.app.Activity;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class MainActivity extends Activity {
    private static final String TAG_CAMERA = "Camera";
    private static final String TAG_FILE = "File";
    private static final String TAG = "TAG";
    private Camera mCamera;
    private cameraPreview mPreview;
    private ImageView showImage;
    private Uri imageUri; //圖片路徑
    private String filename; //圖片名稱


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mCamera = getCameraInstance();

        mPreview = new cameraPreview(this,mCamera);
        FrameLayout preview = (FrameLayout) findViewById(R.id.cameraPreviewLayout);
        preview.addView(mPreview);


        Button takePhoto = (Button) findViewById(R.id.button);
        takePhoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // get an image from the camera
                mCamera.takePicture(null, null, mPicture);
            }
        });

        showImage = (ImageView) findViewById(R.id.imageView);

    }
    @Override
    protected void onPause()
    {
        super.onPause();
        if( mCamera != null )
        {
            mCamera.release(); // release the camera for other applications
            mCamera = null;
        }
    }
    @Override
    protected void onResume()
    {
        super.onResume();
        mCamera = getCameraInstance();
        mPreview = new cameraPreview( this, mCamera );
        FrameLayout preview = (FrameLayout) findViewById( R.id.cameraPreviewLayout );
        preview.addView( mPreview );
    }

    private Camera getCameraInstance() {
        Camera c = null;
        try {
            c = Camera.open();
        } catch (Exception e) {
            Log.d(TAG_CAMERA, "camera is not available");
        }
        return c;
    }

    private Camera.PictureCallback mPicture = new Camera.PictureCallback() {

        public static final int MEDIA_TYPE_IMAGE = 1;
        public static final int MEDIA_TYPE_VIDEO = 2;

        /** Create a file Uri for saving an image or video */
        private Uri getOutputMediaFileUri(int type){
            return Uri.fromFile(getOutputMediaFile(type));
        }

        /** Create a File for saving an image or video */
        private File getOutputMediaFile(int type){
            // To be safe, you should check that the SDCard is mounted
            // using Environment.getExternalStorageState() before doing this.

            File mediaStorageDir = new File(Environment.getExternalStoragePublicDirectory(
                    Environment.DIRECTORY_PICTURES), "MyCameraApp");
            // This location works best if you want the created images to be shared
            // between applications and persist after your app has been uninstalled.

            // Create the storage directory if it does not exist
            if (! mediaStorageDir.exists()){
                if (! mediaStorageDir.mkdirs()){
                    Log.d("MyCameraApp", "failed to create directory");
                    return null;
                }
            }

            // Create a media file name
            String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
            File mediaFile;
            if (type == MEDIA_TYPE_IMAGE){
                mediaFile = new File(mediaStorageDir.getPath() + File.separator +
                        "IMG_"+ timeStamp + ".jpg");
            } else if(type == MEDIA_TYPE_VIDEO) {
                mediaFile = new File(mediaStorageDir.getPath() + File.separator +
                        "VID_"+ timeStamp + ".mp4");
            } else {
                return null;
            }

            return mediaFile;
        }
        @Override
        public void onPictureTaken(byte[] data, Camera camera) {

            File pictureFile = getOutputMediaFile(MEDIA_TYPE_IMAGE);
            if (pictureFile == null){
                Log.d(TAG_FILE, "Error creating media file, check storage permissions");
                return;
            }

            try {
                FileOutputStream fos = new FileOutputStream(pictureFile);
                fos.write(data);
                fos.close();
            } catch (FileNotFoundException e) {
                Log.d(TAG_FILE, "File not found: " + e.getMessage());
            } catch (IOException e) {
                Log.d(TAG_FILE, "Error accessing file: " + e.getMessage());
            }
        }
    };
}