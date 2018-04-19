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
"松のや"=>["天4","とんかつ","なし"],"はりけんラーメン"=>["栗原","ラーメン","月"],"油虎"=>["花畑(のあたり)","油そば","なし"],"丸長"=>["春4","つけ麺","水"],
"サイゼリヤ"=>["吾妻1(Q't内)","ファミレス","なし"],"デニーズ"=>["春2","ファミレス","なし"],"ココス"=>["天2、桜","ファミレス","なし"],"ガスト"=>["天2、桜","ファミレス","なし"],
"ジョイフル"=>["桜","ファミレス","なし"],"ばんどう太郎"=>["天2","蕎麦屋","なし"],"ミラ"=>["天1、天2","インドカレー","なし"],"魚米"=>["研究学園","回転寿司","なし"],
"安曇野"=>["天1","蕎麦屋",""],"Roots"=>["吾妻3","ラーメン","月、火"],"松屋食堂"=>["天1","ラーメン",""],"三水"=>["上横場(割と離れてる)","ラーメン","なし"],"逆流"=>["小田(めっちゃ遠い)","ラーメン","月"],
"角ふじ"=>["上横場(割と離れてる)","ラーメン","火"],"天下一品"=>["花室","ラーメン","なし"],"鬼物語"=>["榎戸(自転車で行く距離じゃない)","ラーメン",""],
"いっとく"=>["刈間","ラーメン","なし"],"喜元門"=>["研究学園","ラーメン","なし"],"イチカワ"=>["天2","ラーメン","水、日"],
"幸楽苑"=>["小野崎、イーアス","ラーメン","なし"],"レッチリ"=>["研究学園","ラーメン","日"],"どっこい"=>["天1","ラーメン","日"],"ららららーめんや"=>["天1","ラーメン",""],
"大成軒"=>["天1","中華料理","金"],"百香亭"=>["天3、東平塚","中華料理","なし"],"丸源"=>["小野崎","ラーメン","なし"],"大元"=>["天1","中華料理","日"],"千香華味"=>["天3","とんかつ","なし"],
"夢屋"=>["春4","定食屋","水"],"北方園"=>["天2","中華,定食",""],"どっとくう"=>["天2","定食、居酒屋",""],"えん弥"=>["桜","中華料理","なし"],"笑飯店"=>["桜","中華料理","なし"],
"CASA NOVA"=>["天2","イタリアン","なし"],"ハンアリ"=>["天2","韓国焼き肉レストラン","月"],"豊しん"=>["天2","海鮮料理","木"],"KURA"=>["天2","","なし"],
"薔薇絵亭"=>["天2","洋食レストラン","なし"],"一太郎"=>["天2","お好み焼き",""],"半田屋"=>["天3","定食屋","なし"],"すき家"=>["天3","牛丼","なし"],
"とよ助"=>["天1","焼き鳥、居酒屋","火"],"すた丼"=>["天2","定食屋","なし"],"フライング・ガーデン"=>["西平塚","レストラン","なし"],"益さん"=>["天3","定食屋","なし"],
"ウエストハウス"=>["西平塚","レストラン","なし"],"くい亭"=>["上野(桜の奥の方)","レストラン","土、日"],"おかんの飯"=>["天3","定食屋","火、木、土、日"],"李飯店"=>["春3","中華料理",""],
"とどろき"=>["ラーメン","花畑","月"],"がむしゃ"=>["筑穂","ラーメン","日"],"ドルフ"=>["天3","カフェレストラン","日"],"アリーズ・ケバブ"=>["天2","レストラン","なし"]}
hash.update(list)

ramenya=["天地","龍郎","俺の生きる道","豚八","ごう家","鶏々","松辰","七福軒","盛清六",
"清六家","青葉","活龍","銀の豚","AOI","一休","小五郎","麺 the Tokyo","はりけんラーメン",
"油虎","丸長","Roots","松屋食堂","三水","逆流","角ふじ","天下一品","鬼物語","いっとく",
"喜元門","イチカワ","幸楽苑","レッチリ","どっこい","ららららーめんや","丸源","大元","とどろき","がむしゃ","幸楽苑"].uniq

gyudonya=["松屋","吉野家","すき家"]

meshiya=list.keys.uniq
unagiya=["松のや","松のや","松乃家"]

# otakugatya=["だいこん"]

kensaku=["飯がちゃ","めしがちゃ","メシガチャ","飯ガチャ","めしガチャ","メシがちゃ"]
change=["チェンジ","ちぇんじ"]
ramengacha=["ラーメンガチャ","ラーメンがちゃ","らーめんがちゃ","らーめんガチャ"]
kaedama=["おかわり","かえだま",]
gyudon=["牛丼ガチャ","ビーフボウル","牛丼がちゃ","びーふぼうるがちゃ","ぎゅうどんがちゃ","びーふがちゃ","ビーフガチャ"]
matsunoya=["気分じゃない","きぶんじゃない","ちゃぶ台返し","ちゃぶだいがえし"]
otaku=["オタクガチャ","おたくがちゃ"]
jikanwari=["こっしーじかんわり","こっしー時間割","jknwr","zknwr"]

#起動文言
# client.update("飯ガチャを更新しました！現在結果として出るのは#{meshiya.size}店です！")
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
    # オタクガチャ
    if otaku.any? {|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      motaku="#{otakugatya.sample}"
      client.update("@#{tweet.user.screen_name}\n【オタクガチャ結果】\n#{motaku}はオタクです！\n@die_con_p\n#オタクガチャ",options = {:in_reply_to_status_id => tweet.id})
    end
    if jikanwari.any?{|m|tweet.text.include?(m)} && !tweet.in_reply_to_status_id && !tweet.retweeted_status ==true
      client.update("@#{tweet.user.screen_name}\n1限：8:40～9:55\n2限：10:10～11:25\n昼休み：11:25～12:15\n3限：12:15～13:30\n4限：13:45～15:00\n5限：15:15～16:30\n6限：16:45～18:00",options = {:in_reply_to_status_id => tweet.id})
    end
  end
end
