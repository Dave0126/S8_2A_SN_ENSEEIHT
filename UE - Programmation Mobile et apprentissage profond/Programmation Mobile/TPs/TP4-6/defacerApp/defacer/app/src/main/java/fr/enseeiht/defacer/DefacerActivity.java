package fr.enseeiht.defacer;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.opencv.android.BaseLoaderCallback;
import org.opencv.android.CameraBridgeViewBase;
import org.opencv.android.LoaderCallbackInterface;
import org.opencv.android.OpenCVLoader;
import org.opencv.android.CameraBridgeViewBase.CvCameraViewFrame;
import org.opencv.android.CameraBridgeViewBase.CvCameraViewListener2;
import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.WindowManager;

public class DefacerActivity extends Activity implements CvCameraViewListener2
{
	private static final String TAG = "DefacerActivity";
	private float mRelativeFaceSize = 0.2f;
	private int mAbsoluteFaceSize = 0;

	private File mCascadeFile; // /< the file containing the classifier for the
								// face detection

	private DetectionBasedTracker mNativeDetector; // /< The object used for
													// face detection

	private CameraBridgeViewBase mOpenCvCameraView; // /< The opencv widget for
													// camera preview

	private Mat mRgba; // /< Used to manage the RGBA version of the camera frame

	/**
	 * This part manages the connection to the OCV manager and preliminary load
	 * the external resources for the facedetection algorithm
	 */
	private BaseLoaderCallback mLoaderCallback = new BaseLoaderCallback( this ) {
		@Override
		public void onManagerConnected( int status )
		{
			switch( status )
			{
				case LoaderCallbackInterface.SUCCESS:
				{
					Log.i( TAG, "OpenCV loaded successfully!!!" );

					Log.i( TAG, "Loading libdetection_based_tracker.so" );
					// Load native library after(!) OpenCV initialization
					System.loadLibrary( "detection_based_tracker" );
					Log.i(TAG, "libdetection_based_tracker.so successfully loaded" );

					try
					{
						// load cascade file from application resources
						InputStream is = getResources().openRawResource( R.raw.lbpcascade_frontalface );
						File cascadeDir = getDir( "cascade", Context.MODE_PRIVATE );
						mCascadeFile = new File( cascadeDir, "lbpcascade_frontalface.xml" );
						FileOutputStream os = new FileOutputStream( mCascadeFile );

						byte[] buffer = new byte[4096];
						int bytesRead;
						while( (bytesRead = is.read( buffer )) != -1 )
						{
							os.write( buffer, 0, bytesRead );
						}
						is.close();
						os.close();

						// create the face detector
						mNativeDetector = new DetectionBasedTracker( mCascadeFile.getAbsolutePath(), 0 );

						cascadeDir.delete();

					}
					catch( IOException e )
					{
						e.printStackTrace();
						Log.e( TAG,
								"Failed to load cascade. Exception thrown: "
										+ e );
					}

					mOpenCvCameraView.enableView();

				}
					break;
				default:
				{
					Log.i( TAG, "LoaderCallbackInterface status is " + status);
					super.onManagerConnected( status );
				}
					break;
			}
		}
	};

	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.about, menu);
		return true;
	}


	// ************************************************************************
	// ACTIVITY'S LIFECYCLE METHODS
	//
	// ************************************************************************
	@Override
	protected void onCreate( Bundle savedInstanceState )
	{
		super.onCreate( savedInstanceState );
		Log.i( TAG, "called onCreate" );
		Log.i( TAG, "app version " + getResources().getString(R.string.app_version) );
		// as long as this window is visible to the user, keep the device's
		// screen turned on and bright.
		getWindow().addFlags( WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON );
		Log.i(TAG, "Loading GUI...");
		setContentView( R.layout.activity_defacer );
		Log.i(TAG, "GUI loaded successfully");

		// get the reference to the opencv camera view
		mOpenCvCameraView = (CameraBridgeViewBase) findViewById( R.id.fd_activity_surface_view );
		// use the front camera
		mOpenCvCameraView.setCameraIndex( CameraBridgeViewBase.CAMERA_ID_ANY );
		// set this object as the callback listener
		mOpenCvCameraView.setCvCameraViewListener( this );
	}

	@Override
	public void onPause()
	{
		super.onPause();
		if( mOpenCvCameraView != null )
			mOpenCvCameraView.disableView();
	}

	@Override
	public void onResume()
	{
		Log.i(TAG, "Resuming defacer");
		super.onResume();
		Log.i(TAG, "Resumed parent");
		Log.i(TAG, "Calling Opencv Loader");
		OpenCVLoader.initAsync(OpenCVLoader.OPENCV_VERSION_2_4_3, this, mLoaderCallback);
		Log.i(TAG, "Opencv Loader successfully called");
	}

	public void onDestroy()
	{
		super.onDestroy();
		if( mOpenCvCameraView != null )
		mOpenCvCameraView.disableView();
	}

	// ************************************************************************
	// METHODS IMPLEMENTING CvCameraViewListener2 INTERFACE
	//
	// ************************************************************************

	/**
	 * This method is invoked when the camera is first started
	 * 
	 * @see org.opencv.android.CameraBridgeViewBase.CvCameraViewListener2#onCameraViewStarted(int,
	 *      int)
	 */
	@Override
	public void onCameraViewStarted( int width, int height )
	{
		mRgba = new Mat();
		mNativeDetector.start();
	}

	/**
	 * This method is invoked when the camera is stopped
	 * 
	 * @see org.opencv.android.CameraBridgeViewBase.CvCameraViewListener2#onCameraViewStopped()
	 */
	@Override
	public void onCameraViewStopped()
	{
		mRgba.release();
		mNativeDetector.stop();
	}

	/**
	 * This method is invoked every time a new frame from the camera becomes
	 * available
	 * 
	 * @param inputFrame
	 *            the frame
	 * @see org.opencv.android.CameraBridgeViewBase.CvCameraViewListener2#onCameraFrame(org.opencv.android.CameraBridgeViewBase.CvCameraViewFrame)
	 */
	@Override
	public Mat onCameraFrame( CvCameraViewFrame inputFrame )
	{
		mRgba = inputFrame.rgba();

		if( mAbsoluteFaceSize == 0 )
		{
			int height = mRgba.rows();
			if( Math.round( height * mRelativeFaceSize ) > 0 )
			{
				mAbsoluteFaceSize = Math.round( height * mRelativeFaceSize );
			}
			mNativeDetector.setMinFaceSize( mAbsoluteFaceSize );
		}
		//**************************************
		// detect the faces and obfuscate them
		//**************************************












		return mRgba;
	}
}
