!#/bin/bash
echo "パスワードマネージャーへようこそ！"
while true; do
input=""
read -p "次の選択肢から入力してください(Add Password/Get Password/Exit):" input
case "$input" in
"Add Password")
read -p "サービス名を入力してください:" service
read -p "ユーザー名を入力してください:" user
read -p "パスワードを入力してください:" password
echo
echo "パスワードの追加は成功しました。"
echo "サービス名:$service	ユーザー名:$user	パスワード:$password" >> Customer_list;;

"Get Password")
read -p  "サービス名を入力してください:" serch
result=($(grep "$serch" ./Customer_list))
if [ -n "$result" ]; then
grep "$serch" ./Customer_list | tr "\t" "\n"
else echo "そのサービスは登録されていません。"
fi;;

"Exit")
echo "Thank you!"
break;;

*)
echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。";;
esac
done
