#### 回顾

在前 4 篇文章中，我们介绍了 Android 四大组件的基础知识，四大组件是构成我们 App 的基础，也是 Android 系统设计的最佳体现。各个组件之间完全是解耦的，如果想访问其他组件或者启动其他组件可以使用 `Intent` 来操作。在四种组件类型中，有三种（Activity、Service 和 Broadcast）均可以通过异步消息 Intent 进行启动。Intent 会在运行时对各个组件进行互相绑定。所以我们可以把 `Intent`  当作是各个组件之间的信使（无论该组件是自己 App 的还是其他 App）。

每个组件都有不同的启动方法：

- 如要启动 Activity，可以用 startActivity() 或 startActivityForResult() 传递 Intent（需要 Activity 返回结果时）
- 如要启动 Service，可以通过 startService()传递 Intent 来启动服务，也可通过 bindService() 传递 Intent 来绑定到该服务
- 如要发送 Broadcast，可以通过 sendBroadcast()、sendOrderedBroadcast() 或 sendStickyBroadcast() 等方法传递 Intent 来发起广播

与 Activity、Service 和 Broadcast，ContentProvider 并非由 Intent 启动。相反，它们会在成为 ContentResolver 的请求目标时启动。想要访问 ContentProvider 的内容，可以通过 ContentResolver 调用 query()、insert()、update()、delete()等方法。

#### 目录

![目录](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/10/25/16e01c1ace3ea7b1~tplv-t2oaga2asx-zoom-in-crop-mark:1304:0:0:0.awebp)

### 一、Intent

#### （一）Intent 的定义

`Intent` 是一个消息传递对象，用来向其他组件请求操作，无论该组件是当前应用还是其他应用。具体来说包含三大用处： **启动一个 Activity**、**启动或者绑定 Service**、**传递广播**。

#### （二）Intent 的分类

Intent 分为两种类型：

- **显式 Intent**：通过提供目标应用的软件包名称或完全限定的组件类名来指定可处理 Intent 的应用。通常，会在自己的应用中使用显式 Intent 来启动组件，这是因为自己的应用知道要启动的 Activity 或 Service 的类名。
- **隐式 Intent**：不会指定特定的组件，而是声明要执行的常规操作，从而允许其他应用中的组件来处理。例如，如需在地图上向用户显示位置，则可以使用隐式 Intent，请求另一具有此功能的应用在地图上显示指定的位置。

#### （三）Intent 的工作流程

假设有一个 Activity A 需要启动一个 Activity B。如果通过显示 Intent 启动时，系统会立即启动该组件。使用隐式 Intent 时，Android 系统通过将 Intent 的内容与在设备上其他应用的清单文件中声明的 Intent 过滤器进行比较，从而找到要启动的相应组件。如果 Intent 与 Intent 过滤器匹配，则系统将启动该组件，并向其传递 Intent 对象。如果多个 Intent 过滤器兼容，则系统会显示一个对话框，支持用户选取要使用的应用。大致流程如下图：

![Intent 的工作流程](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/10/25/16e01c1ace234422~tplv-t2oaga2asx-zoom-in-crop-mark:1304:0:0:0.awebp)

**特别注意：**

为了确保应用的安全性，启动 Service 时，必须使用显式 Intent，且不要为服务声明 Intent 过滤器。使用隐式 Intent 启动服务存在安全隐患，因为无法确定哪些服务将响应 Intent，且用户无法看到哪些服务已启动。从 Android 5.0（API 级别 21）开始，如果使用隐式 Intent 调用 bindService()，系统会抛出异常。

#### （四）构建 Intent

一个 Intent 对象会携带一些信息，Android 系统会根据这些信息来确定要启动哪个组件。具体来说会携带以下七种信息： `ComponentName、Action、Category、Data 、Type、Extra、Flags`。我们可以把这七种信息称之为 `Intent 的七大属性`。下面我们具体的来分析每一个属性的含义和使用方法：

1. `ComponentName：要启动的组件名称`  指定了ComponentName 属性的 Intent 已经明确了它将要启动哪个具体组件，因此这种 Intent 被称为显式 Intent，没有指定 ComponentName 属性的 Intent 被称为隐式 Intent。隐式 Intent 没有明确要启动哪个组件，应用会根据 Intent 指定的其他信息去启动符合条件的组件。代码示例：

