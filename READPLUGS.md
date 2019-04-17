MaterialApp({
    title ： 在任务管理窗口中所显示的应用名字
    theme ： 应用各种 UI 所使用的主题颜色
    color ： 应用的主要颜色值（primary color），也就是安卓任务管理窗口中所显示的应用颜色
    home ： 应用默认所显示的界面 Widget
    routes ： 应用的顶级导航表格，这个是多页面应用用来控制页面跳转的，类似于网页的网址
    initialRoute ：第一个显示的路由名字，默认值为 Window.defaultRouteName
    onGenerateRoute ： 生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
    onLocaleChanged ： 当系统修改语言的时候，会触发å这个回调
    navigatorObservers ： 应用 Navigator 的监听器
    debugShowMaterialGrid ： 是否显示 纸墨设计 基础布局网格，用来调试 UI 的工具
    showPerformanceOverlay ： 显示性能标签，https://flutter.io/debugging/#performanceoverlay
    checkerboardRasterCacheImages 、showSemanticsDebugger、debugShowCheckedModeBanner 各种调试开关
})

Scaffold({
    Key key,
    this.appBar, //横向水平布局，通常显示在顶部（*）
    this.body, // 内容（*）
    this.floatingActionButton, //悬浮按钮，就是上图右下角按钮（*）
    this.floatingActionButtonLocation, //悬浮按钮位置
    //悬浮按钮在[floatingActionButtonLocation]出现/消失动画
    this.floatingActionButtonAnimator,
    //在底部呈现一组button，显示于[bottomNavigationBar]之上，[body]之下
    this.persistentFooterButtons,  //一个垂直面板，显示于左侧，初始处于隐藏状态（*）
    this.drawer,
    this.endDrawer,  //出现于底部的一系列水平按钮（*）
    this.bottomNavigationBar,   //底部持久化提示框
    this.bottomSheet,  //内容背景颜色
    this.backgroundColor,  //弃用，使用[resizeToAvoidBottomInset]
    this.resizeToAvoidBottomPadding,  //重新计算布局空间大小 防止键盘弹出布局出问题
    this.resizeToAvoidBottomInset,  //是否显示到底部，默认为true将显示到顶部状态栏
    this.primary = true,   // 是否将导航融入状态栏
    this.drawerDragStartBehavior = DragStartBehavior.down,
})

AppBar({
    Key key,
    this.leading,//在标题前面显示的一个控件，在首页通常显示应用的 logo；在其他界面通常显示为返回按钮
    this.automaticallyImplyLeading = true, // 是否去除返回按钮
    this.title,//Toolbar 中主要内容，通常显示为当前界面的标题文字
    this.actions,//一个 Widget 列表，代表 Toolbar 中所显示的菜单，对于常用的菜单，通常使用 IconButton 来表示；对于不常用的菜单通常使用 PopupMenuButton 来显示为三个点，点击后弹出二级菜单
    this.flexibleSpace,//一个显示在 AppBar 下方的控件，高度和 AppBar 高度一样，可以实现一些特殊的效果，该属性通常在 SliverAppBar 中使用
    this.bottom,//一个 AppBarBottomWidget 对象，通常是 TabBar。用来在 Toolbar 标题下面显示一个 Tab 导航栏
    this.elevation = 4.0, // bar 下方线条
    //纸墨设计中控件的 z 坐标顺序，默认值为 4，对于可滚动的 SliverAppBar，当 SliverAppBar 和内容同级的时候，该值为 0， 当内容滚动 SliverAppBar 变为 Toolbar 的时候，修改 elevation 的值
    this.backgroundColor,//APP bar 的颜色，默认值为 ThemeData.primaryColor。改值通常和下面的三个属性一起使用
    this.brightness,//App bar 状态栏的样式，有白色和黑色两种主题，默认值为 ThemeData.primaryColorBrightness
    this.iconTheme,//App bar 上图标的颜色、透明度、和尺寸信息。默认值为 ThemeData.primaryIconTheme
    this.textTheme,//App bar 上的文字样式。默认值为 ThemeData.primaryTextTheme
    this.primary = true, // 是否去除系统通知栏
    this.centerTitle,//标题是否居中显示，默认值根据不同的操作系统，显示方式不一样,true居中 false居左
    this.titleSpacing = NavigationToolbar.kMiddleSpacing, //标题两边的空白区域,
    this.toolbarOpacity = 1.0, // bar上面的元素透明
    this.bottomOpacity = 1.0,
})

SizedBox( // 可以用来制作间隔
    width: 100.0,
    height: 100.0,
    child:  Container(
        width: 200.0,
        height: 200.0,
        color: Color(0xffff0000),
    ),
)

