#!/bin/bash
echo "パスワードマネージャーへようこそ！"
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
		fi		
		echo "入力された値が、1~3の数字ではありません"
	done

	#選択された数字に応じて処理を実行
	case "$input" in
		#Add Password処理
		"1")
			passwords=()
			while true; do
				read -r -e -p "サービス名を入力してください:" service
				#カンマを削除
				if [[ -z ${service} ]]; then
					echo "サービス名が未入力です"
					continue
				fi
				service=$(echo $service | sed -e 's/,//g' -e 's/ //g' -e 's/　//g')
				read -r -e -p "ユーザー名を入力してください:" user
				if [[ -z ${user} ]]; then
					echo "ユーザー名が未入力です"
					continue 
				fi
				user=$(echo $user | sed -e 's/,//g' -e 's/ //g' -e 's/　//g')
				read -s -r -e -p "パスワードを入力してください:" password
				if [[ -z ${password} ]]; then
					echo ""
					echo "パスワードが未入力です"
					continue
				fi
				password=$(echo $password | sed -e 's/,//g' -e 's/ //g' -e 's/　//g')
				break
			done
			passwordList=($service $user $password)
			echo ""
			echo "パスワードの追加は成功しました。"
			gpg -d PasswordList.gpg > StashFile.txt 2> /dev/null
			printf "%s," "${passwordList[@]}" >> StashFile.txt
			printf "%s\n" >> StashFile.txt
			rm PasswordList.gpg
			gpg -c -o PasswordList.gpg StashFile.txt;;

		#Get Password処理
		"2")
			read -p  "サービス名を入力してください:" search
			if [ -z ${search} ]; then
				echo "サービス名が未入力です。最初からやり直して下さい。"
				break
			else
				gpg -d PasswordList.gpg > StashFile.txt 2> /dev/null
				result=""
				result=$(grep "^${search}" ./StashFile.txt)
				if [ -n "$result" ]; then
					count=$(echo $result | wc -w)
					k=1
					for (( i=0; i<$count; i++ )); do
        					displayService=$(echo $result | cut -f $k -d ",")
        					displayUser=$(echo $result | cut -f $((k+1)) -d ",")
       						displayPassword=$(echo $result | cut -f $((k+2)) -d ",")
        					echo "サービス名: $displayService" 
						echo "ユーザー名: $displayUser"
						echo "パスワード: $displayPassword"
						k=$((k+3))
						done
					echo ""
				else
					echo "パスワードが間違えているか、そのサービスは登録されていません。"
				fi
			fi;;

		#Exit処理
		"3")
			echo "Thank you!"
			break;;
	esac
done
rm StashFile.txt 2> /dev/null
