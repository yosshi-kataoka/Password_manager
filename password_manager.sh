!#/bin/bashh
echo "パスワードマネージャーへようこそ！"
while true; do
input=""

#1~3までの数字を判定
while true; do
echo "次の選択肢より、1~3の数字を一つを入力して下さい"
echo "1:Add Password"
echo "2:Get Password"
echo "3:Exit"
read input
if [ "$input" =~ ^[1-3]$ ]; then
break
echo "入力された値が、1~3の数字ではありません"
fi
done

case "$input" in
"Add Password")
read -p "サービス名を入力してください:" service
read -p "ユーザー名を入力してください:" user
read -p "パスワードを入力してください:" password
echo
echo "パスワードの追加は成功しました。"
gpg -d PasswordList.gpg > StashFile.txt 2> /dev/null
echo "サービス名:$service\tユーザー名:$user\tパスワード:$password" >> StashFile.txt
rm PasswordList.gpg
gpg -c -o PasswordList.gpg StashFile.txt;;

"Get Password")
read -p  "サービス名を入力してください:" serch
gpg -d PasswordList.gpg > StashFile.txt 2> /dev/null
result=($(grep "$serch" ./StashFile.txt ))
if [ -n "$result" ]; then
echo
grep "$serch" ./StashFile.txt | tr "\t" "\n "
else echo "そのサービスは登録されていません。"
fi;;

"Exit")
echo "Thank you!"
break;;

*)
echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。";;
esac
done
rm StashFile.txt