PopupMenuButton({
    Key key,
    @required this.itemBuilder,
    this.initialValue,//初始值，如果itemBuilder里该值，则会高亮显示
    this.onSelected,//选中弹出弹出选项的回调
    this.onCanceled,//点屏幕外取消回调,点击屏幕其他地方时调用
    this.tooltip,//
    this.elevation = 8.0,//
    this.padding = const EdgeInsets.all(8.0),
    this.child,//修改PopupMenuButton默认三个点的图标为设置的child，不能与icon同时使用
    this.icon,//修改PopupMenuButton默认三个点的图标为设置的icon，不能与child同时使用
    this.offset = Offset.zero,
})

TabBar({
    indicatorColor: Color(0xffffe311),// tab下方线条颜色
    indicatorSize,
        |-TabBarIndicatorSize.label   // tab下方线条和文字一样长
        |-TabBarIndicatorSize.tab     // tab下方线条和tab一样长
})
TextStyle({
    this.inherit: true,         // 为false的时候不显示
    this.color,                    // 颜色
    this.fontSize,               // 字号
    this.fontWeight,           // 字重，加粗也用这个字段  FontWeight.w700
    this.fontStyle,                // FontStyle.normal  FontStyle.italic斜体
    this.letterSpacing,        // 字符间距  就是单个字母或者汉字之间的间隔，可以是负数
    this.wordSpacing,        // 字间距 句字之间的间距
    this.textBaseline,        // 基线，两个值，字面意思是一个用来排字母的，一人用来排表意字的（类似中文）
    this.height,                // 当用来Text控件上时，行高（会乘以fontSize,所以不以设置过大）
    this.decoration,        // 添加上划线，下划线，删除线 
    this.decorationColor,    // 划线的颜色
    this.decorationStyle,    // 这个style可能控制画实线，虚线，两条线，点, 波浪线等
    this.debugLabel,
    String fontFamily,    // 字体
    String package,
})

TextField({
    Key key,
    this.controller,           //控制器，控制TextField文字
    this.focusNode,           是否具有键盘焦点。
    this.decoration = const InputDecoration(),   → InputDecoration -  外形描述。  //输入器装饰
    TextInputType keyboardType,   //输入的类型
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,   //文字显示位置
    this.autofocus = false,        //是否是自动获取焦点。
    this.obscureText = false,      //是否为密码框
    this.autocorrect = true,   //是否启用自动更正。
    this.maxLines = 1,  // 最大行数
    this.maxLength,  // 最大长度
    this.maxLengthEnforced = true, // 是否允许超出最大字数限制
    this.onChanged,                //文字改变触发
    this.onEditingComplete,
    this.onSubmitted,   //文字提交触发（键盘按键）
    this.inputFormatters,  // 验证 [LengthLimitingTextInputFormatter(4)]
    this.enabled,    // 是否禁用
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),

    inputFormatters → List<textinputformatter style="-webkit-font-smoothing: antialiased; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-size-adjust: none; box-sizing: border-box;"></textinputformatter> 
    - 可选的，输入验证和格式化。
    keyboardType → TextInputType - 用于编辑文本的键盘类型。
    obscureText → bool - 是否是隐藏文本（密码形式）。
    onChanged → ValueChanged - 当 value 改变时触发。
    onSubmitted → ValueChanged - 当用户点击键盘的提交时触发。
    style → TextStyle - 文本样式，颜色，字体等。
    textAlign → TextAlign - 设置文本对齐方式。
})