```java
//声明一个显示意图
Intent intent = new Intent();
ComponentName componentName = new ComponentName(MainActivity.this,SecondActivity.class);
intent.setComponent(componentName);
startActivity(intent);

```

除了通过 `setComponent` 为 intent 指定要启动的组件名称外，还可以使用 Intent 的构造函数：

```java
Intent intent = new Intent(MainActivity.this, SecondActivity.class);
startActivity(intent);

```

使用 Intent 构造函数设置组件名称的方式，代码更加的简洁。

1. `Action：操作` 当我们要声明一个隐式意图的时候，就要用到 Action，它指定了被启动的组件要完成的具体的操作，比如我想启动一个可以浏览照片的 Activity，可以设置 Action 为 `ACTION_VIEW`，或者启动一个可以发送邮件的 Activity，可以设置 Action 为 `

ACTION_SEND`。Action 通常是和 Category 结合起来使用。Action 本身是一个字符串，除了系统定义好的，我们也可以自己定义，下面通过代码来演示通过定义一个隐式 Intent 来启动 Activity：

**step1**：在启动方定义一个隐式 Intent

```java
Intent intent = new Intent();
//自定义了一个action：com.cyy.jump
intent.setAction("com.cyy.jump");
//必须指定一个category
intent.addCategory(Intent.CATEGORY_DEFAULT);
startActivity(intent);
```

**step2**：为被启动方配置 `<intent-filter>`。具体做法是在 `AndroidManifest.xml` 中，为被启动的 Activity 设置上 ：

```xml
<activity android:name=".SecondActivity">
    <intent-filter>
        <action android:name="com.cyy.jump" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
</activity>

```

在 `<intent-filter>` 中，我们设置了两个属性：`<action>` 和 `<category>`。的值必须与启动方的 setAction 的值一样：com.cyy.jump。

下面我们运行一下项目，看看效果：

跳转成功。

假如我们为多个 Activity 配置了同样的  会有什么效果呢？

```xml
<activity android:name=".SecondActivity">
    <intent-filter>
        <action android:name="com.cyy.jump" />

        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
</activity>

<activity android:name=".ThirdActivity">
    <intent-filter>
        <action android:name="com.cyy.jump" />

        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
</activity>
```



可以看到，在同一个应用内，如果有多个 Activity 设置了同样的  ，当在调用 startActivity() 后，系统会弹出一个选择框，让用户自己选择需要跳转的 Activity。

这是启动同一个应用内的页面，假设其他应用的某个 Activity 也设置了同样的  呢？我们可以来试验一下，新建一个项目，名叫 IntentDemo2，在 IntentDemo2 中新建一个页面叫做 HomeActivity：

```xml
<activity android:name=".HomeActivity">
    <intent-filter>
        <action android:name="com.cyy.jump" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
 </activity>
```

再次运行项目，看看效果：



可以看到，在对话框中显示出了 IntentDemo2 的选项，点击即可跳转 IntentDemo2 的 HomeActivity 页面。

以上是自定义的 Action，下面我们来演示一下使用系统定义的 Action，以 `ACTION_SEARCH` 为例：

```java
Intent intent = new Intent();
intent.setAction(Intent.ACTION_SEARCH);
intent.addCategory(Intent.CATEGORY_DEFAULT);
startActivity(intent);
```

此时，系统也会弹出所有满足 `ACTION_SEARCH` 的应用列表提供给用户选择。

**系统定义的一些 Action**：

| Action        | 含义                                 |
| ------------- | ------------------------------------ |
| ACTION_MAIN   | Android 的程序入口                   |
| ACTION_VIEW   | 显示指定数据                         |
| ACTION_EDIT   | 编辑指定数据                         |
| ACTION_DIAL   | 显示拨号面板                         |
| ACTION_CALL   | 直接呼叫 Data 中所带的号码           |
| ACTION_ANSWER | 接听来电                             |
| ACTION_SEND   | 向其他人发送数据（例如：彩信/email） |

以上只是简单列举了一部分，更多的可以参考官方文档：[Intent](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.android.google.cn%2Freference%2Fandroid%2Fcontent%2FIntent.html)

1. `Category：类别` Category 属性为 Action 增加额外的附加类别信息。常用的如 `CATEGORY_DEFAULT` ，表示 Android 系统中默认的执行方式，按照普通的 Activity 的执行方式执行。在比如 `CATEGORY_LAUNCHER` ，设置该组件为当前应用程序启动器中优先级最高的，通常与程序入口动作 `ACTION_MAIN ` 配合使用：

