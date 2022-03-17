## 列举Android中各种Intent的常见作用

#### 1. Intent.ACTION_MAIN

```
String: android.intent.action.MAIN
```

标识Activity为一个程序的开始。比较常用。

- Input: nothing 
- Output: nothing 

```javascript
<activity android:name=".Main" android:label="@string/app_name"   
<intent-filter 
     <action android:name="android.intent.action.MAIN" / 
     <category android:name="android.intent.category.LAUNCHER" / 
   </intent-filter 
</activity  
```



#### 2. Intent.Action_CALL

```
Stirng: android.intent.action.CALL
```

呼叫指定的电话号码。

- Input: 电话号码。数据格式为：tel:(电话号码)
- Output: Nothing 

```javascript
Intent intent=new Intent(); 
intent.setAction(Intent.ACTION_CALL);  
intent.setData(Uri.parse("tel:1320010001");
startActivity(intent);
```

使用`Intent.ACTION_CALL`时，必须在`AndroidManifest.xml`中添加

```javascript
<uses-permission android:name=”android.permission.CALL_PHONE” / 已获取拨打电话的权限。
```

- `Intent.ACTION_DIALOG`只是调用拨号键盘，将电话号码复制上去，
- `Intent.ACTION_CALL`则是直接拨打电话



#### 3. Intent.Action.DIAL

```
String: action.intent.action.DIAL
```

调用拨号面板

```javascript
Intent intent=new Intent();
intent.setAction(Intent.ACTION_DIAL);  //android.intent.action.DIAL
intent.setData(Uri.parse("tel:1320010001");
startActivity(intent); 
```

- Input: 电话号码。数据格式为：tel:(电话号码)
- Output: Nothing 

说明：打开Android的拨号UI。如果没有设置数据，则打开一个空的UI，如果设置数据，`action.DIAL`则通过调用`getData()`获取电话号码。

但设置电话号码的数据格式为 tel:(电话号码)



#### 4. Intent.ACTION_SENDTO

```
String: android.intent.action.SENDTO
```

说明：发送信息

```javascript
//发送短信息 
Uri uri = Uri.parse("smsto:13200100001"); 
Intent it = new Intent(Intent.ACTION_SENDTO, uri); 
it.putExtra("sms_body", "信息内容..."); 
startActivity(it);

//发送彩信,设备会提示选择合适的程序发送 
Uri uri = Uri.parse("content://media/external/images/media/23"); 

//设备中的资源（图像或其他资源） 
Intent intent = new Intent(Intent.ACTION_SEND); 
intent.putExtra("sms_body", "内容"); 
intent.putExtra(Intent.EXTRA_STREAM, uri); 
intent.setType("image/png"); 
startActivity(it);

//Email 
Intent intent=new Intent(Intent.ACTION_SEND); 
String[] tos={"android1@163.com"}; 
String[] ccs={"you@yahoo.com"}; 
intent.putExtra(Intent.EXTRA_EMAIL, tos); 
intent.putExtra(Intent.EXTRA_CC, ccs);
intent.putExtra(Intent.EXTRA_TEXT, "The email body text"); 
intent.putExtra(Intent.EXTRA_SUBJECT, "The email subject text"); 
intent.setType("message/rfc822"); 
startActivity(Intent.createChooser(intent, "Choose Email Client"));
```



#### 5. Intent.ACTION_GET_CONTENT

```
String: android.intent.action.GET_CONTENT
```

允许用户选择特殊种类的数据，并返回（特殊种类的数据：照一张相片或录一段音）

- Input: Type
- Output: URI 

```javascript
int requestCode = 1001;
Intent intent = new Intent(Intent.ACTION_GET_CONTENT); // "android.intent.action.GET_CONTENT"
intent.setType("image/*"); // 查看类型，如果是其他类型，比如视频则替换成 video/*，或 */*
Intent wrapperIntent = Intent.createChooser(intent, null);
startActivityForResult(wrapperIntent, requestCode); 
```



