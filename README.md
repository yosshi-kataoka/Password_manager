パスワードマネージャーを作成するプロジェクトです。

Password_manager.shを起動すると、下記処理が実行されます。

echo "次の選択肢より、1~3の数字を一つ入力して下さい"
echo "1:Add Password"
echo "2:Get Password"
echo "3:Exit"

この時の処理として、
パスワードを登録する場合は1
登録したパスワードを表示する場合は2
プログラムを終了する場合は3
を選択します。
1および2の処理は繰り返しとなりますので、プログラムを終了させる場合は、3を選択する必要があります。

1のAdd Password処理では、
サービス名、ユーザー名、パスワードをそれぞれ標準入力（スペースは入力不可）にてキーボードから入力します。
この３つの情報をPasswordList.gpgに保存します。
その際の処理として、
1.PasswordList.gpgを復号し、StashFile.txtに一旦保存
2.入力した3つの情報をStashFile.txtに追加
3.StashFile.txtをPasswordList.gpgに暗号化して情報を保存する処理を実装してます。

2のGet Password処理では、
サービス名を標準入力にてキーボードから入力し、PasswordList.gpgを復号。
復号したファイルより、入力内容を検索してサービス名、ユーザー名、パスワードをそれぞれ表示します。
その際の処理として、
1.PasswordList.gpgを復号し、StashFile.txtに一旦保存
2.StashFile.txtより、入力したサービス名を検索
3.検索した内容がStashFile.txtに存在すれば、サービス名に紐づいたユーザー名、パスワードを表示します。
この際、一致するサービス名がStashFile.txtに存在しない場合は、echo "そのサービスは登録されていません。"が表示され、Get Password処理が終了します。

3のExit処理では、
echo "Thank you!"
を表示して、プログラムを終了します。