InputDecoration({
    this.icon,    //位于装饰器外部和输入框前面的图片
    this.labelText,  //用于描述输入框，例如这个输入框是用来输入用户名还是密码的，当输入框获取焦点时默认会浮动到上方，
    this.labelStyle,  // 控制labelText的样式,接收一个TextStyle类型的值
    this.helperText, //辅助文本，位于输入框下方，如果errorText不为空的话，则helperText不会显示
    this.helperStyle, //helperText的样式
    this.hintText,  //提示文本，位于输入框内部
    this.hintStyle, //hintText的样式
    this.hintMaxLines, //提示信息最大行数
    this.errorText,  //错误信息提示
    this.errorStyle, //errorText的样式
    this.errorMaxLines,   //errorText最大行数
    this.hasFloatingPlaceholder = true,  //labelText是否浮动，默认为true，修改为false则labelText在输入框获取焦点时不会浮动且不显示
    this.isDense,   //改变输入框是否为密集型，默认为false，修改为true时，图标及间距会变小
    this.contentPadding, //内间距
    this.prefixIcon,  //位于输入框内部起始位置的图标。
    this.prefix,   //预先填充的Widget,跟prefixText同时只能出现一个
    this.prefixText,  //预填充的文本，例如手机号前面预先加上区号等
    this.prefixStyle,  //prefixText的样式
    this.suffixIcon, //位于输入框后面的图片,例如一般输入框后面会有个眼睛，控制输入内容是否明文
    this.suffix,  //位于输入框尾部的控件，同样的不能和suffixText同时使用
    this.suffixText,//位于尾部的填充文字
    this.suffixStyle,  //suffixText的样式
    this.counter,//位于输入框右下方的小控件，不能和counterText同时使用
    this.counterText,//位于右下方显示的文本，常用于显示输入的字符数量
    this.counterStyle, //counterText的样式
    this.filled,  //如果为true，则输入使用fillColor指定的颜色填充
    this.fillColor,  //相当于输入框的背景颜色
    this.errorBorder,   //errorText不为空，输入框没有焦点时要显示的边框
    this.focusedBorder,  //输入框有焦点时的边框,如果errorText不为空的话，该属性无效
    this.focusedErrorBorder,  //errorText不为空时，输入框有焦点时的边框
    this.disabledBorder,  //输入框禁用时显示的边框，如果errorText不为空的话，该属性无效
    this.enabledBorder,  //输入框可用时显示的边框，如果errorText不为空的话，该属性无效
    this.border, //正常情况下的border
    this.enabled = true,  //输入框是否可用
    this.semanticCounterText,  
    this.alignLabelWithHint,
})

Flex({
    Key key,
    @required this.direction,
    ----Axis.|----horizontal,
             |----vertical,

    this.mainAxisAlignment = MainAxisAlignment.start,
    ----MainAxisAlignment.|----start,
                          |----end,
                          |----center,
                          |----spaceBetween,
                          |----spaceAround,
                          |----spaceEvenly,

    this.mainAxisSize = MainAxisSize.max,
    ----MainAxisSize.|----max
                     |----min

    this.crossAxisAlignment = CrossAxisAlignment.center,
    ----CrossAxisAlignment.|----start,
                           |----end,
                           |----center,
                           |----stretch,
                           |----baseline,

    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    List<Widget> children = const <Widget>[],
})

Chip({
    Key key,
    this.avatar,//标签左侧Widget，一般为小图标
    @required this.label,//标签
    this.labelStyle,
    this.labelPadding,
    this.deleteIcon,//删除图标
    this.onDeleted,//删除回调，为空时不显示删除图标
    this.deleteIconColor,//删除图标的颜
    this.deleteButtonTooltipMessage,//删除按钮的tip文字
    this.shape,//形状.默认两端是半圆形
    this.clipBehavior = Clip.none
    this.backgroundColor,//背景颜色
    this.padding,
    //设置为MaterialTapTargetSize.shrinkWrap时，clip距顶部距离为0；设置为 MaterialTapTargetSize.padded时距顶部有一个距离
    this.materialTapTargetSize,
})

RaisedButton({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,//水波纹高亮变化回调,按下返回true,抬起返回false
    ButtonTextTheme textTheme,//按钮的主题
    Color textColor,//文字的颜色
    Color disabledTextColor,//按钮禁用时候文字的颜色
    Color color,//按钮的背景颜色
    Color disabledColor,//按钮被禁用的时候显示的颜色
    Color highlightColor,//点击或者toch控件高亮的时候显示在控件上面，水波纹下面的颜色
    Color splashColor,//水波纹的颜色
    Brightness colorBrightness,//按钮主题高亮
    double elevation,//按钮下面的阴影
    double highlightElevation,//高亮时候的阴影
    double disabledElevation,//按下的时候的阴影
    EdgeInsetsGeometry padding,
    ShapeBorder shape,//设置形状
        |-const BorderSide({
            this.color = const Color(0xFF000000),
            this.width = 1.0,
            this.style = BorderStyle.solid,
        })
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
})

flatButton({ // 按钮圆角
    shape: StadiumBorder(
        side: BorderSide(
            width: 1.0,
            color: Colors.transparent,
            style: BorderStyle.solid,
        )
    ),
})

GridView({
    shrinkWrap -> bool  // 是否自动计算高度
    physics: NeverScrollableScrollPhysics() // 禁止滑动弹动效果
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(//SliverGridDelegateWithFixedCrossAxisCount可以直接指定每行（列）显示多少个Item   SliverGridDelegateWithMaxCrossAxisExtent会根据GridView的宽度和你设置的每个的宽度来自动计算没行显示多少个Item
        crossAxisSpacing:5.0,
        mainAxisSpacing: 5.0,
        crossAxisCount: 3,
    ),
})