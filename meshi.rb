#encodiing: Windows-31J
require 'twitter'
# require 'date'
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
# nowTime = DateTime.now
# time="#{nowTime.hour}時#{nowTime.minute}分#{nowTime.second}秒"
#フォーマット
#"飯屋"=>["地域","ジャンル","定休日"] =>["","",""]
hash=Hash.new(["設定中です","設定中です","設定中です"])
list={"ZEYO."=>["天2","カレーうどん","なし"], "天地"=>["天2","まぜそば","なし"], "龍郎"=>["吾妻3","ラーメン","なし"],
"俺の生きる道"=>["吾妻3","ラーメン","なし"],"豚八"=>["天1","ラーメン","火"],"ごう家"=>["天2","ラーメン","なし"],
"鶏々"=>["天2","ラーメン","火"],"松辰"=>["天1","ラーメン","月"],"七福軒"=>["天1","ラーメン","日"],"松屋"=>["春4・桜","牛めし","なし"],
"盛清六"=>["天2","ラーメン","月"],"清六家"=>["天3","ラーメン","なし"],"好来屋"=>["天2","中華料理","なし"],"青葉"=>["竹園1","ラーメン","なし"],
"活龍"=>["竹園1","ラーメン","なし"],"クラレット"=>["天3","丼物など","土"],"銀の豚"=>["桜","ラーメン","なし"],
"AOI"=>["竹園2","ラーメン","水"],"一休"=>["桜","ラーメン","なし"],"小五郎"=>["桜","ラーメン","月"],"麺 the Tokyo"=>["天3","ラーメン","日"],"松乃家"=>["桜","うなぎ","月、火"],
"松のや"=>["天4","とんかつ","なし"]}
# "はりけんラーメン"=>["","",""],"油虎"=>["","",""],"丸長"=>["","",""],"サイゼリヤ"=>["","",""],"デニーズ"=>["","",""],"ココス"=>["","",""],"ガスト"=>["","",""],
# "ジョイフル"=>["","",""],"ばんどう太郎"=>["","",""],"ミラ"=>["","",""],
# "魚米","安曇野","山岡家","Roots","松屋食堂","三水","逆流","角ふじ","天下一品",
# "鬼物語","いっとく","喜元門","イチカワ","幸楽苑","レッチリ","どっこい","ららららーめんや","大成軒","百香亭","丸源",
# "大元","千香華味","百香亭","夢屋","北方園","どっとくう","えん弥","笑飯店","カサノバ","ハンアリ","豊しん","KURA",
# "薔薇絵亭","一太郎","半田屋","すき家","とよ助","すた丼","フライング・ガーデン","益さん","ウエストハウス","くい亭",
# "学生食堂 おかんの飯","李飯店","麺屋 とどろき","がむしゃ"}
hash.update(list)

ramenya=["天地","龍郎","俺の生きる道","豚八","ごう家","鶏々","松辰","七福軒","盛清六",
"清六家","青葉","活龍","銀の豚","AOI","一休","小五郎","麺 the Tokyo","はりけんラーメン",
"油虎","丸長","山岡家","Roots","松屋食堂","三水","逆流","角ふじ","天下一品","鬼物語","いっとく",
"喜元門","イチカワ","幸楽苑","レッチリ","どっこい","ららららーめんや","丸源","大元","麺屋 とどろき","がむしゃ"]

gyudonya=["松屋","吉野家","すき家"]

meshiya=["ZEYO.","天地","龍郎","俺の生きる道","豚八","ごう家","鶏々","松辰","七福軒","松屋","盛清六",
"清六家","好来屋","青葉","活龍","クラレット","銀の豚","AOI","一休","小五郎","麺 the Tokyo",
"はりけんラーメン","油虎","丸長","サイゼリヤ","デニーズ","ココス","ガスト","ジョイフル","ばんどう太郎","ミラ",
"魚米","安曇野","山岡家","Roots","松屋食堂","三水","逆流","角ふじ","天下一品",
"鬼物語","いっとく","喜元門","イチカワ","幸楽苑","レッチリ","どっこい","ららららーめんや","大成軒","百香亭","丸源",
"大元","千香華味","百香亭","夢屋","北方園","どっとくう","えん弥","笑飯店","カサノバ","ハンアリ","豊しん","KURA",
"薔薇絵亭","一太郎","半田屋","すき家","松のや","とよ助","すた丼","フライング・ガーデン","益さん","ウエストハウス","くい亭",
"学生食堂 おかんの飯","李飯店","麺屋 とどろき","がむしゃ"].uniq
unagiya=["松のや","松のや","松乃家"]

otakugatya=["だいこん"]

kensaku=["飯がちゃ","めしがちゃ","メシガチャ","飯ガチャ","めしガチャ","メシがちゃ"]
change=["チェンジ","ちぇんじ"]
ramengacha=["ラーメンガチャ","ラーメンがちゃ","らーめんがちゃ","らーめんガチャ"]
kaedama=["おかわり","かえだま",]
gyudon=["牛丼ガチャ","ビーフボウル","牛丼がちゃ","びーふぼうるがちゃ","ぎゅうどんがちゃ","びーふがちゃ","ビーフガチャ"]
matsunoya=["気分じゃない","きぶんじゃない","ちゃぶ台返し","ちゃぶだいがえし"]
otaku=["オタクガチャ","おたくがちゃ"]
jikanwari=["時間割","じかんわり"]

