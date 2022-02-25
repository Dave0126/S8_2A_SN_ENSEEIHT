package fr.enseeiht.defacer;

import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;

public class DetectionBasedTracker
{
	// *****************************************************************
	// JAVA METHODS
	//
	// ****************************************************************

	/**
	 * Constructor
	 * @param cascadeName the file containing the classifier
	 * @param minFaceSize the minimum size for the faces to look for
	 */
	public DetectionBasedTracker( String cascadeName, int minFaceSize )
	{
		mNativeObj = nativeCreateObject( cascadeName, minFaceSize );
	}

	/**
     * Start the tracking
     */
	public void start()
	{
		nativeStart( mNativeObj );
	}

	/**
     * Stop the tracking
     */
	public void stop()
	{
		nativeStop( mNativeObj );
	}

	/**
	 * Set the minimum size of the faces to look for
	 * @param size the size in pixel
	 */
	public void setMinFaceSize( int size )
	{
		nativeSetFaceSize( mNativeObj, size );
	}

	/**
	 * Detect faces in the imput image
	 * @param image the input image to process (RGB)
	 * @param faces the detected faces as a matrix of rectangles corresponding to the image regions where the faces are
	 */
	public void detect( Mat image, MatOfRect faces )
	{
		nativeDetect( mNativeObj, image.getNativeObjAddr(), faces.getNativeObjAddr() );
	}

	/**
     * Release the underlying tracker object
     */
	public void release()
	{
		nativeDestroyObject( mNativeObj );
		mNativeObj = 0;
	}
	
	//**************************************
	// Declare here the deface method that calls the native method
	//**************************************











	
	
	// *****************************************************************
	// NATIVE STUFF
	//
	// ****************************************************************

	/**
	 * This will contain the reference to the underlying native object detector
	 * @see https://github.com/Itseez/opencv/blob/7d4d28605087ec2d3878f9467aea313a2acdfd49/modules/objdetect/src/detection_based_tracker.cpp
	 */
	private long mNativeObj = 0;

	/**
	 * Create a tracker with the given classifier and the minimum size for the face
	 * @param cascadeName the file containing the classifier
	 * @param minFaceSize the minimum size for the faces to look for
	 */
	private static native long nativeCreateObject( String cascadeName,
			int minFaceSize );

	/**
	 * Release the tracker
	 * @param thiz the handle to the tracker object
	 */
	private static native void nativeDestroyObject( long thiz );

	/**
	 * Start the tracker
	 * @param thiz the handle to the tracker object
	 */
	private static native void nativeStart( long thiz );

	/**
	 * Stop the tracker
	 * @param thiz the handle to the tracker object
	 */
	private static native void nativeStop( long thiz );

	/**
	 * Set the minimum size of the faces to look for
	 * @param thiz the handle to the tracker object
	 * @param size the size in pixel
	 */
	private static native void nativeSetFaceSize( long thiz, int size );

	/**
	 * @param thiz the handle to the tracker object
	 * @param image the input image to process (RGB)
	 * @param faces the detected faces as a matrix of rectangles corresponding to the image regions where the faces are
	 */
	private static native void nativeDetect( long thiz, long inputImage, long faces );

	//**************************************
	// declare here the native deface method
	//**************************************









}
