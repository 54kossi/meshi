#encodiing: Windows-31J
require 'csv'
require 'twitter'
require 'kconv'
require 'date'
#なんかアカウント情報取得とかあれこれ
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['kossi_CONSUMER_KEY']
  config.consumer_secret     = ENV['kossi_CONSUMER_SECRET']
  config.access_token        = ENV['kossi_ACCESS_TOKEN']
  config.access_token_secret = ENV['kossi_ACCESS_TOKEN_SECRET']
end
stream_client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV['kossi_CONSUMER_KEY']
  config.consumer_secret     = ENV['kossi_CONSUMER_SECRET']
  config.access_token        = ENV['kossi_ACCESS_TOKEN']
  config.access_token_secret = ENV['kossi_ACCESS_TOKEN_SECRET']
end
#現在時刻の取得
nowTime = DateTime.now
time="#{nowTime.hour}時#{nowTime.minute}分#{nowTime.second}秒"
#フォーマット
#"飯屋"=>["地域","ジャンル","定休日"]
hash=Hash.new(["設定中です","設定中です","設定中です"])
hash.update({"ZEYO."=>["天2","カレーうどん","なし"], "天地"=>["天2","まぜそば","なし"]})
meshiya=["ZEYO.","天地","龍郎","俺の生きる道","豚八","ごう家","鶏々","松辰","七福軒","松屋","盛清六",
"清六家","好来屋","青葉","活龍","クラレット","銀の豚","AOI","一休","小五郎","麺 the Tokyo",
"はりけんラーメン","油虎","丸長","サイゼリヤ","デニーズ","ココス","ガスト","ジョイフル","ばんどう太郎","ミラ",
"魚米","安曇野","山岡家","Roots","松屋食堂","三水","逆流","角ふじ","天下一品",
"鬼物語","いっとく","喜元門","イチカワ","幸楽苑","レッチリ","どっこい","ららららーめんや","大成軒","百香亭","丸源",
"大元","千香華味","百香亭","夢屋","北方園","どっとくう","えん弥","笑飯店","カサノバ","ハンアリ","豊しん","KURA",
"薔薇絵亭","一太郎","半田屋","すき家","松のや","とよ助","すた丼","フライング・ガーデン","益さん","ウエストハウス","くい亭",
"学生食堂 おかんの飯","李飯店","麺屋 とどろき","がむしゃ"].uniq
kensaku=["飯がちゃ","めしがちゃ","メシガチャ","飯ガチャ","めしガチャ","メシがちゃ"]
change=["チェンジ","ちぇんじ"]

stream_client.user do |tweet|
  if tweet.is_a?(Twitter::Tweet)
    if kensaku.any? {|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
        meshi="#{meshiya.sample}"
        client.update("@#{tweet.user.screen_name}\n【飯ガチャ結果】\nおすすめは #{meshi} です！\n地域：#{hash[meshi][0]}\nジャンル：#{hash[meshi][1]}\n定休日：#{hash[meshi][2]}\n（「チェンジ」でもう１回できます）\n#飯ガチャ",options = {:in_reply_to_status_id => tweet.id})
    end
    if change.any?{|m|tweet.text.include?(m)} && tweet.text.include?("@kossi_klis") && tweet.in_reply_to_status_id? ==true
      if tweet.in_reply_to_user_id==850681445353791488
        if tweet.user.id != 850681445353791488
          meshi="#{meshiya.sample}"
          client.update("@#{tweet.user.screen_name}\n【飯ガチャ結果】\nおすすめは #{meshi} です！\n地域：#{hash[meshi][0]}\nジャンル：#{hash[meshi][1]}\n定休日：#{hash[meshi][2]}\n（「チェンジ」でもう１回できます）\n#飯ガチャ",options = {:in_reply_to_status_id => tweet.id})
        end
      end
    end
  end
end