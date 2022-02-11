package fr.enseeiht.gdai.videoplayer;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.database.Cursor;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.VideoView;

public class MainActivity extends AppCompatActivity {
    private Button btnSelect;
    private Button btnPlay;
    private Button btnRestart;
    private Button btnPause;
    private TextView URIPath;

    private SurfaceView surfaceView;
    private SurfaceHolder surfaceHolder;
    private MediaPlayer mediaPlayer;
    // private VideoView videoView;

    private Uri selectVideo;

    private static final int SELECT_VIDEO = 100;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnSelect = (Button) findViewById(R.id.btnSelect);
        btnPlay = (Button) findViewById(R.id.btnPlay);
        btnRestart = (Button) findViewById(R.id.btnRestart);
        btnPause = (Button) findViewById(R.id.btnPause);
        URIPath = (TextView) findViewById(R.id.tvURIPath);

        surfaceView = (SurfaceView) findViewById(R.id.surfaceView);
        surfaceHolder = surfaceView.getHolder();
        surfaceHolder.setKeepScreenOn(true);
        surfaceHolder.addCallback(new SurfaceHolder.Callback() {
            @Override
            public void surfaceCreated(@NonNull SurfaceHolder surfaceHolder) {
                readyPlay();
            }


            @Override
            public void surfaceChanged(@NonNull SurfaceHolder surfaceHolder, int i, int i1, int i2) {

            }

            @Override
            public void surfaceDestroyed(@NonNull SurfaceHolder surfaceHolder) {

            }
        });
        mediaPlayer = new MediaPlayer();
        mediaPlayer.setOnVideoSizeChangedListener(new MediaPlayer.OnVideoSizeChangedListener() {
            @Override
            public void onVideoSizeChanged(MediaPlayer mediaPlayer, int width, int height) {
                changeVideoSize();
            }
        });
        // videoView = (VideoView) findViewById(R.id.videoView);

        btnSelect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setVideo();
            }
        });

        btnPlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mediaPlayer.start();
            }
        });

        btnRestart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mediaPlayer.start();
            }
        });

        btnPause.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view){
                if (mediaPlayer.isPlaying()){
                    mediaPlayer.pause();
                }
            }
        });
    }

    private void changeVideoSize() {
        int videoWidth = mediaPlayer.getVideoWidth();
        int videoHeight = mediaPlayer.getVideoHeight();

        int surfaceWidth = surfaceView.getWidth();
        int surfaceHeight = surfaceView.getHeight();

        float max;
        if (getResources().getConfiguration().orientation == ActivityInfo.SCREEN_ORIENTATION_PORTRAIT) {
            max = Math.max((float)videoWidth / (float)surfaceWidth, (float)videoHeight / (float)surfaceHeight);
        } else {
            max = Math.max((float)videoWidth / (float)surfaceHeight, (float)videoHeight / (float)surfaceWidth);
        }

        videoWidth = (int)Math.ceil((float)videoWidth / max);
        videoHeight = (int)Math.ceil((float)videoHeight / max);

        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(videoWidth, videoHeight);
        surfaceView.setLayoutParams(layoutParams);
        surfaceView.setG
    }

    private void readyPlay() {
        mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
        try{
            mediaPlayer.setDataSource(this, selectVideo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mediaPlayer.setLooping(true);
        mediaPlayer.setDisplay(surfaceHolder);
        mediaPlayer.prepareAsync();

    }


    private void setVideo() {
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Video.Media.EXTERNAL_CONTENT_URI);
        intent.setDataAndType(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, "video/*");
        startActivityForResult(Intent.createChooser(intent,"选择视频"), SELECT_VIDEO);
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == SELECT_VIDEO && resultCode == RESULT_OK) {
            selectVideo = data.getData();
            // videoView.setVideoURI(selectVideo);
            // videoView.requestFocus();
            URIPath.setText(selectVideo.toString());
        }
    }

}
