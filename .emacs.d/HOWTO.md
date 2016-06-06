# 注意点 #
## ELPA ##
- ELPA の *elc ファイルはバージョン違いの環境でエラーを起こす恐れあり. 問題があれば再インストール.
  ./ELPA_reinstall.el

- NTEmacs の場合,
  デフォルトだと TLS/SSL 接続ができないため Marmalade 等に接続できない.
  以下のようにして GnuTLS を設定する.
  1. gnutls ライブラリをダウンロードしてくる
     <http://sourceforge.net/projects/ezwinports/files/>
  2. ダウンロードしたファイルの bin/ 中の全ての DLL を
     Emacs の bin/ ディレクトリ内に展開する.
  3. (gnutls-available-p) が t を返せば成功.

## 各種の設定方法 ##
### proxy の設定 ###
inits/00-proxy.el を修正のこと.

### migemo の設定 ###
- Linux の場合
  各ディストリビューションのパッケージ参照

- Windows の場合
  1. 自前でビルドする. または,
     c/migemo のバイナリを落としてくる (http://www.kaoriya.net/software/cmigemo/).

  2. cmigemo.exe と migemo.dll と dict ディレクトリを、適当な場所にコピーする.
     例えば, .emacs.d 以下に migemo/ フォルダを作って配置する, など.
     .emacs.d/migemo/cmigemo.exe
     .emacs.d/migemo/migemo.dll
     .emacs.d/migemo/dict

     (PATH の通ったところに展開すれば .emacs の記述がプログラム名だけでいいのでシンプルになる。
	 フルパスで指定すればいいだけだが)
     (dict はどこでも大して変わらない)

  3. inits/windows-migemo.el のパスを修正する.
     (注: migemo-dictionary の値は, "~" 等を使うと Windows では展開できないため, フルパスで書く)
     
### その他の設定 ###
- 以下のファイルは, もし必要があれば追加/修正のこと
  - .recentf
  - my_template
