/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class fr_enseeiht_defacer_DetectionBasedTracker */

#ifndef _Included_fr_enseeiht_defacer_DetectionBasedTracker
#define _Included_fr_enseeiht_defacer_DetectionBasedTracker
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeCreateObject
 * Signature: (Ljava/lang/String;I)J
 */
JNIEXPORT jlong JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeCreateObject
  (JNIEnv *, jclass, jstring, jint);

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeDestroyObject
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDestroyObject
  (JNIEnv *, jclass, jlong);

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeStart
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeStart
  (JNIEnv *, jclass, jlong);

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeStop
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeStop
  (JNIEnv *, jclass, jlong);

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeSetFaceSize
 * Signature: (JI)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeSetFaceSize
  (JNIEnv *, jclass, jlong, jint);

/*
 * Class:     fr_enseeiht_defacer_DetectionBasedTracker
 * Method:    nativeDetect
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_fr_enseeiht_defacer_DetectionBasedTracker_nativeDetect
  (JNIEnv *, jclass, jlong, jlong, jlong);











#ifdef __cplusplus
}
#endif
#endif