```javascript
//选择图片 requestCode 返回的标识
Intent intent = new Intent(Intent.ACTION_GET_CONTENT); //"android.intent.action.GET_CONTENT"
intent.setType(contentType); //查看类型 String IMAGE_UNSPECIFIED = "image/*";
Intent wrapperIntent = Intent.createChooser(intent, null);
((Activity) context).startActivityForResult(wrapperIntent, requestCode); 

//添加音频
Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
intent.setType(contentType); //String VIDEO_UNSPECIFIED = "video/*";
Intent wrapperIntent = Intent.createChooser(intent, null);
((Activity) context).startActivityForResult(wrapperIntent, requestCode); 

//拍摄视频 
int durationLimit = getVideoCaptureDurationLimit(); //SystemProperties.getInt("ro.media.enc.lprof.duration", 60);
Intent intent = new Intent(MediaStore.ACTION_VIDEO_CAPTURE);
intent.putExtra(MediaStore.EXTRA_VIDEO_QUALITY, 0);
intent.putExtra(MediaStore.EXTRA_SIZE_LIMIT, sizeLimit);
intent.putExtra(MediaStore.EXTRA_DURATION_LIMIT, durationLimit);
startActivityForResult(intent, REQUEST_CODE_TAKE_VIDEO);

//视频
Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
intent.setType(contentType); //String VIDEO_UNSPECIFIED = "video/*";
Intent wrapperIntent = Intent.createChooser(intent, null);
((Activity) context).startActivityForResult(wrapperIntent, requestCode); 

//录音
Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
intent.setType(ContentType.AUDIO_AMR); //String AUDIO_AMR = "audio/amr";
intent.setClassName("com.android.soundrecorder",
"com.android.soundrecorder.SoundRecorder");
((Activity) context).startActivityForResult(intent, requestCode); 

//拍照 REQUEST_CODE_TAKE_PICTURE 为返回的标识
Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); //"android.media.action.IMAGE_CAPTURE";
intent.putExtra(MediaStore.EXTRA_OUTPUT, Mms.ScrapSpace.CONTENT_URI); // output,Uri.parse("content://mms/scrapSpace");
startActivityForResult(intent, REQUEST_CODE_TAKE_PICTURE); 
```



#### 6. Intent.ACTION_VIEW

```
String android.intent.action.VIEW
```

用于显示用户的数据。

比较通用，会根据用户的数据类型打开相应的Activity。

比如 tel:13400010001打开拨号程序，http://xxx 则会打开浏览器等。

```javascript
Uri uri = Uri.parse("http://www.google.com"); //浏览器 

Uri uri =Uri.parse("tel:1232333"); //拨号程序 

Uri uri=Uri.parse("geo:39.899533,116.036476"); //打开地图定位 
Intent it = new Intent(Intent.ACTION_VIEW,uri); 
startActivity(it); 

//播放视频 
Intent intent = new Intent(Intent.ACTION_VIEW); 
Uri uri = Uri.parse("file:///sdcard/media.mp4"); 
intent.setDataAndType(uri, "video/*"); 
startActivity(intent);

//调用发送短信的程序 
Intent it = new Intent(Intent.ACTION_VIEW);
it.putExtra("sms_body", "信息内容..."); 
it.setType("vnd.android-dir/mms-sms"); 
startActivity(it);
```



#### 7. Intent.Action.ALL_APPS

```
String: andriod.intent.action.ALL_APPS
```

列出所有的应用。

- Input: nothing 
- Output: nothing 



#### 8. Intent.ACTION_ANSWER

```
Stirng:android.intent.action.ANSWER
```

处理呼入的电话。

- Input: nothing 
- Output: nothing 



#### 9. Intent.ACTION_ATTACH_DATA

```
String: android.action.ATTCH_DATA
```

别用于指定一些数据应该附属于一些其他的地方，例如，图片数据应该附属于联系人

- Input: Data 
- Output: nothing 



#### 10. Intent.ACTION_BUG_REPORT

```
String: android.intent.action.BUG_REPORT
```

显示Dug报告。

- Input: nothing 
- Output: nothing 



#### 11. Intent.Action_CALL_BUTTON

```
String: android.action.intent.CALL_BUTTON.
```

相当于用户按下“拨号”键。经测试显示的是“通话记录”

- Input: nothing 
- Output: nothing 

```javascript
Intent intent = new Intent(Intent.ACTION_CALL_BUTTON);
startActivity(intent);
```



#### 12. Intent.ACTION_CHOOSER

```
String: android.intent.action.CHOOSER
```

显示一个activity选择器，允许用户在进程之前选择他们想要的,与之对应的是Intent.ACTION_GET_CONTENT.

