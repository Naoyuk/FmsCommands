#!/bin/sh

echo "\n*****FileMaker Serverアドミンコンソール Mac版*****\n"

# IDとパスワードを入力して変数に代入
echo 'IDを入力してください...'
read ID
echo 'パスワードを入力してください...'
read -s PW

# ログインチェック
fmsadmin -v -u ${ID} -p ${PW} || { echo 'IDとパスワードが違います。もっかいやり直してください。'; exit 1; }

# 表示するメニューを配列に格納
SELECT=(
  '終了'
  'メッセージを送信する'
  'ファイル一覧を表示する'
  'ファイルを閉じる'
  'ファイルを開く'
  'スケジュール一覧を表示する'
  'スケジュールを実行する'
  'スケジュールを有効にする'
  'スケジュールを無効にする'
  'データベースのバックアップ'
  'データベースサーバーを再起動する'
  'データベースサーバーを停止する'
  'データベースサーバーを起動する'
  '管理サーバーを再起動する'
  '管理サーバーを停止する'
  '管理サーバーを起動する'
  )

# メニューに対応するfmsadminのコマンドを変数に代入
COMHEAD=(
  ''
  'SEND'
  'LIST FILES -s'
  'CLOSE'
  'OPEN'
  'LIST SCHEDULES'
  'RUN SCHEDULES'
  'ENABLE SCHEDULE'
  'DISABLE SCHEDULE'
  'BACKUP'
  'RESTART SERVER'
  'STOP SERVER'
  'START SERVER'
  'RESTART ADMINSERVER'
  'STOP ADMINSERVER'
  'START ADMINSERVER'
  )

while [ 0 ]; do

# メニューをecho
echo '======================================================================'
for((i=0; i<${#SELECT[*]}; i++ )){
  echo "$i: ${SELECT[i]}"
}
echo '======================================================================'
echo "\n処理を選択してください..."

# 標準入力から実行するコマンドの確認
# 終了を選んだ時はシェルスクリプト終了
read CMD

# 各コマンドのオプションを指定させて$EXECに最終的に実行するコマンドを代入
case $CMD in
  0)
    exit;;
  1)
  # メッセージを送信する
    echo 'メッセージを入力してください...'
    read MSG
    EXEC=${COMHEAD[$CMD]}" -m "$MSG
    CAN=0
    ;;
  2)
  # ファイル一覧を表示する
    EXEC=${COMHEAD[$CMD]}
    CAN=0
    ;;
  3)
  # ファイルを閉じる
    echo "ファイルを指定して閉じる場合はIDで指定してください。\n指定がなければ全てのファイルを閉じます。\nIDはファイル一覧で表示されます..."
    read DBID
    echo "ID:"${DBID}"のファイルを閉じます。よろしいですか？[y/n]..."
    read CAN
    EXEC=${COMHEAD[$CMD]}' '${DBID}
    ;;
  4)
  # ファイルを開く
    echo "ファイルを指定して開く場合はIDで指定してください。\n指定がなければ全てのファイルを開きます。\nIDはファイル一覧で表示されます..."
    read DBID
    echo "ID:"${DBID}"のファイルを開きます。よろしいですか？[y/n]..."
    read CAN
    EXEC=${COMHEAD[$CMD]}' '${DBID}
    ;;
  5)
  # スケジュール一覧を表示する
    EXEC=${COMHEAD[$CMD]}
    CAN=0
    ;;
  6)
  # スケジュールを実行する
    echo "実行するスケジュールのIDを指定してください。\nIDはスケジュール一覧で表示されます..."
    read SCHEID
    echo "ID:"${SCHEID}"のスケジュールを実行します。よろしいですか？[y/n]..."
    read CAN
    EXEC=${COMHEAD[$CMD]}' '${SCHEID}
    ;;
  7)
  # スケジュールを有効にする
    echo "有効にするスケジュールのIDを指定してください。\nIDはスケジュール一覧で表示されます..."
    read SCHEID
    echo "ID:"${SCHEID}"のスケジュールを有効にします。よろしいですか？[y/n]"
    read CAN
    EXEC=${COMHEAD[$CMD]}' '${SCHEID}
    ;;
  8)
  # スケジュールを無効にする
    echo "無効にするスケジュールのIDを指定してください。\nIDはスケジュール一覧で表示されます..."
    read SCHEID
    echo "ID:"${SCHEID}"のスケジュールを無効にします。よろしいですか？[y/n]"
    read CAN
    EXEC=${COMHEAD[$CMD]}' '${SCHEID}
    ;;
  9)
  # データベースのバックアップ
    echo "バックアップするファイルのIDを指定してください。\n指定がなければ全てのファイルをバックアップします..."
    read DBID
    EXEC=${COMHEAD[$CMD]}' '${DBID}
    CAN=0
    ;;
  10)
  # データベースサーバーを再起動する
    echo 'データベースサーバーを再起動します。よろしいですか？[y/n]...'
    read CAN
    EXEC=${COMHEAD[$CMD]}
    ;;
  11)
  # データベースサーバーを停止する
    echo 'データベースサーバーを停止します。よろしいですか？[y/n]...'
    read CAN
    EXEC=${COMHEAD[$CMD]}
    ;;
  12)
  # データベースサーバーを起動する
    echo 'データベースサーバーを起動します。よろしいですか？[y/n]...'
    read CAN
    EXEC=${COMHEAD[$CMD]}
    ;;
  13)
  # 管理サーバーを再起動する
    echo '管理サーバーを再起動します。よろしいですか？[y/n]...'
    read CAN
    EXEC=${COMHEAD[$CMD]}
    ;;
  14)
  # 管理サーバーを停止する
    echo '管理サーバーを停止します。よろしいですか？[y/n]...'
    read CAN
    EXEC=${COMHEAD[$CMD]}
    ;;
  15)
  # 管理サーバーを起動する
    echo '管理サーバーを起動します。よろしいですか？[y/n]...'
    read CAN
    EXEC=${COMHEAD[$CMD]}
    ;;
esac

# $CANの設定
case $CAN in
  "y")
    CAN=0;;
  "n")
    CAN=1;;
  "")
    echo 'どっちも選ばない、はナシです。'
esac

if [ $CAN -eq 0 ]; then
  # fmsadminコマンドを実行
  fmsadmin $EXEC -y -u $ID -p $PW
fi

done
