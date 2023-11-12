#!/bin/bash
echo "パスワードマネージャーへようこそ！"
item=("サービス名" "ユーザー名" "パスワード")
while true; do
#1~3の数字を判定
while true; do
echo "次の選択肢より、1~3の数字を一つ入力して下さい"
echo "1:Add Password"
echo "2:Get Password"
echo "3:Exit"
read input
if [[ $input =~ ^[1-3]$ ]]; then
break
echo "入力された値が、1~3の数字ではありません"
fi
done

#選択された数字に応じて処理を実行
case "$input" in
#Add Password処理
"1")
while true; do
nullFlag=""
read -r -e -p "サービス名を入力してください:" service
#スペースを削除
inputValue=$(echo $service | sed 's/ //g')
read -r -e -p "ユーザー名を入力してください:" user 
inputValue=$(echo $user | sed 's/ //g')
read -r -e -p "パスワードを入力してください:" password
inputValue=$(echo $password | sed 's/ //g')
for i in ${inputValue[@]}; do
#各項目の未入力チェック
if [ -z ${inputValue[$i]} ]; then
#入力内容が未入力の場合エラーメッセージを表示
echo "エラー：${item[$i]}が未入力です。"
nullFlag=1
fi
done
if [ -z ${nullFlag} ]; then
break
fi
done
echo ""
echo "パスワードの追加は成功しました。"
gpg -d PasswordList.gpg > StashFile.txt 2> /dev/null
echo "サービス名:$service ユーザー名:$user パスワード:$password">> StashFile.txt
rm PasswordList.gpg
gpg -c -o PasswordList.gpg StashFile.txt;;

#Get Password処理
"2")
read -p  "サービス名を入力してください:" serch
gpg -d PasswordList.gpg > StashFile.txt 2> /dev/null
result=$(grep "$serch" ./StashFile.txt )
if [ -n "$result" ]; then
for service in "$result"; do
echo "$service" | sed 's/ /\n/g'
echo ""
done
else echo "そのサービスは登録されていません。"
fi;;

#Exit処理
"3")
echo "Thank you!"
break;;
esac
done
rm StashFile.txt 2> /dev/null
