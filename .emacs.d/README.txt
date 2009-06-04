User emacs-lisp files

Shoji Nishimura

改造項目

compilation-mode
  - compilation-mode起動時のバッファのコーディングシステムをSJISに強制
    - Windows上で使うことから
  - ImageMagickのパスのハンドリング
    - Meadowは、ImageMagic 6.2.8-Q16を要求するが、rubyのRMagicは別のバージョン
      で共存が出来ない。
      システムのPATH環境変数は、RMagicが要求するものが先に来るようにする。
      meadow.batで、ImageMagic 6.2.8-Q16をPATH環境変数の先頭につけMeadowを起動
      compilation-modeでは、システムのPATH環境変数に戻すため、削除。

snippet.el
  - snippet-cancelの追加。
  　- snippetを展開した後、C-gでキャンセルできるようにする。
    - hippie展開、abbrev展開の両方で対応できるようにした。

flymake
  - flymakeでエラーや警告が出たとき、ミニバッファーで表示
  - どこかからそのまま持ってきた

インデント
  - indent-current-buffer
    - カレントバッファ全体をインデント。簡単な自作
    - C-cC-iにキーバインド
  - indent-or-complete
    - 状況によりインデントか補完
    - rails-emacsから抜粋および改造
    - TABにキーバインド

hippie-exp
  - try-complete-abbrev
    - abbrevに登録されている文字列を補完して、それを展開
    - snippet.elでabbrevが登録されている場合のみテスト
    - snippetの定義を工夫すれば、劇的に使いやすくなる。

ruby-mode
  - additional ruby-electric
    - ruby-electric-backspace/deleteはどこかからのコピー
    - ruby-electric-forward-char
      - 入力した文字がすでに入力されていたら、それを入力せずに一つ進む
      - すでに閉じカッコが（自動で）入力されているのに、（手動で）入力
        してしまった場合、助けてくれる。
    - compilation-mode
      - F5でカレントバッファのRubyスクリプトを実行
      - rakefile, specfileなどを認識して、rake, rspecを代わりに起動
    - snippet
      - よく使いそうなパターンを網羅
      - rake, rspec, Test::Unitごとにファイルの種類によって
        snippetを切り替える
    - flymake
      - ruby用の設定。どこからかコピー


Snippetの作り方のコツ

try-complete-abbrevの補完候補の出し方のルールは登録された略称の
　打鍵量が少ない順、同じ場合はalphabet順
となっています。
このクセを理解して作ると、効果的な補完をしてくれるようになります。
例えば、短い打鍵で途中まで展開用、略称をほとんどしない展開用の
２通り用意すれば、効果的に絞り込みながらの展開が出来るでしょう。
また、展開のさせ方にいろいろなバリエーションがある場合、
xx、xx1、xx2のように用意しておくと順番に展開していってくれます。
RSpecやTest::Unit用のSnippetを参考にしてください。
