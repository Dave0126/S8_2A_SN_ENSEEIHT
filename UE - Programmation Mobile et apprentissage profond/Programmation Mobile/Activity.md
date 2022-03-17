#### 目录

![目录](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/10/21/16dec2da9ab088b8~tplv-t2oaga2asx-zoom-in-crop-mark:1304:0:0:0.awebp)

### 一、Activity 的定义

Activity 是一个用户界面，通过加载一个指定的布局文件来展示各种 UI 元素，同时处理这些 UI 元素的交互事件，如点击、输入文本等。不同的 Activity 之间可以进行跳转，将不同的页面串联起来，共同完成特定的操作流程。每个应用都是由一个或者多个 Activity 组成。

### 二、Activity 的生命周期函数：

- onCreate()

它会在 Activity 第一次被创建的时调用，通常会在这个函数中完成 Activity 的初始化操作，比如设置布局、初始化视图、绑定事件等。

- onStart()

这个函数是在 onCreate 函数调用之后调用，在调用 onCreate 时，此时的 Activity 还是不可见状态，调用完 onStart 后，Activity 变得 **可见**。

- onResume()

执行完 onResume 之后，Activity 就会请求 AMS 渲染它所管理的视图，此时的 Activity 一定位于返回栈的栈顶，并且处于运行状态，可以与用户进行交互（**聚焦**）。

- onPause()

在 Activity 即将从可见状态变为不可见时调用。我们通常会在这个函数中将一些消耗 CPU 的资源释放掉，以及保存一些关键数据，此时不可以与用户进行交互（**失焦**）。

- onStop()

Activity 变为 **不可见** 时调用。它和 onPause 函数的主要区别是在于，如果新启动的 Activity 是一个对话框式的 Activity ，那么 onPause() 函数会被执行，而 onStop() 函数并不会被执行，因为旧页面依然可见，只是不能响应用户的交互事件。

- onDestroy()

这个函数在 Activity 被销毁之前调用，之后 Activity 的状态将变为销毁状态。

- onRestart()

这个函数在 Activity 由停止状态重新变为运行状态之前调用，也就是 Activity 被重新启动了。

![Activity 的生命周期](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2019/10/21/16dec2da9e226dca~tplv-t2oaga2asx-zoom-in-crop-mark:1304:0:0:0.awebp)

### 三、Activity 的 4 种启动模式

Android 内部是通过 **回退栈** 来管理 Activity 实例。栈是一种后进先出的集合，对于 Android 来说，当前显示的 Activity 就在栈顶，当用户点击后退键或者点击应用上的返回按钮，系统就会将栈顶的 Activity 出栈，此时原来栈顶下的 Activity 就会变为栈顶显示到设备上。

但是在一些特殊情况下，我们需要对 Activity 实例做一些特殊的处理，例如，为了避免重复创建 Activity ，我们要求一个 Activity 只有一个实例。好在 Android 系统为我们提供了这些功能，也就是我们说的 Activity 的 4 个启动模式：**standard、singleTop、singleTask、singleInstance**。

1. standard（标准启动模式）

这是 Activity 的默认启动模式。在这种模式下，每次启动该 Activity 都会被实例化，并且放入同一个回退栈中。

1. singleTop

如果一个 Activity 的启动模式设置为 singleTop ，并且该 Activity 的实例位于栈顶时，当我们再启动这个 Activity 时，不会创建新的实例，而是重用位于栈顶的那个实例，并且会调用该实例的 onNewIntent() 函数将Intent 对象传递到这个实例中。

> 此时执行的生命周期为：onPause() -- onNewIntent() -- onResume()

如果一个 Activity 的启动模式设置为 singleTop，并且该 Activity  的一个实例已经存在于任务栈中，但是不在栈顶，当我们再启动这个 Activity 时，会创建一个新的实例。

1. singleTask（**重点掌握一下该模式**）

如果一个 Activity 的启动模式设置为 singleTask，那么在一个任务栈中只能有一个该 Activity 的实例。如果任务栈中还没有该 Activity 的实例，会新建一个实例并放在栈顶。如果已经存在 Activity 的一个实例，系统会销毁处在该 Activity 上的所有 Activity ，最终让该 Activity 实例处于栈顶，同时回调该 Activity 的 onNewIntent() 函数。

> 此时执行的生命周期为：onNewIntent() -- onRestart() -- onStart() -- onResume()

1. singleInstance

设置了 singleInstance 模式的 Activity 单独占用一个任务栈，栈中有且只有这一个实例，其他的 Activity 运行在另一个任务栈中。当再次启动该 Activity 实例时，会重用已存在的任务和实例。并且会调用该实例的 onNewIntent() 函数，将 Intent 实例传递到该实例中。

**singleInstance 和 singleTask 的区别：** singleInstance 保证了在同一时刻，系统只会存在一个这样的 Activity 实例，而 singleTask 模式的 Activity 是可以有多个实例的，只要这些 Activity 在不同的任务栈中即可，例如，应用 A 启动了一个启动模式为 singleTask 的 ActivityA，应用 B 又通过 Intent 想要启动一个 ActivityA ，此时，由于应用 A 和应用 B 都有自己的任务栈，因此，在两个任务栈中分别都有一个 ActivityA 的实例。而 singleInstance 能够保证 Activity 在系统中只有一个实例，不管多少应用要启动该 Activity ，这个 Activity 有且只有一个。