```xml
<activity android:name=".MainActivity">
	<intent-filter>
		<action android:name="android.intent.action.MAIN" />

		<category android:name="android.intent.category.LAUNCHER" />
	</intent-filter>
</activity>
```

1. `Data & Type：数据&类型`Data 属性通常是为 Action 属性提供要操作的数据，例如拨打指定电话、发送短信时指定电话号码和短信内容等数据。Data 属性的值是一个 `Uri` 对象，格式如下：

```java
schema://host:port/path
```

- **`schema`** 协议
- **`host`** 主机
- **`port`** 端口
- **`path`** 路径

如：`http://www.baidu.com:8080/a.jpg`

**系统内置的几个 Data 属性常量**

| 协议       | 含义                                                         |
| ---------- | ------------------------------------------------------------ |
| tel:       | 号码数据格式，后跟电话号码                                   |
| mailto:    | 邮件数据格式，后跟邮件收件人地址                             |
| smsto:     | 短信数据格式，后跟短信接收号码                               |
| file:///   | 文件数据格式，后跟文件路径。注意必须是三根斜杠 ///           |
| content:// | 内容数据格式，后跟需要读取的内容。ContentProvider 特有的格式 |

举几个例子给大家展示一下：

例1：打开一个网页

```java
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(Uri.parse("http://www.baidu.com"));
startActivity(intent);
```

 例2：打电话

```java
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(Uri.parse("tel:18755555555"));
startActivity(intent);
```

 `Type` 属性用于指定 Data 所制定的 Uri 对应的` MIME` 类型，通常应用于调用系统 App，比如实现查看文件（文本、图片、音频或者视频等），通过指定文件的 MIME 类型，可以让系统知道用什么程序打开该文件。

设置 Data 时，调用 `setData()` ，设置 Type 时，调用 `setType` ，注意，这两个方法不能同时设置，会被覆盖掉。如果想要同时设置 Data 和 Type，请调用 `setDataAndType`。我们可以查看一下源码：

```java
/**
     * Set the data this intent is operating on.  This method automatically
     * clears any type that was previously set by {@link #setType} or
     * {@link #setTypeAndNormalize}.
     *
     * <p><em>Note: scheme matching in the Android framework is
     * case-sensitive, unlike the formal RFC. As a result,
     * you should always write your Uri with a lower case scheme,
     * or use {@link Uri#normalizeScheme} or
     * {@link #setDataAndNormalize}
     * to ensure that the scheme is converted to lower case.</em>
     *
     * @param data The Uri of the data this intent is now targeting.
     *
     * @return Returns the same Intent object, for chaining multiple calls
     * into a single statement.
     *
     * @see #getData
     * @see #setDataAndNormalize
     * @see android.net.Uri#normalizeScheme()
     */
    public @NonNull Intent setData(@Nullable Uri data) {
        mData = data;
        mType = null;
        return this;
    }

	......
    
    /**
     * Set an explicit MIME data type.
     *
     * <p>This is used to create intents that only specify a type and not data,
     * for example to indicate the type of data to return.
     *
     * <p>This method automatically clears any data that was
     * previously set (for example by {@link #setData}).
     *
     * <p><em>Note: MIME type matching in the Android framework is
     * case-sensitive, unlike formal RFC MIME types.  As a result,
     * you should always write your MIME types with lower case letters,
     * or use {@link #normalizeMimeType} or {@link #setTypeAndNormalize}
     * to ensure that it is converted to lower case.</em>
     *
     * @param type The MIME type of the data being handled by this intent.
     *
     * @return Returns the same Intent object, for chaining multiple calls
     * into a single statement.
     *
     * @see #getType
     * @see #setTypeAndNormalize
     * @see #setDataAndType
     * @see #normalizeMimeType
     */
    public @NonNull Intent setType(@Nullable String type) {
        mData = null;
        mType = type;
        return this;
    }

	......
	
    /**
     * (Usually optional) Set the data for the intent along with an explicit
     * MIME data type.  This method should very rarely be used -- it allows you
     * to override the MIME type that would ordinarily be inferred from the
     * data with your own type given here.
     *
     * <p><em>Note: MIME type and Uri scheme matching in the
     * Android framework is case-sensitive, unlike the formal RFC definitions.
     * As a result, you should always write these elements with lower case letters,
     * or use {@link #normalizeMimeType} or {@link android.net.Uri#normalizeScheme} or
     * {@link #setDataAndTypeAndNormalize}
     * to ensure that they are converted to lower case.</em>
     *
     * @param data The Uri of the data this intent is now targeting.
     * @param type The MIME type of the data being handled by this intent.
     *
     * @return Returns the same Intent object, for chaining multiple calls
     * into a single statement.
     *
     * @see #setType
     * @see #setData
     * @see #normalizeMimeType
     * @see android.net.Uri#normalizeScheme
     * @see #setDataAndTypeAndNormalize
     */
    public @NonNull Intent setDataAndType(@Nullable Uri data, @Nullable String type) {
        mData = data;
        mType = type;
        return this;
    }
```

