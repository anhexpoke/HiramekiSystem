# 閃きシステムMOD
[![CircleCI](https://img.shields.io/circleci/project/github/RedSparr0w/node-csgo-parser.svg)](https://github.com/anhexpoke/HiramekiSystem/releases/download/v1.0/HiramekiSystem-v1.0.7z)
[![AUR](https://img.shields.io/aur/license/yaourt.svg)](https://github.com/anhexpoke/HiramekiSystem/blob/master/LICENSE.md)
## 概要
このMODはSkyrimのスペルに閃き要素を導入します。  
閃くと、**閃いたスペル名**と**各自が設定した画像**がカットインします。  

## 動作環境
_Skyrim v1.9.32_  
_SKSE v1.07.03_  
_SkyUI v5.1_  
#### プレイ解像度
_1920x1080_  

## 仕様
このMODをアクティベートした状態でスタートもしくはセーブデータをロードすると、各種の初期魔法を覚えていない場合、すべて習得します。これをベースに閃いていきましょう。基本的に、ドヴァキンはバニラの呪文書が不要になります。  

1920x1080のプレイ環境が対象です。16:9なら動作するとは思いますが、非推奨です。Skyrimのswf再生仕様が今一つ把握できていないので、 **HUDが表示されないことがあります** が、 **仕様** です。一度表示されなくとも、ずっと表示されないバグがないのは確認済みです。HUDを利用してプレイが停止しない分、不確定要素が多いので許容してください。音は鳴るので、何かを閃いたことはわかるはずです。  

キルムーブになったときに閃くと表示されないのも仕様です。 **キルムーブはHUDがオフになる** ので、キルムーブの映像の方を楽しんでください。  

### 閃く方法
#### 破壊/召喚/回復の場合
1. 敵を見つけます
2. 敵と戦闘状態に入ります
3. 敵をターゲット(画面上中央に敵のゲージが表示)します
4. 閃きたいスペルの種類のスペルを詠唱します
5. 発動すると、詠唱したスペルと同種のバニラスペルを閃くことがあります
6. 閃いた場合、そのスペル名とカットインが入り、マジカが全回復し左手にセットされるので、カットイン中でも閃いたスペルを発動できます
#### 変性/幻惑の場合
1. どこでも構わないので変性魔法か幻惑魔法を詠唱します
2. 変性なら変性、幻惑なら幻惑のバニラスペルを閃くことがあります
3. 閃いた場合、そのスペル名とカットインが入り、マジカが全回復し左手にセットされます

## 注意点
- 破壊/召喚/回復は敵と交戦状態でのみ閃きます
- 巨人とマンモスは道場にできないようにしてあります
- ソースを読んでわかった閃き率の計算式は公言しないようお願いします
- ソースは読めないけど計算式を知りたい人はこちらへ→[@Bell_Genson][1ceb99f3]
- いくら詠唱しても閃かないことがあります。相手が弱いか、自分のマジカが低いからです

## カットイン画像の差し替え
デフォルトでは作者のキャラの切り抜きがセットされています。これをご自身のキャラや好きな画像に差し替えてください。カットインは画面左ウィンドウ外から右端が画面中央に来るまでスライドします。  
#### 用意するもの
- 960x1080の未圧縮(圧縮しても大丈夫のはず)の差し替えたいpng画像
- [JPEXS Free Flash Decompiler][90e39cc2]
- このMODの`mod/Interface/exported/widgets/hirameki/HiramekiWidget.swf`
- [SkyUIのgfxfontlib.swf][ab1a121f]

手順は動画にしたので、こちらからハンズオンで作業してください。  
**[HiramekiSystemのカットイン画像差し替え手順][ee89c6a5]**  

## flaファイルからswfを作りたい場合
cloneしたsrcフォルダ内のflaと[ここのCLIKとCommonとHUDWidgetsが必要です。][294da9c5]  
Flash Pro CS6ならこれらのフォルダにパスを通してFlash11.4用のActionScript2.0でコンパイルするとSkyrimで使えるswfとして出力できます。ただし、かなり条件が厳しいのでうまくいかなくて当たり前だと思って弄ってください。



[1ceb99f3]: https://twitter.com/Bell_Genson?lang=ja "@Bell_Genson"
[90e39cc2]: https://www.free-decompiler.com/flash/ "JPEXS Free Flash Decompiler"
[ab1a121f]: https://github.com/schlangster/skyui/blob/master/build/gfxfontlib.swf "gfxfontlib.swf"
[ee89c6a5]: https://youtu.be/RXVyVcaeGkk "HiramekiSystemのカットイン画像差し替え手順"
[294da9c5]: https://github.com/schlangster/skyui/tree/master/src "ここのCLIKとCommonとHUDWidgetsが必要です。"
