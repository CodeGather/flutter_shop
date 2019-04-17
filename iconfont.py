import re
from pathlib import Path
import shutil


ROOT = Path(__file__).resolve().parent
MAIN = ROOT


# 将 iconfont 的 css 自动转换为 dart 代码

def translate():
    print('开始制作iconfont.dart文件...')
    code = """
/*
 * @Author: 21克的爱情
 * @Email: raohong07@163.com
 * 以下代码由程序自动生成。请不要对此文件做任何修改
 * 请在需要的页面引入该文件然后IconFont.xxx使用
 */

import 'package:flutter/widgets.dart';

class IconFont {
  IconFont._();
  static const font_name = 'IconFont';

{icon_codes}
}
""".strip()
    strings = []
    tmp = []
    # 正则表达式
    p = re.compile(r'.(.*?):.*?"\\(.*?)";')
    content = open(MAIN / 'iconfont/iconfont.css').read().replace('\n  content', 'content')

    for line in content.splitlines():
        line = line.strip()
        if line:
            res = p.findall(line)
            if res:
                name, value = res[0]
                name = name.replace('-', '_')
                tmp.append((name.lower(), value))

    tmp.sort()
    for name, value in tmp:
        string = f'  static const IconData {name} = const IconData(0x{value}, fontFamily: font_name);'
        strings.append(string)

    strings = '\n'.join(strings)
    code = code.replace('{icon_codes}', strings)
    open(MAIN / 'lib/iconfont.dart', 'w').write(code)

    print('开始移动iconfont.ttf字体文件')
    shutil.copy(MAIN / 'iconfont/iconfont.ttf', MAIN / 'assets/fonts/iconfont.ttf')
    print('移动成功iconfont.ttf文件成功...')

    print('制作iconfont.dart文件成功--->运行完毕')

if __name__ == "__main__":
    translate()
