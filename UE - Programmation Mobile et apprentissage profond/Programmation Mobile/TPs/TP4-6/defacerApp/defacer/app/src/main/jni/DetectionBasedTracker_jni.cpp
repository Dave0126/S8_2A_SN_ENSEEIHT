#include <DetectionBasedTracker_jni.h>
#include <opencv2/core/core.hpp>
#include <opencv2/contrib/detection_based_tracker.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#include <string>
#include <vector>

#include <android/log.h>

#define LOG_TAG "Defacer/DetectionBasedTracker"
#define LOGD(...) ((void)__android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__))

using namespace std;
using namespace cv;

inline void vector_Rect_to_Mat( vector<Rect>& v_rect, Mat& mat )
{
	mat = Mat( v_rect, true );
}

inline void Mat_to_vector_Rect( Mat& mat, vector<Rect>& v_rect )
{
	v_rect = Mat_<Rect>(mat.reshape(1, mat.cols*mat.rows));
}

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeCreateObject
 * Signature: (Ljava/lang/String;I)J
 */
JNIEXPORT jlong JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeCreateObject(
		JNIEnv * jenv, jclass, jstring jFileName, jint faceSize )
{
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeCreateObject enter" );
	const char* jnamestr = jenv->GetStringUTFChars( jFileName, NULL );
	string stdFileName( jnamestr );
	jlong result = 0;

	try
	{
		DetectionBasedTracker::Parameters DetectorParams;
		if( faceSize > 0 )
			DetectorParams.minObjectSize = faceSize;
		result = (jlong) new DetectionBasedTracker( stdFileName,
				DetectorParams );
	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeCreateObject caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeCreateObject caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code of DetectionBasedTracker.nativeCreateObject()" );
		return 0;
	}

	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeCreateObject exit" );
	return result;
}

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeDestroyObject
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDestroyObject(
		JNIEnv * jenv, jclass, jlong thiz )
{
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeDestroyObject enter" );
	try
	{
		if( thiz != 0 )
		{
			((DetectionBasedTracker*) thiz)->stop();
			delete (DetectionBasedTracker*) thiz;
		}
	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeestroyObject caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeDestroyObject caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code of DetectionBasedTracker.nativeDestroyObject()" );
	}
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeDestroyObject exit" );
}

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeStart
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeStart(
		JNIEnv * jenv, jclass, jlong thiz )
{
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeStart enter" );
	try
	{
		((DetectionBasedTracker*) thiz)->run();
	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeStart caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeStart caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code of DetectionBasedTracker.nativeStart()" );
	}
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeStart exit" );
}

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeStop
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeStop(
		JNIEnv * jenv, jclass, jlong thiz )
{
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeStop enter" );
	try
	{
		((DetectionBasedTracker*) thiz)->stop();
	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeStop caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeStop caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code of DetectionBasedTracker.nativeStop()" );
	}
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeStop exit" );
}

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeSetFaceSize
 * Signature: (JI)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeSetFaceSize(
		JNIEnv * jenv, jclass, jlong thiz, jint faceSize )
{
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeSetFaceSize enter" );
	try
	{
		if( faceSize > 0 )
		{
			DetectionBasedTracker::Parameters DetectorParams =
					((DetectionBasedTracker*) thiz)->getParameters();
			DetectorParams.minObjectSize = faceSize;
			((DetectionBasedTracker*) thiz)->setParameters( DetectorParams );
		}
	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeStop caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeSetFaceSize caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code of DetectionBasedTracker.nativeSetFaceSize()" );
	}
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeSetFaceSize exit" );
}

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeDetect
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDetect(
		JNIEnv * jenv, jclass, jlong thiz, jlong image, jlong faces )
{
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeDetect enter" );
	try
	{
		Mat imageGray;
		cv::cvtColor( *((Mat*) image), imageGray, CV_RGBA2GRAY );
		vector<Rect> rectFaces;
		((DetectionBasedTracker*) thiz)->process( imageGray );
		((DetectionBasedTracker*) thiz)->getObjects( rectFaces );
		LOGD( "Detected %d faces", rectFaces.size() );
		vector_Rect_to_Mat(rectFaces, *((Mat*)faces));
	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeCreateObject caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeDetect caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code DetectionBasedTracker.nativeDetect()" );
	}
	LOGD( "Java_org_opencv_samples_facedetect_DetectionBasedTracker_nativeDetect exit" );
}


/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeDeface
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDeface
  (JNIEnv *jenv, jclass, jlong thiz, jlong image, jlong faces)
{
	LOGD( "Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDeface enter" );
	try
	{
		vector<Rect> rectFaces;
		Mat_to_vector_Rect( *((Mat*)faces), rectFaces);
		LOGD( "%d faces to deface", rectFaces.size() );
		Mat& imgOut = *(Mat*) image;
		//**************************************
		// For each detected face obfuscate it and draw the surrounding rectangle
		//**************************************









	}
	catch( cv::Exception& e )
	{
		LOGD( "nativeCreateObject caught cv::Exception: %s", e.what() );
		jclass je = jenv->FindClass( "org/opencv/core/CvException" );
		if( !je )
			je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, e.what() );
	}
	catch( ... )
	{
		LOGD( "nativeDetect caught unknown exception" );
		jclass je = jenv->FindClass( "java/lang/Exception" );
		jenv->ThrowNew( je, "Unknown exception in JNI code DetectionBasedTracker.nativeDetect()" );
	}
	LOGD( "Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDeface exit" );
}