下面我们通过一个例子来说明一下 Data 和 Type 的用法：

查看手机里的一张图片，地址为：storage/emulated/0/DCIM/IMG_201910297_162012_328.jp

```java
File file = new File("storage/emulated/0/DCIM/IMG_201910297_162012_328.jpg");
Intent intent = new Intent();
Uri uri = Uri.fromFile(file);
intent.setDataAndType(uri, "image/jpeg");
startActivity(intent);
```

**常用的 MIME 类型**：

| 文件格式                  | 对应的MIME类型               |
| ------------------------- | ---------------------------- |
| .png                      | image/png                    |
| .jpe .jpeg .jpg           | image/jpeg                   |
| .txt                      | text/plain                   |
| .html                     | text/html                    |
| .pdf                      | application/pdf              |
| .exe                      | application/octet-stream     |
| .tar                      | application/x-tar            |
| .zip                      | application/x-zip-compressed |
| .wma                      | audio/x-ms-wma               |
| .wmv                      | video/x-ms-wmv               |
| .mp3 .mp2 .mpe .mpeg .mpg | audio/mpeg                   |
|                           |                              |

1. `Extra：额外` 属性用于添加一些附加信息，它的属性值是一个 Bundle 对象，通过键值对的形式存储数据。在隐式 Intent 中使用较少，主要用于显示 Intent 传递数据。下面简单演示一下：

```java
//MainActivity
Intent intent = new Intent(MainActivity.this, SecondActivity.class);
intent.putExtra("name", "我叫 Android");
startActivity(intent);

//SecondActivity
Intent intent = getIntent();
if (intent != null) {
	String name = intent.getStringExtra("name");
	textView.setText(name);
}

```

`Flags：标记` 通常用来动态配置 Activity 的启动模式。大部分情况下，我们都不需要设置 Flags，所以，对于 Flags 大家能够理解就行。下面，介绍几个常用的：

**FLAG_ACTIVITY_NEW_TASK**：设置这个标记位的话，是为 Activity 指定 “singleTask” 启动模式，它的作用和在清单文件中指定该启动模式的效果一样。

**FLAG_ACTIVITY_SINGLE_TOP**：设置这个标记位的话，是为 Activity 指定 “singleTop” 启动模式，它的作用和在清单文件中指定该启动模式的效果一样。

**FLAG_ACTIVITY_CLEAR_TOP**：具有此标记位的 Activity ，在它启动时，在同一个任务栈中所有位于它上面的 Activity 都要出栈。

**FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS**：具有这个标记的 Activity 不会出现在历史 Activity 的列表中。它等同于在清单文件中指定 Activity 的属性 `android:excludeFromRecents="true"`。

### 二、隐式 Intent 详解

在上一节的内容中，我们介绍了 Intent 的七大属性，也给大家演示了如何定义一个显示 Intent和隐式 Intent，显示 Intent 的使用更加的简单，因此我们就不过多介绍了，下面再给大家分析一下隐式 Intent。

#### （一）接收隐式 Intent

要声明组件可以接收哪些隐式 Intent，需要在清单文件中使用 `<intent-filter>` 元素为组件声明`一个或多个` Intent 过滤器。每个 `<intent-filter>` 中主要设置的属性包括：`<action>`、`<data>`、`<category>`。当隐式 Intent 可以匹配上其中一个`<intent-filter>` 时，系统就会将该 Intent 传递给应用组件（显式 Intent 始终会传递给其目标组件，无论目标组件声明的 `<intent-filter>` 是什么）。