stream_client.user do |tweet|
  if tweet.is_a?(Twitter::Tweet)
    puts(tweet.user.name)
    puts("@#{tweet.user.screen_name}")
    puts(tweet.text)
    puts("-----")
    #めしがちゃ
    if kensaku.any? {|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      meshi="#{meshiya.sample}"
      client.update("@#{tweet.user.screen_name}\n【飯ガチャ結果】\nおすすめは #{meshi} です！\n地域：#{hash[meshi][0]}\nジャンル：#{hash[meshi][1]}\n定休日：#{hash[meshi][2]}\n（「チェンジ」でもう１回抽選できます）\n#飯ガチャ",options = {:in_reply_to_status_id => tweet.id})
    end
    #飯ガチャチェンジ
    if change.any?{|m|tweet.text.include?(m)} && tweet.text.include?("@kossi_klis") && tweet.in_reply_to_status_id? ==true
      if tweet.in_reply_to_user_id==850681445353791488
        if tweet.user.id != 850681445353791488
          meshi="#{meshiya.sample}"
          client.update("@#{tweet.user.screen_name}\n【飯ガチャ結果】\nおすすめは #{meshi} です！\n地域：#{hash[meshi][0]}\nジャンル：#{hash[meshi][1]}\n定休日：#{hash[meshi][2]}\n（「チェンジ」でもう１回抽選できます）\n#飯ガチャ",options = {:in_reply_to_status_id => tweet.id})
        end
      end
    end

    #ラーメンガチャ
    if ramengacha.any?{|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      ramen="#{ramenya.sample}"
      client.update("@#{tweet.user.screen_name}\n【ラーメンガチャ結果】\nおすすめのラーメン屋は #{ramen} だ！\n地域：#{hash[ramen][0]}\nジャンル：#{hash[ramen][1]}\n定休日：#{hash[ramen][2]}\n（「おかわり」「かえだま」でもう１回抽選します）\n#ラーメンガチャ",options = {:in_reply_to_status_id => tweet.id})
    end
    #ラーメンガチャチェンジ
    if kaedama.any?{|m|tweet.text.include?(m)} && tweet.text.include?("@kossi_klis") && tweet.in_reply_to_status_id? ==true
      if tweet.in_reply_to_user_id==850681445353791488
        if tweet.user.id != 850681445353791488
          ramen="#{ramenya.sample}"
          client.update("@#{tweet.user.screen_name}\n【ラーメンガチャ結果】\nおすすめのラーメン屋は #{ramen} だ！\n地域：#{hash[ramen][0]}\nジャンル：#{hash[ramen][1]}\n定休日：#{hash[ramen][2]}\n（「おかわり」「かえだま」でもう１回抽選します）\n#ラーメンガチャ",options = {:in_reply_to_status_id => tweet.id})
        end
      end
    end
    #ビーフボウルガチャ
    if gyudon.any? {|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      gyu="#{gyudonya.sample}"
      client.update("@#{tweet.user.screen_name}\n【ビーフボウルガチャ結果】\nおすすめは #{gyu} です！\n地域：#{hash[gyu][0]}\nジャンル：#{hash[gyu][1]}\n定休日：#{hash[gyu][2]}\n（「気分じゃない」「ちゃぶ台返し」でもう１回抽選できます）\n#ビーフボウルガチャ",options = {:in_reply_to_status_id => tweet.id})
    end
    #ビーフボウルガチャチェンジ
    if matsunoya.any?{|m|tweet.text.include?(m)} && tweet.text.include?("@kossi_klis") && tweet.in_reply_to_status_id? ==true
      if tweet.in_reply_to_user_id==850681445353791488
        if tweet.user.id != 850681445353791488
          unagi="#{unagiya.sample}"
          client.update("@#{tweet.user.screen_name}\n【まつのやガチャ結果】\nおすすめのは#{unagi}だ！\n地域：#{hash[unagi][0]}\nジャンル：#{hash[unagi][1]}\n定休日：#{hash[unagi][2]}\n（「気分じゃない」「ちゃぶ台返し」でもう１回いずれかの「まつのや」を表示します）\n#まつのやガチャ",options = {:in_reply_to_status_id => tweet.id})
        end
      end
    end
    #オタクガチャ
    if otaku.any? {|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      motaku="#{otakugatya.sample}"
      client.update("@#{tweet.user.screen_name}\n【オタクガチャ結果】\n#{motaku}はオタクです！\n@die_con_p\n#オタクガチャ",options = {:in_reply_to_status_id => tweet.id})
    end
　　#時間割
    if jikanwari.any?{|m|tweet.text.include?(m)}  && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      client.update("1限：8:40～9:55\n2限：10:10～11:25\n昼休み：11:25～12:15\n3限：12:15～13:30\n4限：13:45～15:00\n5限：15:15～16:30\n6限：16:45～18:00")
    end
  end
end
