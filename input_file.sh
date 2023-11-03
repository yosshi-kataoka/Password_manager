I#/bin?bash
echo "パスワードマネージャーへようこそ!"
read -p "サービス名を入力してください:" service
read -p "ユーザー名を入力してください:" user
read -p "パスワードを入力してください:" password
echo "Thank you!"
echo "サービス名:$service,ユーザー名:$user,パスワード:$password" >> Customer_list