应用组件应该为自身可执行的每个独特作业声明单独的 `<intent-filter>` 。例如，图像库应用中的一个 Activity 可能会有两个 `<intent-filter>` ，分别用于查看图像和编辑图像。当 Activity 启动时，将检查 Intent 并根据 Intent 中的信息决定具体的行为（例如，是否显示编辑图片控件）。

**特别注意**：在 `<intent-filter>` 中，必须设置一个默认的 `<category>`：`<category android:name="android.intent.category.DEFAULT" />`，否者组件不会接收隐式 Intent。

假如我们不希望其他应用启动我们的组件，只希望在本应用中使用组件，那么我们就不要在清单中声明 `<intent-filter>` ，并且将该组件的 `exported` 属性设置为 `false`。

下面我们通过一个具体的例子来说明一下 `<intent-filter>` 的用法：

```xml
<activity android:name="MainActivity">
    <!-- This activity is the main entry, should appear in app launcher -->
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>

<activity android:name="ShareActivity">
    <!-- This activity handles "SEND" actions with text data -->
    <intent-filter>
        <action android:name="android.intent.action.SEND"/>
        <category android:name="android.intent.category.DEFAULT"/>
        <data android:mimeType="text/plain"/>
    </intent-filter>
    <!-- This activity also handles "SEND" and "SEND_MULTIPLE" with media data -->
    <intent-filter>
        <action android:name="android.intent.action.SEND"/>
        <action android:name="android.intent.action.SEND_MULTIPLE"/>
        <category android:name="android.intent.category.DEFAULT"/>
        <data android:mimeType="application/vnd.google.panorama360+jpg"/>
        <data android:mimeType="image/*"/>
        <data android:mimeType="video/*"/>
    </intent-filter>
</activity>

```

第一个 Activity MainActivity 是应用的主要入口：

- `ACTION_MAIN` 操作指示这是主要入口，且不要求输入任何 Intent 数据。
- `CATEGORY_LAUNCHER` 类别指示此 Activity 的图标应放入系统的应用启动器。如果  元素未使用 icon 指定图标，则系统将使用  元素中的图标。

**这两个元素必须配对使用，Activity 才会显示在应用启动器中。**

第二个 Activity ShareActivity 旨在便于共享文本和媒体内容。尽管可以通过从 MainActivity 进入此 Activity，但也可以从发出隐式 Intent（与两个 Intent 过滤器之一匹配）的另一应用中直接进入 ShareActivity。

> MIME 类型 application/vnd.google.panorama360+jpg 是一个指定全景照片的特殊数据类型

#### （二）声明一个隐式 Intent 需要注意的地方

**注意1**：当没有任何应用能够响应我们调用 startActivity() 传递的隐式 Intent 时如何处理？

我们自定义一个 Action，但是不让任何 Activity 接收该 Intent：

```java
Intent intent = new Intent();
intent.setAction("com.cyy.send");
intent.addCategory(Intent.CATEGORY_DEFAULT);
startActivity(intent);

```

运行后，应用奔溃，Error 信息如下：

```
android.content.ActivityNotFoundException: No Activity found to handle Intent { act=com.cyy.send cat=[android.intent.category.DEFAULT] }
```

为了避免这种情况的出现，我们在调用 startActivity() 前，需要调用 `resolveActivity()` 验证是否有 Activity 可以接收 Intent，具体做法如下：

```java
Intent intent = new Intent();
intent.setAction("com.cyy.send");
intent.addCategory(Intent.CATEGORY_DEFAULT);

if (intent.resolveActivity(getPackageManager()) != null) {
	startActivity(intent);
}

```

如果 resolveActivity 的结果为**非空**，则表示至少有一个应用能够处理该 Intent，此时即可安全的调用 startActivity()。

**注意2**：当有多个应用可以响应我们的隐式 Activity 时，系统会弹出一个选择框，让用户选择需要打开的应用，用户也可以选择记住要自己打开的应用，这样下次就不会再弹出选择框。那么假如我希望每次都弹窗，不让用户记住呢？我们可以使用 ` createChooser()` 创建 Intent。

```java
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(Uri.parse("http://www.baidu.com"));

String title = "请选择浏览器";
// Create intent to show the chooser dialog
Intent chooser = Intent.createChooser(intent, title);
if (intent.resolveActivity(getPackageManager()) != null) {
	startActivity(chooser);
}

```

