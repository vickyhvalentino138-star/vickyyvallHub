local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local HubName = "vickyyvallHub_Perfect"
if CoreGui:FindFirstChild(HubName) then CoreGui[HubName]:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = HubName
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local FontTitle = Enum.Font.GothamBold
local FontMain = Enum.Font.GothamBold
local FontDesc = Enum.Font.GothamMedium
local FontESP = Enum.Font.GothamBold
local FontUniversal = Enum.Font.SourceSansBold -- Penyelamat bahasa kotak-kotak

local ColorMain = Color3.fromRGB(15, 15, 18)
local ColorSidebar = Color3.fromRGB(8, 8, 10)
local ColorContent = Color3.fromRGB(20, 20, 25)
local ColorAccent = Color3.fromRGB(80, 120, 255)
local ColorToggleOff = Color3.fromRGB(40, 40, 45)
local ColorText = Color3.fromRGB(245, 245, 250)
local ColorDesc = Color3.fromRGB(160, 160, 170)
local ColorDisabled = Color3.fromRGB(30, 30, 35)

local ActiveLanguage = "Indonesia (Default)"
local TranslationElements = {}

local LangDict = {
    ["Char_Title"] = {ID = "Karakter", EN = "Character", PT = "Personagem", ZH = "角色", ES = "Personaje", AR = "شخصية", FR = "Personnage", RU = "Персонаж", HI = "चरित्र", DE = "Charakter"},
    ["Vis_Title"] = {ID = "Visual", EN = "Visual", PT = "Visual", ZH = "视觉", ES = "Visual", AR = "بصري", FR = "Visuel", RU = "Визуал", HI = "दृश्य", DE = "Visuell"},
    ["World_Title"] = {ID = "Dunia", EN = "World", PT = "Mundo", ZH = "世界", ES = "Mundo", AR = "عالم", FR = "Monde", RU = "Мир", HI = "विश्व", DE = "Welt"},
    ["Sys_Title"] = {ID = "Info & Sistem", EN = "Info & System", PT = "Informação", ZH = "信息与系统", ES = "Información", AR = "النظام", FR = "Info & Système", RU = "Система", HI = "सिस्टम", DE = "Info & System"},
    
    ["Reset_T"] = {ID = "Respawn", EN = "Respawn", PT = "Renascer", ZH = "重置", ES = "Reaparecer", AR = "إعادة تعيين", FR = "Réapparaître", RU = "Респавн", HI = "पुनर्जन्म", DE = "Wiederbelebung"},
    ["Reset_D"] = {
        ID = "Hancurkan karaktermu untuk hidup kembali di titik awal! Sangat seru dan berguna jika kamu tersesat atau butuh darah penuh seketika.",
        EN = "Destroy your character to respawn at the start! Very fun and useful if you are lost or need full health instantly.",
        PT = "Destrua seu personagem para renascer no início! Muito divertido e útil se você se perder ou precisar de saúde instantânea.",
        ZH = "摧毁你的角色并在起点重生！如果你迷路或需要立刻恢复满血，这非常有趣且有用。",
        ES = "¡Destruye tu personaje para reaparecer al principio! Muy divertido y útil si te pierdes o necesitas salud al instante.",
        AR = "دمر شخصيتك لتولد من جديد في البداية! ممتع ومفيد جدا إذا ضللت طريقك أو احتجت لصحة كاملة.",
        FR = "Détruis ton personnage pour réapparaître au début ! Très amusant et utile si tu es perdu ou as besoin de santé.",
        RU = "Уничтожьте персонажа, чтобы возродиться! Очень весело и полезно, если вы заблудились или нужно полное здоровье.",
        HI = "शुरुआत में फिर से जन्म लेने के लिए अपने चरित्र को नष्ट करें! यदि आप खो गए हैं तो बहुत मजेदार और उपयोगी है।",
        DE = "Zerstöre deinen Charakter, um am Start neu zu spawnen! Sehr lustig und nützlich, wenn du dich verirrst."
    },
    
    ["Rejoin_T"] = {ID = "Rejoin", EN = "Rejoin", PT = "Reentrar", ZH = "重新加入", ES = "Reunirse", AR = "إعادة الانضمام", FR = "Rejoindre", RU = "Перезайти", HI = "फिर से जुड़ें", DE = "Erneut beitreten"},
    ["Rejoin_D"] = {
        ID = "Keluar sebentar dan masuk lagi ke server yang sama bagaikan kilat! Cocok banget untuk menyegarkan game kamu yang sedang lag.",
        EN = "Leave briefly and rejoin the same server like lightning! Perfect for refreshing your game if it's lagging.",
        PT = "Saia brevemente e volte ao mesmo servidor como um raio! Perfeito para atualizar seu jogo se estiver travando.",
        ZH = "短暂离开并闪电般重新加入同一个服务器！如果游戏卡顿，这是刷新游戏的完美选择。",
        ES = "¡Sal brevemente y vuelve al mismo servidor como un rayo! Perfecto para refrescar tu juego si hay lag.",
        AR = "اخرج لفترة وجيزة وعد إلى نفس الخادم مثل البرق! مثالي لتحديث لعبتك إذا كانت بطيئة.",
        FR = "Quittez brièvement et rejoignez le même serveur comme l'éclair ! Parfait pour rafraîchir un jeu qui lag.",
        RU = "Ненадолго выйдите и молниеносно вернитесь на тот же сервер! Идеально для обновления игры при лагах.",
        HI = "थोड़ी देर के लिए छोड़ें और उसी सर्वर में बिजली की तरह फिर से जुड़ें! गेम ताज़ा करने के लिए एकदम सही है।",
        DE = "Verlasse das Spiel kurz und trete demselben Server wie ein Blitz wieder bei! Perfekt bei Lags."
    },
    
    ["Hop_T"] = {ID = "Server Hop", EN = "Server Hop", PT = "Pular Servidor", ZH = "寻找新服务器", ES = "Salto de servidor", AR = "تغيير الخادم", FR = "Saut de serveur", RU = "Смена сервера", HI = "सर्वर बदलें", DE = "Server-Hop"},
    ["Hop_D"] = {
        ID = "Jalan-jalan mencari server baru yang lebih seru! Sistem akan otomatis memindahkanmu untuk bertemu teman dan petualangan baru.",
        EN = "Take a trip to find a more exciting new server! The system will automatically move you to meet new friends.",
        PT = "Faça uma viagem para encontrar um servidor mais emocionante! O sistema moverá você automaticamente.",
        ZH = "去寻找一个更刺激的新服务器吧！系统会自动将你转移，去结识新朋友和新冒险。",
        ES = "¡Haz un viaje para encontrar un servidor más emocionante! El sistema te moverá automáticamente para conocer nuevos amigos.",
        AR = "قم برحلة للعثور على خادم جديد أكثر إثارة! سينقلك النظام تلقائيًا لمقابلة أصدقاء جدد.",
        FR = "Partez à la recherche d'un nouveau serveur plus excitant ! Le système vous déplacera automatiquement.",
        RU = "Отправляйтесь на поиски более захватывающего сервера! Система автоматически переместит вас к новым друзьям.",
        HI = "अधिक रोमांचक सर्वर खोजने के लिए यात्रा करें! सिस्टम स्वचालित रूप से आपको नए दोस्तों से मिलने के लिए ले जाएगा।",
        DE = "Mach dich auf die Suche nach einem aufregenderen Server! Das System verschiebt dich automatisch."
    },
    
    ["Speed_T"] = {ID = "Run Speed", EN = "Run Speed", PT = "Velocidade", ZH = "移动速度", ES = "Velocidad", AR = "السرعة", FR = "Vitesse", RU = "Скорость бега", HI = "गति", DE = "Laufgeschwindigkeit"},
    ["Speed_D"] = {
        ID = "Berlari secepat pahlawan super! Jelajahi seluruh dunia dengan kecepatan kilat tanpa takut tertinggal oleh teman-temanmu.",
        EN = "Run as fast as a superhero! Explore the whole world at lightning speed without fear of being left behind.",
        PT = "Corra tão rápido quanto um super-herói! Explore o mundo inteiro na velocidade da luz.",
        ZH = "像超级英雄一样奔跑！以闪电般的速度探索整个世界，不怕被朋友抛在后面。",
        ES = "¡Corre tan rápido como un superhéroe! Explora el mundo a la velocidad del rayo sin miedo a quedarte atrás.",
        AR = "اركض بسرعة بطل خارق! استكشف العالم كله بسرعة البرق دون خوف من التخلف عن الركب.",
        FR = "Courez aussi vite qu'un super-héros ! Explorez le monde à la vitesse de l'éclair.",
        RU = "Беги так же быстро, как супергерой! Исследуй весь мир со скоростью молнии.",
        HI = "एक सुपरहीरो की तरह तेजी से दौड़ें! पीछे छूटने के डर के बिना पूरी दुनिया का अन्वेषण करें।",
        DE = "Renne so schnell wie ein Superheld! Erkunde die ganze Welt in Blitzgeschwindigkeit."
    },
    
    ["Jump_T"] = {ID = "Jump Power", EN = "Jump Power", PT = "Pulo", ZH = "跳跃高度", ES = "Poder de salto", AR = "قوة القفز", FR = "Puissance de saut", RU = "Сила прыжка", HI = "जंप पावर", DE = "Sprungkraft"},
    ["Jump_D"] = {
        ID = "Lompat super tinggi seperti katak ajaib! Lewati gedung dan rintangan besar dengan sangat mudah dan menyenangkan.",
        EN = "Jump super high like a magic frog! Pass huge buildings and obstacles very easily and happily.",
        PT = "Pule super alto como um sapo mágico! Passe por prédios e obstáculos enormes com muita facilidade.",
        ZH = "像神奇的青蛙一样跳得超级高！非常轻松愉快地越过巨大的建筑物和障碍物。",
        ES = "¡Salta súper alto como una rana mágica! Pasa edificios y obstáculos enormes muy fácilmente.",
        AR = "اقفز عاليا جدا مثل الضفدع السحري! تجاوز المباني والعقبات الضخمة بسهولة شديدة وسعادة.",
        FR = "Sautez très haut comme une grenouille magique ! Dépassez les grands bâtiments et les obstacles facilement.",
        RU = "Прыгай супер высоко, как волшебная лягушка! Легко преодолевай огромные здания и препятствия.",
        HI = "एक जादुई मेंढक की तरह सुपर हाई जंप करें! बड़ी इमारतों और बाधाओं को बहुत आसानी से पार करें।",
        DE = "Spring super hoch wie ein magischer Frosch! Überwinde riesige Gebäude und Hindernisse ganz einfach."
    },
    
    ["Inf_T"] = {ID = "Inf Jump", EN = "Inf Jump", PT = "Pulo Infinito", ZH = "无限跳跃", ES = "Salto infinito", AR = "قفز غير محدود", FR = "Saut infini", RU = "Бесконечные прыжки", HI = "अनंत जंप", DE = "Unendlicher Sprung"},
    ["Inf_D"] = {
        ID = "Terbang ke angkasa dengan melompat berkali-kali di udara! Rasakan keajaiban melayang tanpa harus menyentuh tanah.",
        EN = "Fly into the sky by jumping multiple times in the air! Feel the magic of floating without touching the ground.",
        PT = "Voe para o céu pulando várias vezes no ar! Sinta a magia de flutuar sem tocar o chão.",
        ZH = "在空中多次跳跃飞向天空！感受脚不沾地漂浮的魔力。",
        ES = "¡Vuela hacia el cielo saltando varias veces en el aire! Siente la magia de flotar sin tocar el suelo.",
        AR = "طِر إلى السماء بالقفز عدة مرات في الهواء! اشعر بسحر الطفو دون أن تلمس الأرض.",
        FR = "Volez dans le ciel en sautant plusieurs fois en l'air ! Sentez la magia de flotter sans toucher le sol.",
        RU = "Лети в небо, прыгая в воздухе несколько раз! Почувствуй магию полета, не касаясь земли.",
        HI = "हवा में कई बार कूदकर आसमान में उड़ें! जमीन को छुए बिना तैरने के जादू को महसूस करें।",
        DE = "Fliege in den Himmel, indem du mehrmals in die Luft springst! Spüre die Magie des Schwebens."
    },
    
    ["Noclip_T"] = {ID = "Noclip", EN = "Noclip", PT = "Noclip", ZH = "穿墙", ES = "Atravesar", AR = "اختراق الجدران", FR = "Passe-muraille", RU = "Сквозь стены", HI = "दीवार के पार", DE = "Durch Wände gehen"},
    ["Noclip_D"] = {
        ID = "Jadilah hantu sakti yang bisa menembus tembok tebal dan rintangan apapun! Jalan pintas terbaik untuk menjelajahi map.",
        EN = "Become a magic ghost that can pass through thick walls and any obstacles! The best shortcut to explore the map.",
        PT = "Torne-se um fantasma mágico que pode passar por paredes grossas! O melhor atalho para explorar o mapa.",
        ZH = "成为一个可以穿透厚墙和任何障碍物的神奇幽灵！探索地图的最佳捷径。",
        ES = "¡Conviértete en un fantasma mágico que puede atravesar paredes gruesas! El mejor atajo para explorar el mapa.",
        AR = "كن شبحًا سحريًا يمكنه المرور عبر الجدران السميكة! أفضل طريق مختصر لاستكشاف الخريطة.",
        FR = "Devenez un fantôme magique qui traverse les murs épais ! Le meilleur raccourci pour explorer la carte.",
        RU = "Станьте волшебным призраком, проходящим сквозь толстые стены! Лучший короткий путь для исследования карты.",
        HI = "एक जादुई भूत बनें जो मोटी दीवारों और किसी भी बाधा से गुजर सकता है! नक्शे का पता लगाने का सबसे अच्छा शॉर्टकट।",
        DE = "Werde zum magischen Geist, der durch dicke Wände gehen kann! Die beste Abkürzung, um die Karte zu erkunden."
    },
    
    ["Fly_T"] = {ID = "Fly Mode", EN = "Fly Mode", PT = "Voar", ZH = "飞行模式", ES = "Volar", AR = "طيران", FR = "Voler", RU = "Полет", HI = "उड़ना", DE = "Fliegen"},
    ["Fly_D"] = {
        ID = "Terbang bebas seperti burung di langit! Bebas arahkan kameramu dan lihat indahnya seluruh dunia dari atas awan.",
        EN = "Fly freely like a bird in the sky! Point your camera freely and see the beauty of the world from above the clouds.",
        PT = "Voe livremente como um pássaro no céu! Aponte sua câmera e veja a beleza do mundo de cima.",
        ZH = "像天空中的鸟儿一样自由飞翔！自由转动你的相机，从云端俯瞰世界的美丽。",
        ES = "¡Vuela libremente como un pájaro en el cielo! Apunta tu cámara y mira la belleza del mundo desde arriba.",
        AR = "طر بحرية مثل طائر في السماء! وجه الكاميرا بحرية وشاهد جمال العالم من فوق السحاب.",
        FR = "Volez librement comme un oiseau dans le ciel ! Pointez votre caméra et admirez la beauté du monde.",
        RU = "Летай свободно, как птица в небе! Направляй камеру и смотри на красоту мира из-за облаков.",
        HI = "आसमान में एक पक्षी की तरह स्वतंत्र रूप से उड़ें! अपने कैमरे को घुमाएं और बादलों के ऊपर से दुनिया की सुंदरता देखें।",
        DE = "Fliege frei wie ein Vogel im Himmel! Richte deine Kamera aus und sieh dir die Schönheit der Welt von oben an."
    },
    
    ["ESP_T"] = {ID = "Name ESP", EN = "Name ESP", PT = "ESP Nome", ZH = "名字 ESP", ES = "ESP Nombre", AR = "كاشف الأسماء", FR = "Nom ESP", RU = "ВХ Имена", HI = "नाम ESP", DE = "Name ESP"},
    ["ESP_D"] = {
        ID = "Mata-mata super! Lihat nama dan jarak semua pemain dari jauh, bahkan kalau mereka sedang ngumpet di balik dinding.",
        EN = "Super spy! See the names and distances of all players from afar, even if they are hiding behind walls.",
        PT = "Super espião! Veja os nomes e distâncias de todos os jogadores, mesmo se eles estiverem escondidos.",
        ZH = "超级间谍！从远处看到所有玩家的名字和距离，即使他们躲在墙后。",
        ES = "¡Súper espía! Mira los nombres y las distancias de todos los jugadores desde lejos, incluso si se esconden.",
        AR = "جاسوس خارق! شاهد أسماء ومسافات جميع اللاعبين من بعيد، حتى لو كانوا يختبئون خلف الجدران.",
        FR = "Super espion ! Voyez les noms et les distances de tous les joueurs de loin, même s'ils se cachent.",
        RU = "Супершпион! Смотри имена и расстояния всех игроков издалека, даже если они прячутся за стенами.",
        HI = "सुपर जासूस! दूर से सभी खिलाड़ियों के नाम और दूरियां देखें, भले ही वे दीवारों के पीछे छिपे हों।",
        DE = "Superspion! Sieh die Namen und Entfernungen aller Spieler von weitem, selbst wenn sie sich verstecken."
    },
    
    ["HP_T"] = {ID = "Health ESP", EN = "Health ESP", PT = "ESP Vida", ZH = "血量 ESP", ES = "ESP Salud", AR = "كاشف الصحة", FR = "Santé ESP", RU = "ВХ Здоровье", HI = "स्वास्थ्य ESP", DE = "Gesundheit ESP"},
    ["HP_D"] = {
        ID = "Kacamata medis canggih! Ketahui sisa darah musuhmu dengan cepat. Sangat berguna untuk tahu siapa yang harus dikejar.",
        EN = "Advanced medical glasses! Know your enemy's remaining health quickly. Very useful to know who to chase.",
        PT = "Óculos médicos avançados! Saiba a saúde restante do seu inimigo rapidamente. Muito útil para saber quem perseguir.",
        ZH = "高级医疗眼镜！快速了解敌人的剩余生命值。非常有用，知道该追谁。",
        ES = "¡Gafas médicas avanzadas! Conoce la salud restante de tu enemigo rápidamente. Muy útil para saber a quién perseguir.",
        AR = "نظارات طبية متقدمة! تعرف على صحة عدوك المتبقية بسرعة. مفيد جدا لمعرفة من يجب مطاردته.",
        FR = "Lunettes médicales avancées ! Connaissez rapidement la santé restante de vos ennemis. Très utile.",
        RU = "Передовые медицинские очки! Быстро узнай оставшееся здоровье врага. Очень полезно знать, за кем гнаться.",
        HI = "उन्नत चिकित्सा चश्मा! अपने दुश्मन के शेष स्वास्थ्य को जल्दी से जानें। यह जानना बहुत उपयोगी है कि किसका पीछा करना है।",
        DE = "Erweiterte medizinische Brille! Erkenne schnell die verbleibende Gesundheit deines Feindes. Sehr nützlich."
    },
    
    ["Box_T"] = {ID = "Box ESP", EN = "Box ESP", PT = "ESP Caixa", ZH = "方框 ESP", ES = "ESP Caja", AR = "كاشف الصناديق", FR = "Boîte ESP", RU = "ВХ Боксы", HI = "बॉक्स ESP", DE = "Box ESP"},
    ["Box_D"] = {
        ID = "Kurung musuh dalam kotak cahaya ajaib! Kamu tidak akan pernah kehilangan jejak mereka meski dari jarak jauh sekalipun.",
        EN = "Enclose enemies in a magic light box! You will never lose track of them even from a very long distance.",
        PT = "Cerque inimigos em uma caixa de luz mágica! Você nunca os perderá de vista, mesmo de longe.",
        ZH = "将敌人关在神奇的灯箱中！即使在很远的距离，你也永远不会失去他们的踪迹。",
        ES = "¡Enierra a los enemigos en una caja de luz mágica! Nunca les perderás el rastro, incluso desde muy lejos.",
        AR = "قم بحبس الأعداء في صندوق إضاءة سحري! لن تفقد أثرهم أبدا حتى من مسافة بعيدة جدا.",
        FR = "Enfermez les ennemis dans une boîte lumineuse magique ! Vous ne perdrez jamais leur trace.",
        RU = "Помести врагов в волшебную световую коробку! Ты никогда не потеряешь их из виду даже издалека.",
        HI = "दुश्मनों को एक जादुई प्रकाश बॉक्स में बंद करें! आप कभी भी उनका ट्रैक नहीं खोएंगे, यहां तक कि बहुत दूर से भी।",
        DE = "Sperre Feinde in eine magische Lichtbox ein! Du wirst sie auch aus großer Entfernung nie aus den Augen verlieren."
    },

    ["Map_NotFound"] = {ID = "Tidak Ditemukan", EN = "Not Found", PT = "Não Encontrado", ZH = "未找到", ES = "No Encontrado", AR = "غير موجود", FR = "Introuvable", RU = "Не найдено", HI = "नहीं मिला", DE = "Nicht gefunden"},        
    
    ["Day_T"] = {ID = "Daylight", EN = "Daylight", PT = "Dia", ZH = "白昼模式", ES = "Día", AR = "نهار دائم", FR = "Jour", RU = "Вечный день", HI = "दिन का समय", DE = "Tageslicht"},
    ["Day_D"] = {
        ID = "Sulap malam yang gelap gulita menjadi siang yang cerah abadi! Main jadi lebih asyik karena kamu bisa melihat semuanya.",
        EN = "Turn the pitch-black night into an eternal bright day! Playing is more fun because you can see everything.",
        PT = "Transforme a noite escura em um dia claro e eterno! Brincar é mais divertido porque você pode ver tudo.",
        ZH = "将漆黑的夜晚变成永恒的明亮白天！游戏更有趣，因为你可以看到一切。",
        ES = "¡Convierte la noche oscura en un día brillante y eterno! Jugar es más divertido porque puedes ver todo.",
        AR = "حول الليل المظلم إلى نهار مشرق أبدي! اللعب أكثر متعة لأنك تستطيع رؤية كل شيء.",
        FR = "Transformez la nuit noire en un jour éternellement lumineux ! Jouer est plus amusant car vous voyez tout.",
        RU = "Преврати кромешную ночь в вечный яркий день! Играть веселее, потому что ты все видишь.",
        HI = "घनी अंधेरी रात को एक अनन्त उज्ज्वल दिन में बदल दें! खेलना अधिक मजेदार है क्योंकि आप सब कुछ देख सकते हैं।",
        DE = "Verwandle die pechschwarze Nacht in einen ewigen, hellen Tag! Das Spielen macht mehr Spaß."
    },
    
    ["Glow_T"] = {ID = "Fullbright", EN = "Fullbright", PT = "Brilho Total", ZH = "全亮模式", ES = "Brillo Total", AR = "سطوع كامل", FR = "Luminosité", RU = "Яркость", HI = "फुलब्राइट", DE = "Volle Helligkeit"},
    ["Glow_D"] = {
        ID = "Nyalakan lampu ke seluruh penjuru dunia! Hapus semua bayangan seram agar setiap gua dan ruangan jadi terang benderang.",
        EN = "Turn on the lights all over the world! Remove all scary shadows so every cave and room becomes bright.",
        PT = "Acenda as luzes de todo o mundo! Remova todas as sombras assustadoras para que cada caverna fique iluminada.",
        ZH = "打开全世界的灯！消除所有可怕的阴影，让每个洞穴和房间都变得明亮。",
        ES = "¡Enciende las luces en todo el mundo! Elimina las sombras aterradoras para que cada cueva y habitación brille.",
        AR = "شغل الأضواء في جميع أنحاء العالم! قم بإزالة جميع الظلال المخيفة حتى يصبح كل كهف وغرفة مشرقا.",
        FR = "Allumez les lumières partout ! Supprimez toutes les ombres effrayantes pour que chaque grotte soit lumineuse.",
        RU = "Включи свет по всему миру! Убери все страшные тени, чтобы каждая пещера и комната стали светлыми.",
        HI = "पूरी दुनिया में रोशनी चालू करें! सभी डरावनी परछाइयों को हटा दें ताकि हर गुफा और कमरा उज्ज्वल हो जाए।",
        DE = "Schalte die Lichter auf der ganzen Welt ein! Entferne alle gruseligen Schatten, damit jede Höhle hell wird."
    },
    
    ["AFK_T"] = {ID = "Anti-AFK", EN = "Anti-AFK", PT = "Anti-AFK", ZH = "防挂机", ES = "Anti-AFK", AR = "مضاد الطرد", FR = "Anti-AFK", RU = "Анти-АФК", HI = "एंटी-AFK", DE = "Anti-AFK"},
    ["AFK_D"] = {
        ID = "Perlindungan super agar kamu tidak ditendang keluar saat diam! Bisa ditinggal tidur atau makan dengan 100% aman.",
        EN = "Super protection so you don't get kicked out when idle! You can leave it to sleep or eat 100% safely.",
        PT = "Super proteção para você não ser expulso! Você pode deixar para dormir ou comer com 100% de segurança.",
        ZH = "超级保护，让你在发呆时不会被踢出游戏！你可以100%安全地离开去睡觉或吃饭。",
        ES = "¡Súper protección para que no te expulsen cuando estás inactivo! Puedes ir a dormir o comer 100% seguro.",
        AR = "حماية فائقة حتى لا يتم طردك عند الخمول! يمكنك تركه للنوم أو تناول الطعام بأمان تام.",
        FR = "Super protection pour ne pas être expulsé ! Laissez le jeu pour dormir ou manger en toute sécurité.",
        RU = "Супер защита, чтобы тебя не выгнали, когда ты АФК! Можешь смело спать или есть на 100% безопасно.",
        HI = "सुपर सुरक्षा ताकि जब आप निष्क्रिय हों तो आपको बाहर न निकाला जाए! आप सुरक्षित रूप से सो सकते हैं या खा सकते हैं।",
        DE = "Super Schutz, damit du nicht gekickt wirst! Du kannst das Spiel sicher verlassen, um zu schlafen oder zu essen."
    },
    
    ["Ping"] = {ID = "Ping", EN = "Ping", PT = "Ping", ZH = "延迟", ES = "Ping", AR = "البينغ", FR = "Ping", RU = "Пинг", HI = "पिंग", DE = "Ping"},
    ["FPS"] = {ID = "FPS", EN = "FPS", PT = "FPS", ZH = "帧率", ES = "FPS", AR = "الإطارات", FR = "IPS", RU = "ФПС", HI = "एफपीएस", DE = "FPS"},
    ["Clock"] = {ID = "Jam", EN = "Clock", PT = "Relógio", ZH = "时间", ES = "Reloj", AR = "الوقت", FR = "Horloge", RU = "Время", HI = "समय", DE = "Uhr"},
    
    ["Notif_T"] = {ID = "Berhasil Dieksekusi!", EN = "Successfully Executed!", PT = "Executado com Sucesso!", ZH = "执行成功！", ES = "¡Ejecutado con éxito!", AR = "تم التنفيذ بنجاح!", FR = "Exécuté avec succès!", RU = "Успешно запущено!", HI = "सफलतापूर्वक!", DE = "Erfolgreich ausgeführt!"},
    ["Notif_D"] = {
        ID = "Selamat datang di Vickyyvall Hub! Semuanya sudah siap, ayo mulai petualangan seru dan jadilah yang terhebat!",
        EN = "Welcome to Vickyyvall Hub! Everything is ready, let's start an exciting adventure and be the greatest!",
        PT = "Bem-vindo ao Vickyyvall Hub! Tudo pronto, vamos começar uma aventura e ser o melhor!",
        ZH = "欢迎来到 Vickyyvall Hub！一切准备就绪，让我们开始激动人心的冒险，成为最棒的吧！",
        ES = "¡Bienvenido a Vickyyvall Hub! Todo está listo, ¡comienza una aventura emocionante y sé el mejor!",
        AR = "مرحبا بك في Vickyyvall Hub! كل شيء جاهز، لنبدأ مغامرة مثيرة ونكون الأعظم!",
        FR = "Bienvenue sur Vickyyvall Hub ! Tout est prêt, commencez une aventure passionnante et soyez le meilleur !",
        RU = "Добро пожаловать в Vickyyvall Hub! Все готово, давай начнем приключение и станем лучшими!",
        HI = "Vickyyvall हब में आपका स्वागत है! सब कुछ तैयार है, आइए एक रोमांचक साहसिक कार्य शुरू करें!",
        DE = "Willkommen im Vickyyvall Hub! Alles ist bereit, lass uns ein aufregendes Abenteuer beginnen!"
    },
    
    ["Pop_Title"] = {ID = "Keluar dari Hub?", EN = "Exit Hub?", PT = "Sair do Hub?", ZH = "退出中心吗？", ES = "¿Salir del Hub?", AR = "خروج؟", FR = "Quitter le Hub?", RU = "Выйти из Hub?", HI = "हब छोड़ें?", DE = "Hub verlassen?"},
    ["Pop_Desc"] = {
        ID = "Apakah Anda yakin ingin mematikan script Vickyyvall Hub?", 
        EN = "Are you sure you want to close the script?", 
        PT = "Tem certeza de que deseja fechar o script?", 
        ZH = "\u{60a8}\u{786e}\u{5b9a}\u{8981}\u{5173}\u{95ed}\u{811a}\u{672c}\u{5417}\u{ff1f}", 
        ES = "¿Estás seguro de que quieres cerrar el script?", 
        AR = "\u{0647}\u{0644} \u{0625}\u{0646}\u{062a} \u{0645}\u{062a}\u{0623}\u{0643}\u{062f}\u{061f}", 
        FR = "Êtes-vous sûr?", 
        RU = "\u{0412}\u{044b} \u{0443}\u{0432}\u{0435}\u{0440}\u{0435}\u{043d}\u{044b}?", 
        HI = "\u{0915}\u{094d}\u{092f}\u{093e} \u{0906}\u{092a} \u{0938}\u{094d}\u{0915}\u{094d}\u{0930}\u{093f}\u{092a}\u{094d}\u{091f} \u{092c}\u{0902}\u{0926} \u{0915}\u{0930}\u{0928}\u{093e} \u{091a}\u{093e}\u{0939}\u{0924}\u{0947} \u{0939}\u{0948}\u{0902}?", 
        DE = "Sind Sie sicher?"
    },
    
    ["Pop_Yes"] = {ID = "Ya", EN = "Yes", PT = "Sim", ZH = "是", ES = "Sí", AR = "نعم", FR = "Oui", RU = "Да", HI = "हाँ", DE = "Ja"},
    ["Pop_No"] = {ID = "Batal", EN = "Cancel", PT = "Cancelar", ZH = "取消", ES = "Cancelar", AR = "إلغاء", FR = "Annuler", RU = "Отмена", HI = "रद्द करें", DE = "Abbrechen"},

    ["Lang_T"] = {ID = "Pengaturan Bahasa", EN = "Language Settings", PT = "Idioma", ZH = "语言设置", ES = "Idioma", AR = "اللغة", FR = "Langue", RU = "Язык", HI = "भाषा सेटिंग्स", DE = "Sprache"},
    ["Lang_D"] = {
        ID = "Ganti bahasa menumu dengan sangat mudah! Tampilannya keren dan sangat gampang dipahami oleh siapapun.",
        EN = "Change your menu language very easily! It looks cool and is very easy for anyone to understand.",
        PT = "Mude o idioma do seu menu facilmente! Parece legal e é muito fácil de entender para qualquer um.",
        ZH = "非常轻松地更改菜单语言！它看起来很酷，任何人都能很容易理解。",
        ES = "¡Cambia el idioma del menú muy fácilmente! Se ve genial y es muy fácil de entender para cualquiera.",
        AR = "قم بتغيير لغة القائمة الخاصة بك بسهولة شديدة! يبدو رائعا وسهل الفهم لأي شخص.",
        FR = "Changez la langue de votre menu très facilement ! C'est cool et très facile à comprendre pour tout le monde.",
        RU = "Меняй язык меню очень легко! Выглядит круто и понятно абсолютно всем.",
        HI = "अपनी मेनू भाषा बहुत आसानी से बदलें! यह अच्छा लग रहा है और किसी के लिए भी समझना बहुत आसान है।",
        DE = "Ändere deine Menüsprache ganz einfach! Es sieht cool aus und ist für jeden leicht zu verstehen."
    },
    
    ["NotifRed_T"] = {ID = "Eits, Dilarang Akses!", EN = "Oops, Access Denied!", PT = "Ops, Acesso Negado!", ZH = "哎呀，拒绝访问！", ES = "¡Uy, Acceso Denegado!", AR = "عفوا، غير مسموح!", FR = "Oups, Accès Refusé!", RU = "Ой, Доступ Запрещен!", HI = "उफ़, पहुंच अस्वीकृत!", DE = "Hoppla, Zugriff verweigert!"},
    ["NotifRed_D"] = {
        ID = "Aktifin Box ESP-nya dulu bos! Jangan asal pencet!", 
        EN = "Activate Box ESP first, boss! Don't just click randomly!", 
        PT = "Ative o Box ESP primeiro, chefe! Não clique à toa!", 
        ZH = "老板，请先激活 Box ESP！别乱按！", 
        ES = "¡Activa Box ESP primero, jefe! ¡No hagas clic al azar!", 
        AR = "قم بتنشيط Box ESP أولاً يا زعيم! لا تنقر عشوائياً!", 
        FR = "Activez d'abord Box ESP, chef ! Ne cliquez pas au hasard !", 
        RU = "Сначала активируй Box ESP, босс! Не жми наугад!", 
        HI = "बॉस, पहले बॉक्स ESP सक्रिय करें! बेतरतीब ढंग से क्लिक न करें!", 
        DE = "Aktiviere zuerst Box ESP, Boss! Klick nicht einfach wild herum!"    
    }
}

local LangList = {
    "Indonesia (Default)", "English", "Português", "\u{4e2d}\u{6587} (Zh\u{014d}ngwén)", "Español", "\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)", "Français", "\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)", "\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})", "Deutsch"
}

local LangMap = {
    ["Indonesia (Default)"] = "ID",
    ["English"] = "EN",
    ["Português"] = "PT",
    ["\u{4e2d}\u{6587} (Zh\u{014d}ngwén)"] = "ZH",
    ["Español"] = "ES",
    ["\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)"] = "AR",
    ["Français"] = "FR",
    ["\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)"] = "RU",
    ["\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})"] = "HI",
    ["Deutsch"] = "DE"
}

local LangFlags = {
    ["Indonesia (Default)"] = "137384997162705",
    ["English"] = "120282236775675",
    ["Português"] = "86904547771543",
    ["\u{4e2d}\u{6587} (Zh\u{014d}ngwén)"] = "137557692066436",
    ["Español"] = "74820341814573",
    ["\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)"] = "136150632302206",
    ["Français"] = "72328939051445",
    ["\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)"] = "80116341008808",
    ["\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})"] = "106599817489962",
    ["Deutsch"] = "92865794651131"
}

local function GetText(key)
    if not LangDict[key] then return key end
    local code = LangMap[ActiveLanguage] or "ID"
    if LangDict[key][code] then return LangDict[key][code] end
    return LangDict[key].ID
end

local function RegisterTranslation(uiElement, propName, langKey)
    table.insert(TranslationElements, {Element = uiElement, Property = propName, Key = langKey})
    uiElement[propName] = GetText(langKey)
end

local function Tween(obj, props, time)
    local tw = TweenService:Create(obj, TweenInfo.new(time or 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tw:Play()
    return tw
end

local function SendNotification()
    local NotifFrame = Instance.new("Frame", ScreenGui)
    NotifFrame.Size = UDim2.new(0, 280, 0, 70)
    NotifFrame.AnchorPoint = Vector2.new(1, 1)
    NotifFrame.Position = UDim2.new(1, 300, 1, -20)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    NotifFrame.BackgroundTransparency = 0.2
    NotifFrame.ZIndex = 9999 -- Dipaksa berada di paling atas layar!
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 8)
    
    local NotifStroke = Instance.new("UIStroke", NotifFrame)
    NotifStroke.Color = Color3.fromRGB(200, 200, 200)
    NotifStroke.Transparency = 0.6
    NotifStroke.Thickness = 1
    NotifStroke.ZIndex = 10000
    
    local NotifLogo = Instance.new("ImageLabel", NotifFrame)
    NotifLogo.Size = UDim2.new(0, 30, 0, 30)
    NotifLogo.Position = UDim2.new(0, 15, 0.5, -15)
    NotifLogo.BackgroundTransparency = 1
    NotifLogo.Image = "rbxthumb://type=Asset&id=89815930925570&w=150&h=150"
    NotifLogo.ImageColor3 = ColorAccent
    NotifLogo.ZIndex = 10000
    
    local NTitle = Instance.new("TextLabel", NotifFrame)
    NTitle.Size = UDim2.new(1, -60, 0, 20)
    NTitle.Position = UDim2.new(0, 55, 0, 10)
    NTitle.BackgroundTransparency = 1
    NTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    NTitle.Font = FontTitle
    NTitle.TextSize = 14
    NTitle.TextXAlignment = Enum.TextXAlignment.Left
    NTitle.ZIndex = 10000
    RegisterTranslation(NTitle, "Text", "Notif_T")
    
    local NDesc = Instance.new("TextLabel", NotifFrame)
    NDesc.Size = UDim2.new(1, -60, 0, 30)
    NDesc.Position = UDim2.new(0, 55, 0, 30)
    NDesc.BackgroundTransparency = 1
    NDesc.TextColor3 = Color3.fromRGB(200, 200, 210)
    NDesc.Font = FontDesc
    NDesc.TextSize = 11
    NDesc.TextXAlignment = Enum.TextXAlignment.Left
    NDesc.TextYAlignment = Enum.TextYAlignment.Top
    NDesc.TextWrapped = true
    NDesc.ZIndex = 10000
    RegisterTranslation(NDesc, "Text", "Notif_D")
    
    Tween(NotifFrame, {Position = UDim2.new(1, -20, 1, -20)}, 0.5)
    
    task.delay(5, function()
        local hideTw = Tween(NotifFrame, {Position = UDim2.new(1, 300, 1, -20), BackgroundTransparency = 1}, 0.5)
        Tween(NotifLogo, {ImageTransparency = 1}, 0.5)
        Tween(NTitle, {TextTransparency = 1}, 0.5)
        Tween(NDesc, {TextTransparency = 1}, 0.5)
        Tween(NotifStroke, {Transparency = 1}, 0.5)
        hideTw.Completed:Connect(function() NotifFrame:Destroy() end)
    end)
end

task.spawn(SendNotification)

local Capsule = Instance.new("TextButton", ScreenGui)
Capsule.Size = UDim2.new(0, 130, 0, 34) -- TINGGI DITAMBAH JADI 34 BIAR LEGA & PREMIUM!
Capsule.AnchorPoint = Vector2.new(0.5, 0)
Capsule.Position = UDim2.new(0.5, 0, 0, 10)
Capsule.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Capsule.BackgroundTransparency = 0.15
Capsule.Text = "    vickyyvall hub"
Capsule.TextColor3 = Color3.fromRGB(240, 240, 240)
Capsule.Font = FontTitle
Capsule.TextSize = 12 -- Teks digedein dikit menyesuaikan kapsul
Capsule.Visible = true
Capsule.AutoButtonColor = false
Capsule.ZIndex = 10 -- Biar di depan bayangan
Instance.new("UICorner", Capsule).CornerRadius = UDim.new(1, 0)

local CapIcon = Instance.new("ImageLabel", Capsule)
CapIcon.Size = UDim2.new(0, 16, 0, 16) 
CapIcon.Position = UDim2.new(0, 12, 0.5, -8) 
CapIcon.BackgroundTransparency = 1
CapIcon.Image = "rbxthumb://type=Asset&id=1264643810&w=150&h=150"
CapIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
CapIcon.ZIndex = 11

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = ColorMain
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18) 

local MainShadow = Instance.new("ImageLabel", MainFrame)
MainShadow.Size = UDim2.new(1, 24, 1, 24)
MainShadow.Position = UDim2.new(0, -12, 0, -12)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxthumb://type=Asset&id=6014261993&w=150&h=150" 
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.45
MainShadow.ZIndex = -1
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(49, 49, 450, 450)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundTransparency = 1

local LogoContainer = Instance.new("Frame", TopBar)
LogoContainer.Size = UDim2.new(0, 26, 0, 26) -- 🔥 DIGEDEIN BIAR MAKIN SANGAR & SEMPURNA!
LogoContainer.Position = UDim2.new(0, 16, 0.5, -13)
LogoContainer.BackgroundTransparency = 1

-- LAYER BAWAH (RGB LOGO UTAMA {V})
local LogoIcon = Instance.new("ImageLabel", LogoContainer)
LogoIcon.Size = UDim2.new(1, 0, 1, 0)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Image = "rbxthumb://type=Asset&id=128173125009119&w=150&h=150" -- 🔥 LOGO BUATAN LU!
LogoIcon.ZIndex = 1

-- LAYER ATAS (KILATAN EMAS CERAH TETEP ADA)
local LogoShine = Instance.new("ImageLabel", LogoContainer)
LogoShine.Size = UDim2.new(1, 0, 1, 0)
LogoShine.BackgroundTransparency = 1
LogoShine.Image = "rbxthumb://type=Asset&id=128173125009119&w=150&h=150" -- 🔥 PAKAI LOGO LU JUGA!
LogoShine.ImageColor3 = Color3.fromRGB(255, 245, 180) 
LogoShine.ZIndex = 2

local ShineGrad = Instance.new("UIGradient", LogoShine)
ShineGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.2, 1),
    NumberSequenceKeypoint.new(0.5, 0), -- Kilatan dibuat super tebal & menyala!
    NumberSequenceKeypoint.new(0.8, 1),
    NumberSequenceKeypoint.new(1, 1)
})
ShineGrad.Rotation = 45

RunService.RenderStepped:Connect(function()
    LogoIcon.ImageColor3 = Color3.fromHSV((tick() * 0.15) % 1, 0.9, 1)
    ShineGrad.Rotation = 45 -- Memastikan sudutnya serong kanan bawah!
    local t = (tick() % 2) / 2 
    ShineGrad.Offset = Vector2.new(-1.5 + (t * 3), 0)
end)

local Watermark = Instance.new("TextLabel", TopBar)
Watermark.Size = UDim2.new(0, 200, 1, 0)
Watermark.Position = UDim2.new(0, 44, 0, 0) -- 🔥 DIDEKETIN DIKIT KE LOGO BIAR ROMANTIS!
Watermark.BackgroundTransparency = 1
Watermark.Text = "VICKYYVALL HUB"
Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
Watermark.Font = FontTitle
Watermark.TextSize = 13
Watermark.TextXAlignment = Enum.TextXAlignment.Left

local WaterGrad = Instance.new("UIGradient", Watermark)
WaterGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 255, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 255))
})
RunService.RenderStepped:Connect(function()
    WaterGrad.Offset = Vector2.new((tick() * 0.4) % 1 - 0.5, 0)
end)

local BtnClose = Instance.new("TextButton", TopBar)
BtnClose.Size = UDim2.new(0, 35, 0, 35)
BtnClose.Position = UDim2.new(1, -40, 0.5, -17.5)
BtnClose.Text = ""
BtnClose.BackgroundTransparency = 1
BtnClose.ZIndex = 50

local CloseIcon = Instance.new("ImageLabel", BtnClose)
CloseIcon.Size = UDim2.new(0, 14, 0, 14)
CloseIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
CloseIcon.BackgroundTransparency = 1
CloseIcon.Image = "rbxthumb://type=Asset&id=83903592827313&w=150&h=150" 
CloseIcon.ImageColor3 = Color3.fromRGB(255, 85, 85)
CloseIcon.ZIndex = 50

-- ICON FULLSCREEN BARU (DI TENGAH MUTLAK!)
local BtnMax = Instance.new("TextButton", TopBar)
BtnMax.Size = UDim2.new(0, 35, 0, 35)
BtnMax.Position = UDim2.new(1, -75, 0.5, -17.5)
BtnMax.Text = ""
BtnMax.BackgroundTransparency = 1
BtnMax.ZIndex = 50

local MaxIcon = Instance.new("ImageLabel", BtnMax)
MaxIcon.Size = UDim2.new(0, 14, 0, 14)
MaxIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
MaxIcon.BackgroundTransparency = 1
MaxIcon.Image = "rbxthumb://type=Asset&id=107300063295291&w=150&h=150" 
MaxIcon.ImageColor3 = ColorDesc
MaxIcon.ZIndex = 50

-- ICON MINIMIZE DIGESER KIRI BIAR GAK NUMPUK
local BtnMin = Instance.new("TextButton", TopBar)
BtnMin.Size = UDim2.new(0, 35, 0, 35)
BtnMin.Position = UDim2.new(1, -110, 0.5, -17.5) 
BtnMin.Text = ""
BtnMin.BackgroundTransparency = 1
BtnMin.ZIndex = 50

local MinIcon = Instance.new("ImageLabel", BtnMin)
MinIcon.Size = UDim2.new(0, 14, 0, 14)
MinIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
MinIcon.BackgroundTransparency = 1
MinIcon.Image = "rbxthumb://type=Asset&id=102488266287369&w=150&h=150" 
MinIcon.ImageColor3 = ColorDesc
MinIcon.ZIndex = 50

local SidebarBG = Instance.new("Frame", MainFrame)
SidebarBG.Size = UDim2.new(0, 125, 1, -50)
SidebarBG.Position = UDim2.new(0, 10, 0, 40)
SidebarBG.BackgroundColor3 = ColorSidebar
SidebarBG.BackgroundTransparency = 0.3
Instance.new("UICorner", SidebarBG).CornerRadius = UDim.new(0, 8)
SidebarBG.ClipsDescendants = true

-- PROFILE SECTION PREMIUM
local ProfileFrame = Instance.new("Frame", SidebarBG)
ProfileFrame.Size = UDim2.new(1, 0, 0, 45)
ProfileFrame.Position = UDim2.new(0, 0, 0, 5)
ProfileFrame.BackgroundTransparency = 1

local ProfilePic = Instance.new("ImageLabel", ProfileFrame)
ProfilePic.Size = UDim2.new(0, 32, 0, 32)
ProfilePic.Position = UDim2.new(0, 8, 0, 6)
ProfilePic.BackgroundColor3 = ColorContent
Instance.new("UICorner", ProfilePic).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    pcall(function()
        local thumb, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if isReady then ProfilePic.Image = thumb end
    end)
end)

local ProfileStroke = Instance.new("UIStroke", ProfilePic)
ProfileStroke.Color = ColorAccent
ProfileStroke.Thickness = 1.5
ProfileStroke.Transparency = 0.2

-- ==========================================================
-- PROFIL DENGAN CENTANG BIRU (AUTO-NYESUAIIN PANJANG NAMA)
-- ==========================================================
local NameStack = Instance.new("Frame", ProfileFrame)
NameStack.Size = UDim2.new(1, -48, 0, 16)
NameStack.Position = UDim2.new(0, 46, 0, 8)
NameStack.BackgroundTransparency = 1

local NLayout = Instance.new("UIListLayout", NameStack)
NLayout.FillDirection = Enum.FillDirection.Horizontal
NLayout.SortOrder = Enum.SortOrder.LayoutOrder
NLayout.Padding = UDim.new(0, 4) -- Jarak manja antara nama & centang
NLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local ProfileDisp = Instance.new("TextLabel", NameStack)
ProfileDisp.Size = UDim2.new(0, 0, 1, 0)
ProfileDisp.AutomaticSize = Enum.AutomaticSize.X -- Lebar otomatis nyesuaiin nama!
ProfileDisp.BackgroundTransparency = 1
ProfileDisp.Text = LocalPlayer.DisplayName
ProfileDisp.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileDisp.Font = FontTitle
ProfileDisp.TextSize = 12
ProfileDisp.TextXAlignment = Enum.TextXAlignment.Left
ProfileDisp.LayoutOrder = 1

local BlueTick = Instance.new("ImageLabel", NameStack)
BlueTick.Size = UDim2.new(0, 10, 0, 10) 
BlueTick.BackgroundTransparency = 1
BlueTick.Image = "rbxthumb://type=Asset&id=87350124015899&w=150&h=150"
BlueTick.LayoutOrder = 2

local ProfileUser = Instance.new("TextLabel", ProfileFrame)
ProfileUser.Size = UDim2.new(1, -48, 0, 14)
ProfileUser.Position = UDim2.new(0, 46, 0, 24)
ProfileUser.BackgroundTransparency = 1
ProfileUser.Text = "@" .. LocalPlayer.Name
ProfileUser.TextColor3 = ColorDesc
ProfileUser.Font = FontDesc
ProfileUser.TextSize = 10
ProfileUser.TextXAlignment = Enum.TextXAlignment.Left
ProfileUser.TextTruncate = Enum.TextTruncate.AtEnd

local LineSep = Instance.new("Frame", SidebarBG)
LineSep.Size = UDim2.new(1, -16, 0, 1)
LineSep.Position = UDim2.new(0, 8, 0, 55)
LineSep.BackgroundColor3 = ColorDisabled
LineSep.BorderSizePixel = 0

local TabContainer = Instance.new("Frame", SidebarBG)
TabContainer.Size = UDim2.new(1, -12, 1, -64)
TabContainer.Position = UDim2.new(0, 6, 0, 60)
TabContainer.BackgroundTransparency = 1
local TLayout = Instance.new("UIListLayout", TabContainer)
TLayout.Padding = UDim.new(0, 6)

local PageContainer = Instance.new("Frame", MainFrame)
PageContainer.Size = UDim2.new(1, -140, 1, -50) 
PageContainer.Position = UDim2.new(0, 135, 0, 40) 
PageContainer.BackgroundColor3 = ColorContent
PageContainer.BackgroundTransparency = 0.4
Instance.new("UICorner", PageContainer).CornerRadius = UDim.new(0, 8)
PageContainer.ClipsDescendants = true

local function ApplyHover(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function() Tween(btn, {BackgroundColor3 = hoverColor}, 0.25) end)
    btn.MouseLeave:Connect(function() Tween(btn, {BackgroundColor3 = normalColor}, 0.25) end)
end

local function CreateTab(iconId, langKey)
    local btn = Instance.new("TextButton", TabContainer)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = ColorDisabled 
    btn.Text = ""
    btn.BackgroundTransparency = 1
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("ScrollingFrame", PageContainer)
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.Visible = false
    page.ScrollBarImageColor3 = ColorAccent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local PLayout = Instance.new("UIListLayout", page)
    PLayout.Padding = UDim.new(0, 8)
    PLayout.SortOrder = Enum.SortOrder.LayoutOrder

    btn.MouseEnter:Connect(function() 
        if not page.Visible then Tween(btn, {BackgroundTransparency = 0.8}, 0.25) end
    end)
    btn.MouseLeave:Connect(function() 
        if not page.Visible then Tween(btn, {BackgroundTransparency = 1}, 0.25) end
    end)

    local img = Instance.new("ImageLabel", btn)
    img.Size = UDim2.new(0, 16, 0, 16)
    img.Position = UDim2.new(0, 10, 0.5, -8)
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = ColorDesc

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1, -34, 1, 0)
    lbl.Position = UDim2.new(0, 34, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = ColorDesc
    lbl.Font = FontMain
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(lbl, "Text", langKey)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(PageContainer:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
        for _, b in pairs(TabContainer:GetChildren()) do 
            if b:IsA("TextButton") then 
                Tween(b, {BackgroundTransparency = 1}, 0.25)
                Tween(b:FindFirstChildOfClass("ImageLabel"), {ImageColor3 = ColorDesc}, 0.25)
                Tween(b:FindFirstChildOfClass("TextLabel"), {TextColor3 = ColorDesc}, 0.25)
            end 
        end
        page.Visible = true
        Tween(btn, {BackgroundTransparency = 0.15}, 0.25)
        Tween(img, {ImageColor3 = ColorAccent}, 0.25)
        Tween(lbl, {TextColor3 = ColorText}, 0.25)
    end)
    return page, btn
end

local function CreateButton(parent, iconId, iconColor, keyT, keyD, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -4, 0, 75)
    btn.BackgroundColor3 = ColorMain
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BackgroundTransparency = 0.5
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    ApplyHover(btn, ColorMain, ColorToggleOff)
    
    local img = Instance.new("ImageLabel", btn)
    img.Size = UDim2.new(0, 24, 0, 24) 
    img.AnchorPoint = Vector2.new(0, 0.5)
    img.Position = UDim2.new(0, 12, 0.5, 0) -- ICON MUTLAK DI TENGAH KIRI!
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = iconColor
    
    local tLbl = Instance.new("TextLabel", btn)
    tLbl.Size = UDim2.new(1, -70, 0, 16) 
    tLbl.Position = UDim2.new(0, 48, 0, 8) -- GESER KANAN (X=48) DAN LEGA DI ATAS (Y=8)!
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", keyT)
    
    local dLbl = Instance.new("TextLabel", btn)
    dLbl.Size = UDim2.new(1, -70, 0, 42) -- PAS BANGET, NGGAK NYENTUH TANAH WOY!
    dLbl.Position = UDim2.new(0, 48, 0, 26) -- PERSIS DITENGAH TEKSNYA!
    dLbl.BackgroundTransparency = 1
    dLbl.TextColor3 = ColorDesc
    dLbl.Font = FontDesc
    dLbl.TextSize = 10
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.TextYAlignment = Enum.TextYAlignment.Top
    dLbl.TextWrapped = true
    RegisterTranslation(dLbl, "Text", keyD)
    
    local ptrImg = Instance.new("ImageLabel", btn)
    ptrImg.Size = UDim2.new(0, 16, 0, 16)
    ptrImg.AnchorPoint = Vector2.new(0, 0.5)
    ptrImg.Position = UDim2.new(1, -26, 0.5, 0)
    ptrImg.BackgroundTransparency = 1
    ptrImg.Image = "rbxthumb://type=Asset&id=7158102707&w=150&h=150" 
    ptrImg.ImageColor3 = iconColor
    
    btn.MouseButton1Click:Connect(function()
        local t = Tween(btn, {Size = UDim2.new(1, -8, 0, 71), Position = UDim2.new(0, 2, 0, 2)}, 0.1)
        t.Completed:Connect(function()
            Tween(btn, {Size = UDim2.new(1, -4, 0, 75), Position = UDim2.new(0, 0, 0, 0)}, 0.1)
            callback()
        end)
    end)
end

local function CreateToggle(parent, iconId, baseIconColor, glowColor, keyT, keyD, callback)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -4, 0, 75)
    f.BackgroundColor3 = ColorMain
    f.BackgroundTransparency = 0.5
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local img = Instance.new("ImageLabel", f)
    img.Size = UDim2.new(0, 24, 0, 24) 
    img.AnchorPoint = Vector2.new(0, 0.5)
    img.Position = UDim2.new(0, 12, 0.5, 0) -- TENGAH MUTLAK!
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = baseIconColor
    
    local tLbl = Instance.new("TextLabel", f)
    tLbl.Size = UDim2.new(1, -92, 0, 16) 
    tLbl.Position = UDim2.new(0, 48, 0, 8) -- RAPIH, LEGA, GESER KANAN!
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", keyT)
    
    local dLbl = Instance.new("TextLabel", f)
    dLbl.Size = UDim2.new(1, -92, 0, 42) -- AMAN DARI LANTAI!
    dLbl.Position = UDim2.new(0, 48, 0, 26) -- CENTER!
    dLbl.BackgroundTransparency = 1
    dLbl.TextColor3 = ColorDesc
    dLbl.Font = FontDesc
    dLbl.TextSize = 10
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.TextYAlignment = Enum.TextYAlignment.Top
    dLbl.TextWrapped = true
    RegisterTranslation(dLbl, "Text", keyD)
    
    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(0, 38, 0, 18)
    btn.AnchorPoint = Vector2.new(0, 0.5)
    btn.Position = UDim2.new(1, -48, 0.5, 0)
    btn.BackgroundColor3 = ColorToggleOff
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, 14, 0, 14)
    ind.AnchorPoint = Vector2.new(0, 0.5)
    ind.Position = UDim2.new(0, 2, 0.5, 0)
    ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        local targetColor = state and (glowColor or baseIconColor) or baseIconColor
        local bgBtnColor = state and targetColor or ColorToggleOff
        Tween(btn, {BackgroundColor3 = bgBtnColor}, 0.25)
        Tween(ind, {Position = state and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.25)
        Tween(img, {ImageColor3 = targetColor}, 0.25)
        callback(state)
    end)
end

local function CreateToggleSlider(parent, iconId, iconColor, keyT, keyD, min, max, default, unit, callback)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -4, 0, 95)
    f.BackgroundColor3 = ColorMain
    f.BackgroundTransparency = 0.5
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local img = Instance.new("ImageLabel", f)
    img.Size = UDim2.new(0, 24, 0, 24) 
    img.AnchorPoint = Vector2.new(0, 0.5)
    img.Position = UDim2.new(0, 12, 0, 37.5) -- TENGAH MUTLAK TERHADAP TEXT (Y=75/2)
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = iconColor
    
    local tLbl = Instance.new("TextLabel", f)
    tLbl.Size = UDim2.new(1, -86, 0, 16) 
    tLbl.Position = UDim2.new(0, 48, 0, 8) -- RAPIH, LEGA!
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", keyT)
    
    local dLbl = Instance.new("TextLabel", f)
    dLbl.Size = UDim2.new(1, -86, 0, 42) -- AMAN DARI LANTAI!
    dLbl.Position = UDim2.new(0, 48, 0, 26) -- CENTER!
    dLbl.BackgroundTransparency = 1
    dLbl.TextColor3 = ColorDesc
    dLbl.Font = FontDesc
    dLbl.TextSize = 10
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.TextYAlignment = Enum.TextYAlignment.Top
    dLbl.TextWrapped = true
    RegisterTranslation(dLbl, "Text", keyD)
    
    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(0, 34, 0, 16)
    btn.Position = UDim2.new(1, -42, 0, 12)
    btn.BackgroundColor3 = ColorToggleOff
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, 12, 0, 12)
    ind.AnchorPoint = Vector2.new(0, 0.5)
    ind.Position = UDim2.new(0, 2, 0.5, 0)
    ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    
    local sBg = Instance.new("TextButton", f)
    sBg.Size = UDim2.new(1, -78, 0, 5)
    sBg.Position = UDim2.new(0, 42, 0, 78) 
    sBg.BackgroundColor3 = ColorDisabled
    sBg.Text = ""
    sBg.AutoButtonColor = false
    Instance.new("UICorner", sBg).CornerRadius = UDim.new(1, 0)
    
    local sFill = Instance.new("Frame", sBg)
    sFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sFill.BackgroundColor3 = ColorDesc
    Instance.new("UICorner", sFill).CornerRadius = UDim.new(1, 0)
    
    local sKnob = Instance.new("Frame", sFill)
    sKnob.Size = UDim2.new(0, 10, 0, 10)
    sKnob.AnchorPoint = Vector2.new(0, 0.5)
    sKnob.Position = UDim2.new(1, -5, 0.5, 0)
    sKnob.BackgroundColor3 = ColorDesc
    Instance.new("UICorner", sKnob).CornerRadius = UDim.new(1, 0)
    
    local valLbl = Instance.new("TextLabel", f)
    valLbl.Size = UDim2.new(0, 40, 0, 16)
    valLbl.Position = UDim2.new(1, -43, 0, 72)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)..unit
    valLbl.TextColor3 = ColorDesc
    valLbl.Font = FontTitle
    valLbl.TextSize = 10
    valLbl.TextXAlignment = Enum.TextXAlignment.Center
    
    local state = false
    local currentValue = default
    local dragging = false
    
    local function updateSlider(input)
        if not state then return end
        local mp = input.Position.X
        local rel = math.clamp((mp - sBg.AbsolutePosition.X) / sBg.AbsoluteSize.X, 0, 1)
        Tween(sFill, {Size = UDim2.new(rel, 0, 1, 0)}, 0.1)
        currentValue = math.floor(min + (max - min) * rel)
        valLbl.Text = tostring(currentValue)..unit
        callback(state, currentValue)
    end
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        Tween(btn, {BackgroundColor3 = state and iconColor or ColorToggleOff}, 0.25)
        Tween(ind, {Position = state and UDim2.new(1, -14, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.25)
        Tween(sBg, {BackgroundColor3 = state and ColorToggleOff or ColorDisabled}, 0.25)
        Tween(sFill, {BackgroundColor3 = state and iconColor or ColorDesc}, 0.25)
        Tween(sKnob, {BackgroundColor3 = state and ColorText or ColorDesc}, 0.25)
        Tween(valLbl, {TextColor3 = state and iconColor or ColorDesc}, 0.25)
        callback(state, currentValue)
    end)
    
    sBg.InputBegan:Connect(function(input)
        if state and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            updateSlider(input)
        end
    end)
    sBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and state and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
end

local function CreateInfo(parent, iconId, iconColor, langKey, initial)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -4, 0, 40)
    f.BackgroundColor3 = ColorMain
    f.BackgroundTransparency = 0.5
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local img = Instance.new("ImageLabel", f)
    img.Size = UDim2.new(0, 22, 0, 22) 
    img.Position = UDim2.new(0, 12, 0.5, -11) 
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = iconColor
    
    local tLbl = Instance.new("TextLabel", f)
    tLbl.Size = UDim2.new(0.6, 0, 1, 0)
    tLbl.Position = UDim2.new(0, 38, 0, 0)
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", langKey)
    
    local vLbl = Instance.new("TextLabel", f)
    vLbl.Size = UDim2.new(0.4, 0, 1, 0)
    vLbl.Position = UDim2.new(1, -55, 0, 0)
    vLbl.BackgroundTransparency = 1
    vLbl.Text = initial
    vLbl.TextColor3 = iconColor
    vLbl.Font = FontTitle
    vLbl.TextSize = 12
    vLbl.TextXAlignment = Enum.TextXAlignment.Right
    return vLbl
end

local P1, B1 = CreateTab("rbxthumb://type=Asset&id=7539983780&w=150&h=150", "Char_Title")
local P2, B2 = CreateTab("rbxthumb://type=Asset&id=79815458262632&w=150&h=150", "Vis_Title")
local P3, B3 = CreateTab("rbxthumb://type=Asset&id=11887653913&w=150&h=150", "World_Title")
local P4, B4 = CreateTab("rbxthumb://type=Asset&id=14563958719&w=150&h=150", "Sys_Title") 

B1.BackgroundTransparency = 0.15
B1:FindFirstChildOfClass("ImageLabel").ImageColor3 = ColorAccent
B1:FindFirstChildOfClass("TextLabel").TextColor3 = ColorText

-- ==========================================================
-- 🔥 FITUR RADAR TRACKER TEMAN REAL-TIME (PERFECT 1:1 EDITION)
-- ==========================================================
local TrackerFrame = Instance.new("Frame", P3)
TrackerFrame.Size = UDim2.new(1, -4, 0, 140) -- 🔥 TINGGI DITAMBAH BIAR RADAR TEMAN BISA DI BAWAH MAP!
TrackerFrame.BackgroundColor3 = ColorMain
TrackerFrame.BackgroundTransparency = 0.5
TrackerFrame.LayoutOrder = -1
Instance.new("UICorner", TrackerFrame).CornerRadius = UDim.new(0, 16)

-- 🔥 FRAME KOTAK 1:1 DENGAN TUMPUL PREMIUM (BUKAN KAPSUL!)
local MapImageBg = Instance.new("Frame", TrackerFrame)
MapImageBg.Size = UDim2.new(0, 80, 0, 80)
MapImageBg.Position = UDim2.new(0, 12, 0, 12) 
MapImageBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Instance.new("UICorner", MapImageBg).CornerRadius = UDim.new(0, 18) -- 🔥 TUMPUL BANGET TAPI TETEP KOTAK TEGAS!
MapImageBg.ClipsDescendants = true

local MapImage = Instance.new("ImageLabel", MapImageBg)
MapImage.Size = UDim2.new(1, 0, 1, 0)
MapImage.AnchorPoint = Vector2.new(0.5, 0.5)
MapImage.Position = UDim2.new(0.5, 0, 0.5, 0)
MapImage.BackgroundTransparency = 1
MapImage.ScaleType = Enum.ScaleType.Crop 
MapImage.Image = "rbxthumb://type=Asset&id=14563958719&w=150&h=150" 

-- ==========================================
-- 📌 BARISAN TEKS KANAN & ICON KECIL MANDIRI
-- ==========================================

-- 1. JUDUL MAP
local IconJudul = Instance.new("ImageLabel", TrackerFrame)
IconJudul.Size = UDim2.new(0, 14, 0, 14)
IconJudul.Position = UDim2.new(0, 105, 0, 17)
IconJudul.BackgroundTransparency = 1
IconJudul.Image = "rbxthumb://type=Asset&id=2129457776&w=150&h=150" -- 🔥 KOSONG MANDIRI
IconJudul.ImageColor3 = ColorAccent

local MapTitle = Instance.new("TextLabel", TrackerFrame)
MapTitle.Size = UDim2.new(1, -130, 0, 14)
MapTitle.Position = UDim2.new(0, 125, 0, 17) -- 🔥 AGAK KE ATAS SESUAI PERMINTAAN
MapTitle.BackgroundTransparency = 1
MapTitle.Text = GetText("Map_NotFound") 
MapTitle.TextColor3 = ColorText
MapTitle.Font = Enum.Font.GothamBold
MapTitle.TextSize = 13
MapTitle.TextXAlignment = Enum.TextXAlignment.Left
MapTitle.TextTruncate = Enum.TextTruncate.AtEnd

-- 2. TANGGAL ASLI DIBUAT
local IconTanggal = Instance.new("ImageLabel", TrackerFrame)
IconTanggal.Size = UDim2.new(0, 14, 0, 14)
IconTanggal.Position = UDim2.new(0, 105, 0, 42)
IconTanggal.BackgroundTransparency = 1
IconTanggal.Image = "rbxthumb://type=Asset&id=106533346160517&w=150&h=150" -- 🔥 KOSONG MANDIRI
IconTanggal.ImageColor3 = ColorAccent

local MapDate = Instance.new("TextLabel", TrackerFrame)
MapDate.Size = UDim2.new(1, -130, 0, 14)
MapDate.Position = UDim2.new(0, 125, 0, 42)
MapDate.BackgroundTransparency = 1
MapDate.Text = "Menghitung Tanggal..."
MapDate.TextColor3 = ColorDesc
MapDate.Font = Enum.Font.GothamMedium
MapDate.TextSize = 11
MapDate.TextXAlignment = Enum.TextXAlignment.Left

-- 3. WAKTU BERMAIN REAL-TIME
local IconWaktu = Instance.new("ImageLabel", TrackerFrame)
IconWaktu.Size = UDim2.new(0, 14, 0, 14)
IconWaktu.Position = UDim2.new(0, 105, 0, 67)
IconWaktu.BackgroundTransparency = 1
IconWaktu.Image = "rbxthumb://type=Asset&id=17551409714&w=150&h=150" -- 🔥 KOSONG MANDIRI
IconWaktu.ImageColor3 = ColorAccent

local MapTime = Instance.new("TextLabel", TrackerFrame)
MapTime.Size = UDim2.new(1, -130, 0, 14)
MapTime.Position = UDim2.new(0, 125, 0, 67)
MapTime.BackgroundTransparency = 1
MapTime.Text = "00:00:00"
MapTime.TextColor3 = ColorDesc
MapTime.Font = Enum.Font.GothamMedium
MapTime.TextSize = 11
MapTime.TextXAlignment = Enum.TextXAlignment.Left

-- ==========================================
-- ⚙️ LOGIKA PENGAMBILAN DATA NYATA & REAL-TIME
-- ==========================================

-- AMBIL DATA API ROBLOX (TANGGAL ASLI & JUDUL)
task.spawn(function()
    pcall(function()
        if game.PlaceId > 0 then
            local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
            if info then
                if info.Name then MapTitle.Text = info.Name end
                if info.IconImageAssetId and info.IconImageAssetId > 0 then
                    MapImage.Image = "rbxthumb://type=Asset&id=" .. info.IconImageAssetId .. "&w=150&h=150"
                end
                if info.Created then
                    -- Format Tanggal Asli dari API Roblox (Contoh API: 2022-02-01T...)
                    local tahun, bulan, tanggal = string.match(info.Created, "(%d+)%-(%d+)%-(%d+)")
                    if tahun and bulan and tanggal then
                        MapDate.Text = "Tanggal dibuat: " .. tanggal .. "/" .. bulan .. "/" .. tahun
                    end
                end
            end
        end
    end)
end)

-- LOGIKA WAKTU BERGERAK REAL-TIME DETIK PER DETIK (WAKTU SERVER MUTLAK)
RunService.RenderStepped:Connect(function()
    local waktuNyata = Workspace.DistributedGameTime -- Ambil waktu asli server berjalan!
    local d = math.floor(waktuNyata / 86400)
    local h = math.floor((waktuNyata % 86400) / 3600)
    local m = math.floor((waktuNyata % 3600) / 60)
    local s = math.floor(waktuNyata % 60)
    
    if d > 0 then
        MapTime.Text = string.format("%d Hari, %02d:%02d:%02d", d, h, m, s)
    else
        MapTime.Text = string.format("%02d:%02d:%02d", h, m, s)
    end
end)

-- ==========================================
-- 🫂 RADAR TEMAN (PINDAH KE BAWAH MAP SECARA MUTLAK!)
-- ==========================================
local FriendList = Instance.new("Frame", TrackerFrame)
FriendList.Size = UDim2.new(1, -24, 0, 26)
FriendList.Position = UDim2.new(0, 12, 0, 105) -- 🔥 PINDAH KE BAWAH GAMBAR MAP! 
FriendList.BackgroundTransparency = 1

local function CreateProfileImage(userId, zIndex)
    local pp = Instance.new("ImageLabel")
    pp.Image = "rbxthumb://type=AvatarHeadShot&id="..userId.."&w=150&h=150"
    pp.BackgroundTransparency = 0 
    pp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pp.ZIndex = zIndex
    Instance.new("UICorner", pp).CornerRadius = UDim.new(1, 0)
    
    local shadow = Instance.new("UIStroke", pp)
    shadow.Color = Color3.fromRGB(0, 0, 0)
    shadow.Thickness = 1.5
    shadow.Transparency = 1 
    
    local stroke = Instance.new("UIStroke", pp)
    stroke.Color = ColorAccent
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Transparency = 1 
    
    return pp
end

local NumberIds = {
    [4] = "91964027791046", [5] = "91385777605727", [6] = "108575358395562",
    [7] = "138818974298148", [8] = "104929525393206", [9] = "92219426288765",
    [10] = "106017318324095", [11] = "137153038527983", [12] = "131651161681561",
    [13] = "118145697899247", [14] = "121592498977986", [15] = "138026132849906",
    [16] = "78288725755875", [17] = "80563052533404", [18] = "101563094640949",
    [19] = "124357720177536", [20] = "103822849402569"
}

local function UpdateRadarTeman()
    local daftarTeman = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and LocalPlayer:IsFriendsWith(p.UserId) then
            table.insert(daftarTeman, p)
        end
    end

    local jumlah = #daftarTeman
    local maxShow = math.min(jumlah, 3)
    local offsetIndex = (jumlah > 3) and 1 or 0

    for _, v in pairs(FriendList:GetChildren()) do
        if v.Name ~= "NoFriends" and v.Name ~= "NamesLabel" and v.Name ~= "NumIcon" then
            local masihAda = false
            for _, p in pairs(daftarTeman) do
                if v.Name == tostring(p.UserId) then masihAda = true; break end
            end
            
            if not masihAda then
                if v:IsA("ImageLabel") then
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.new(0, v.Position.X.Offset - 20, 0.5, 0),
                        ImageTransparency = 1, BackgroundTransparency = 1
                    }):Play()
                    for _, c in pairs(v:GetChildren()) do
                        if c:IsA("UIStroke") then TweenService:Create(c, TweenInfo.new(0.2), {Transparency = 1}):Play() end
                    end
                end
                task.delay(0.2, function() if v and v.Parent then v:Destroy() end end)
            end
        end
    end

    local jombloTxt = FriendList:FindFirstChild("NoFriends")
    if jumlah == 0 then
        if not jombloTxt then
            jombloTxt = Instance.new("TextLabel", FriendList)
            jombloTxt.Name = "NoFriends"
            jombloTxt.Size = UDim2.new(1, 0, 1, 0)
            jombloTxt.BackgroundTransparency = 1
            jombloTxt.Text = "Belum ada teman di server ini."
            jombloTxt.TextColor3 = ColorDesc
            jombloTxt.Font = Enum.Font.GothamBold
            jombloTxt.TextSize = 11
            jombloTxt.TextXAlignment = Enum.TextXAlignment.Left
            jombloTxt.TextTransparency = 0 
        end
        if FriendList:FindFirstChild("NamesLabel") then FriendList.NamesLabel:Destroy() end
        if FriendList:FindFirstChild("NumIcon") then FriendList.NumIcon:Destroy() end
        return
    else
        if jombloTxt then jombloTxt:Destroy() end
    end

    if jumlah > 3 then
        local safeJumlah = math.min(jumlah, 20)
        local numIcon = FriendList:FindFirstChild("NumIcon")
        if not numIcon then
            numIcon = Instance.new("ImageLabel", FriendList)
            numIcon.Name = "NumIcon"
            numIcon.Size = UDim2.new(0, 24, 0, 24)
            numIcon.Position = UDim2.new(0, -30, 0.5, 0)
            numIcon.AnchorPoint = Vector2.new(0, 0.5)            
            numIcon.BackgroundTransparency = 1 
            
            numIcon.Image = "rbxthumb://type=Asset&id=" .. NumberIds[safeJumlah] .. "&w=150&h=150"
            numIcon.ImageTransparency = 1
            numIcon.ZIndex = 20
            Instance.new("UICorner", numIcon).CornerRadius = UDim.new(1, 0)
            
            local stroke = Instance.new("UIStroke", numIcon)
            stroke.Color = ColorAccent
            stroke.Thickness = 1
            stroke.Transparency = 1
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            
            TweenService:Create(numIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 0, 0.5, 0), ImageTransparency = 0
            }):Play()
            TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
        else
            numIcon.Image = "rbxthumb://type=Asset&id=" .. NumberIds[safeJumlah] .. "&w=150&h=150"
        end
    else
        if FriendList:FindFirstChild("NumIcon") then FriendList.NumIcon:Destroy() end
    end

    local shownNames = {}
    for i = 1, maxShow do
        local p = daftarTeman[i]
        table.insert(shownNames, p.DisplayName)
        
        local targetX = (offsetIndex + i - 1) * 12
        local targetZ = 20 - offsetIndex - i
        
        local pp = FriendList:FindFirstChild(tostring(p.UserId))
        if not pp then
            pp = CreateProfileImage(p.UserId, targetZ)
            pp.Name = tostring(p.UserId)
            pp.Parent = FriendList
            pp.Size = UDim2.new(0, 24, 0, 24)
            pp.Position = UDim2.new(0, targetX - 30, 0.5, 0)
            pp.AnchorPoint = Vector2.new(0, 0.5)
            pp.ImageTransparency = 1
            
            TweenService:Create(pp, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, targetX, 0.5, 0), ImageTransparency = 0
            }):Play()
            
            for _, child in pairs(pp:GetChildren()) do
                if child:IsA("UIStroke") then
                    local tTrans = (child.Color == Color3.fromRGB(0,0,0)) and 0.5 or 0
                    TweenService:Create(child, TweenInfo.new(0.2), {Transparency = tTrans}):Play()
                end
            end
        else
            TweenService:Create(pp, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, targetX, 0.5, 0)}):Play()
            pp.ZIndex = targetZ
        end
    end

    local namesString = ""
    if jumlah == 1 then
        namesString = shownNames[1]
    elseif jumlah == 2 then
        namesString = shownNames[1] .. " dan " .. shownNames[2]
    elseif jumlah == 3 then
        namesString = shownNames[1] .. ", " .. shownNames[2] .. " dan " .. shownNames[3]
    elseif jumlah > 3 then
        namesString = shownNames[1] .. ", " .. shownNames[2] .. ", " .. shownNames[3] .. " dan " .. (jumlah - 3) .. " lainnya"
    end

    local totalElements = maxShow + offsetIndex
    local targetLblX = (totalElements * 12) + 16
    
    local nameLbl = FriendList:FindFirstChild("NamesLabel")
    if not nameLbl then
        nameLbl = Instance.new("TextLabel", FriendList)
        nameLbl.Name = "NamesLabel"
        nameLbl.Size = UDim2.new(1, -targetLblX, 1, 0)
        nameLbl.Position = UDim2.new(0, targetLblX, 0, 0)
        nameLbl.BackgroundTransparency = 1
        nameLbl.TextColor3 = ColorDesc
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextSize = 11
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
        nameLbl.TextTransparency = 1
        
        nameLbl.Text = namesString
        TweenService:Create(nameLbl, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    else
        nameLbl.Text = namesString
        TweenService:Create(nameLbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -targetLblX, 1, 0), Position = UDim2.new(0, targetLblX, 0, 0)
        }):Play()
    end
end

Players.PlayerAdded:Connect(function(plr) task.wait(1.5); UpdateRadarTeman() end)
Players.PlayerRemoving:Connect(function(plr) UpdateRadarTeman() end)
task.spawn(UpdateRadarTeman)

-- ==========================================================
-- 🔥 FITUR FLOATING SCROLL TO BOTTOM (PREMIUM AUTO-SCROLL MAGIC)
-- ==========================================================
local ScrollDownBtn = Instance.new("ImageButton", PageContainer)
ScrollDownBtn.Size = UDim2.new(0, 32, 0, 32)
ScrollDownBtn.AnchorPoint = Vector2.new(1, 1)
ScrollDownBtn.Position = UDim2.new(1, -25, 1, -25) -- 🔥 POJOK KANAN BAWAH NAIK DIKIT BIAR NGAMBANG SEMPURNA
ScrollDownBtn.BackgroundTransparency = 1
ScrollDownBtn.Image = "rbxthumb://type=Asset&id=134413307626859&w=150&h=150"
ScrollDownBtn.ZIndex = 9999 -- Pastiin selalu paling atas
ScrollDownBtn.Visible = false
ScrollDownBtn.ImageTransparency = 1

local CurrentActivePage = nil
local function CheckScrollStatus()
    if not CurrentActivePage then return end
    
    local maxScroll = math.max(0, CurrentActivePage.AbsoluteCanvasSize.Y - CurrentActivePage.AbsoluteWindowSize.Y)
    
    if CurrentActivePage.CanvasPosition.Y < maxScroll - 10 then
        if not ScrollDownBtn.Visible then
            ScrollDownBtn.Visible = true
            TweenService:Create(ScrollDownBtn, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
        end
    else
        if ScrollDownBtn.Visible and ScrollDownBtn.ImageTransparency == 0 then
            local hideTw = TweenService:Create(ScrollDownBtn, TweenInfo.new(0.3), {ImageTransparency = 1})
            hideTw.Completed:Connect(function() 
                if ScrollDownBtn.ImageTransparency == 1 then ScrollDownBtn.Visible = false end
            end)
            hideTw:Play()
        end
    end
end

ScrollDownBtn.MouseButton1Click:Connect(function()
    if CurrentActivePage then
        local maxScroll = math.max(0, CurrentActivePage.AbsoluteCanvasSize.Y - CurrentActivePage.AbsoluteWindowSize.Y)
        -- Ini rumus transisi level dewa, bosku!
        TweenService:Create(CurrentActivePage, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, maxScroll)}):Play()
    end
end)

RunService.RenderStepped:Connect(function()
    for _, child in pairs(PageContainer:GetChildren()) do
        if child:IsA("ScrollingFrame") and child.Visible then
            if CurrentActivePage ~= child then
                CurrentActivePage = child
                CheckScrollStatus() -- Langsung dicek saat ganti tab!
            end
            break
        end
    end
end)

for _, child in pairs(PageContainer:GetChildren()) do
    if child:IsA("ScrollingFrame") then
        child:GetPropertyChangedSignal("CanvasPosition"):Connect(CheckScrollStatus)
        child:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(CheckScrollStatus)
    end
end
-- ==========================================================

P1.Visible = true

BtnMin.MouseButton1Click:Connect(function()
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0, 27), BackgroundTransparency = 1}, 0.35).Completed:Connect(function() MainFrame.Visible = false end)
end)

-- LOGIKA FULLSCREEN MEKAR LEGA TAPI SISA SEUPIL & TUMPUL MANJA!
local isMaximized = false
BtnMax.MouseButton1Click:Connect(function()
    isMaximized = not isMaximized
    local mainCorner = MainFrame:FindFirstChildOfClass("UICorner") -- Deteksi sudut buat ditumpulin
    
    if isMaximized then
        Tween(MainFrame, {Size = UDim2.new(0.92, 0, 0.96, 0)}, 0.4) -- MAKIN LEBAR KE ATAS BAWAH!
        if mainCorner then Tween(mainCorner, {CornerRadius = UDim.new(0, 30)}, 0.4) end -- TUMPUL SUPER MANJA!
        
        Tween(SidebarBG, {Size = UDim2.new(0, 140, 1, -50)}, 0.4)
        Tween(PageContainer, {Size = UDim2.new(1, -160, 1, -50), Position = UDim2.new(0, 155, 0, 40)}, 0.4)
        Tween(MaxIcon, {ImageColor3 = ColorAccent}, 0.3)
    else
        Tween(MainFrame, {Size = UDim2.new(0, 420, 0, 300)}, 0.4)
        if mainCorner then Tween(mainCorner, {CornerRadius = UDim.new(0, 18)}, 0.4) end -- Balik tumpul normal
        
        Tween(SidebarBG, {Size = UDim2.new(0, 110, 1, -50)}, 0.4)
        Tween(PageContainer, {Size = UDim2.new(1, -130, 1, -50), Position = UDim2.new(0, 125, 0, 40)}, 0.4)
        Tween(MaxIcon, {ImageColor3 = ColorDesc}, 0.3)
    end
end)

Capsule.MouseButton1Click:Connect(function()
    if not MainFrame.Visible then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0, 27)
        MainFrame.BackgroundTransparency = 1
        MainFrame.Visible = true
        local targetSize = isMaximized and UDim2.new(0.9, 0, 0.85, 0) or UDim2.new(0, 420, 0, 300)
        Tween(MainFrame, {
            Size = targetSize,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 0.1
        }, 0.4)
    else
        Tween(MainFrame, {Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
    end
end)

ApplyHover(Capsule, ColorMain, ColorToggleOff)

-- DI-REVAMP TOTAL: TUMPUL KOTAK MANJA LEBIH RINGKAS & MODERN!
local ConfirmPopup = Instance.new("Frame", ScreenGui)
ConfirmPopup.Size = UDim2.new(0, 250, 0, 120)
ConfirmPopup.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmPopup.Position = UDim2.new(0.5, 0, 0.5, 15)
ConfirmPopup.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
ConfirmPopup.BackgroundTransparency = 1
ConfirmPopup.ClipsDescendants = true -- FIX MUTLAK: Biar ga ada ujung lancip meluber keluar!
ConfirmPopup.Visible = false
ConfirmPopup.ZIndex = 999
Instance.new("UICorner", ConfirmPopup).CornerRadius = UDim.new(0, 14)

-- FIX TAMBAHAN: Pastiin MainFrame juga strict clipnya biar ga ada lancip di ujung Hub
if MainFrame then MainFrame.ClipsDescendants = true end

local CTitle = Instance.new("TextLabel", ConfirmPopup)
CTitle.Size = UDim2.new(1, 0, 0, 25)
CTitle.Position = UDim2.new(0, 0, 0, 15)
CTitle.BackgroundTransparency = 1
CTitle.Text = "Keluar dari Hub?"
CTitle.TextColor3 = ColorText
CTitle.TextTransparency = 1
CTitle.Font = FontTitle
CTitle.TextSize = 14
CTitle.ZIndex = 1000

local CDesc = Instance.new("TextLabel", ConfirmPopup)
CDesc.Size = UDim2.new(1, -30, 0, 30)
CDesc.Position = UDim2.new(0, 15, 0, 40)
CDesc.BackgroundTransparency = 1
CDesc.Text = "Apakah Anda yakin ingin mematikan script Vickyyvall Hub?" -- TEGAS PAKE ANDA! NO ALAY!
CDesc.TextColor3 = ColorDesc
CDesc.TextTransparency = 1
CDesc.TextWrapped = true
CDesc.Font = FontDesc
CDesc.TextSize = 10
CDesc.ZIndex = 1000

-- RE-SETUP DICTIONARY BIAR BAHASA LAIN IKUT RE-RENDER TEGAS PAKE ANDA
LangDict["Pop_Desc"] = {ID = "Apakah Anda yakin ingin mematikan script Vickyyvall Hub?", EN = "Are you sure you want to close the script?", PT = "Tem certeza de que deseja fechar o script?", ZH = "\u{60a8}\u{786e}\u{5b9a}\u{8981}\u{5173}\u{95ed}\u{811a}\u{672c}\u{5417}\u{ff1f}", ES = "¿Estás seguro de que quieres cerrar el script?", AR = "\u{0647}\u{0644} \u{0625}\u{0646}\u{062a} \u{0645}\u{062a}\u{0623}\u{0643}\u{062f}\u{061f}", FR = "Êtes-vous sûr?", RU = "\u{0412}\u{044b} \u{0443}\u{0432}\u{0435}\u{0440}\u{0435}\u{043d}\u{044b}?", HI = "\u{0915}\u{094d}\u{092f}\u{093e} \u{0906}\u{092a} \u{0938}\u{094d}\u{0915}\u{094d}\u{0930}\u{093f}\u{092a}\u{094d}\u{091f} \u{092c}\u{0902}\u{0926} \u{0915}\u{0930}\u{0928}\u{093e} \u{091a}\u{093e}\u{0939}\u{0924}\u{0947} \u{0939}\u{0948}\u{0902}?", DE = "Sind Sie sicher?"}

-- TOMBOL YA SEMPURNA (GELAP SEMPURNA BUKAN ABU/BIRU MURAHAN)
local BtnYa = Instance.new("TextButton", ConfirmPopup)
BtnYa.Size = UDim2.new(0, 95, 0, 30)
BtnYa.Position = UDim2.new(0, 20, 0, 75)
BtnYa.BackgroundColor3 = Color3.fromRGB(25, 25, 30) -- Gelap premium terintegrasi
BtnYa.BackgroundTransparency = 1
BtnYa.Text = "Ya"
BtnYa.TextColor3 = Color3.fromRGB(255, 75, 75) -- Merah aksen tegas tanda keluar
BtnYa.TextTransparency = 1
BtnYa.Font = FontTitle
BtnYa.TextSize = 12
BtnYa.AutoButtonColor = false
BtnYa.ZIndex = 1000
Instance.new("UICorner", BtnYa).CornerRadius = UDim.new(0, 8)

-- TOMBOL BATAL SEMPURNA
local BtnBatal = Instance.new("TextButton", ConfirmPopup)
BtnBatal.Size = UDim2.new(0, 95, 0, 30)
BtnBatal.Position = UDim2.new(1, -115, 0, 75)
BtnBatal.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
BtnBatal.BackgroundTransparency = 1
BtnBatal.Text = "Batal"
BtnBatal.TextColor3 = ColorText
BtnBatal.TextTransparency = 1
BtnBatal.Font = FontTitle
BtnBatal.TextSize = 12
BtnBatal.AutoButtonColor = false
BtnBatal.ZIndex = 1000
Instance.new("UICorner", BtnBatal).CornerRadius = UDim.new(0, 8)

RegisterTranslation(CTitle, "Text", "Pop_Title")
RegisterTranslation(CDesc, "Text", "Pop_Desc")
RegisterTranslation(BtnYa, "Text", "Pop_Yes")
RegisterTranslation(BtnBatal, "Text", "Pop_No")

-- FUNGSI FADE DENGAN TRANSISI LEMAH LEMBUT (Quint Easing Style!)
local function FadePopup(show)
    local targetAlpha = show and 0 or 1
    local targetBgAlpha = show and 0.15 or 1
    local targetPos = show and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 15)
    local duration = 0.5 -- Lemah lembut pelan tapi responsif
    
    if show then ConfirmPopup.Visible = true end
    
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    TweenService:Create(ConfirmPopup, tweenInfo, {BackgroundTransparency = targetBgAlpha, Position = targetPos}):Play()
    TweenService:Create(CTitle, tweenInfo, {TextTransparency = targetAlpha}):Play()
    TweenService:Create(CDesc, tweenInfo, {TextTransparency = targetAlpha}):Play()
    
    TweenService:Create(BtnYa, tweenInfo, {
        BackgroundTransparency = show and 0 or 1,
        TextTransparency = targetAlpha
    }):Play()
    
    TweenService:Create(BtnBatal, tweenInfo, {
        BackgroundTransparency = show and 0 or 1,
        TextTransparency = targetAlpha
    }):Play()
    
    if not show then 
        task.delay(duration, function() ConfirmPopup.Visible = false end) 
    end
end

-- HOVER PREMIUM UNTUK DUA TOMBOL POPUP
BtnYa.MouseEnter:Connect(function() Tween(BtnYa, {BackgroundColor3 = Color3.fromRGB(40, 20, 20)}, 0.2) end)
BtnYa.MouseLeave:Connect(function() Tween(BtnYa, {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}, 0.2) end)
BtnBatal.MouseEnter:Connect(function() Tween(BtnBatal, {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}, 0.2) end)
BtnBatal.MouseLeave:Connect(function() Tween(BtnBatal, {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}, 0.2) end)

-- LOGIKA KLIK TRANSISI LEMAH LEMBUT PADA POPUP
BtnBatal.MouseButton1Click:Connect(function()
    FadePopup(false)
    task.wait(0.3)
    MainFrame.Visible = true
end)
BtnClose.MouseButton1Click:Connect(function()
    FadePopup(true)
end)

BtnYa.MouseButton1Click:Connect(function()
    FadePopup(false)
    Tween(Capsule, {BackgroundTransparency = 1, TextTransparency = 1}, 0.4)
    Tween(CapIcon, {ImageTransparency = 1}, 0.4)
    task.delay(0.5, function()
        ScreenGui:Destroy()
    end)
end)

-- SETUP AWAL: Render tersembunyi di atas dekat kapsul biar pas di-execute ga ngagetin!
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0, 27)
MainFrame.Visible = false

task.spawn(function()
    task.wait(0.5) -- Biarkan semua aset selesai termuat
    MainFrame.Visible = true
    Tween(MainFrame, {
        Size = UDim2.new(0, 420, 0, 300),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 0.1
    }, 0.4)
end)

local ColRed = Color3.fromRGB(255, 50, 50)
local ColBlue = Color3.fromRGB(50, 150, 255)
local ColGreen = Color3.fromRGB(50, 255, 100)
local ColPurple = Color3.fromRGB(180, 100, 255)
local ColPink = Color3.fromRGB(255, 100, 200)
local ColSun = Color3.fromRGB(255, 200, 50)
local ColGrey = Color3.fromRGB(150, 150, 150)
local ColTech = Color3.fromRGB(100, 200, 255)

CreateButton(P1, "rbxthumb://type=Asset&id=115818459248497&w=150&h=150", ColRed, "Reset_T", "Reset_D", function() 
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.Health = 0 end 
end)

CreateButton(P1, "rbxthumb://type=Asset&id=122305900902096&w=150&h=150", ColBlue, "Rejoin_T", "Rejoin_D", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

CreateButton(P1, "rbxthumb://type=Asset&id=14547726114&w=150&h=150", ColBlue, "Hop_T", "Hop_D", function()
    local s = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100")).data
    for _, v in pairs(s) do if v.playing < v.maxPlayers and v.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, LocalPlayer); break end end
end)

local CFG = {Speed = false, SpeedVal = 16, Jump = false, JumpVal = 50, Noclip = false}
local defSpeed, defJump = 16, 50 

CreateToggleSlider(P1, "rbxthumb://type=Asset&id=118923939982686&w=150&h=150", ColGreen, "Speed_T", "Speed_D", 16, 300, 50, "", function(s, v) 
    CFG.Speed = s; CFG.SpeedVal = v 
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
        if s then
            if LocalPlayer.Character.Humanoid.WalkSpeed ~= v then defSpeed = LocalPlayer.Character.Humanoid.WalkSpeed end
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = defSpeed
        end
    end
end)

CreateToggleSlider(P1, "rbxthumb://type=Asset&id=99183002748390&w=150&h=150", ColGreen, "Jump_T", "Jump_D", 50, 300, 50, "", function(s, v) 
    CFG.Jump = s; CFG.JumpVal = v 
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true 
        if s then
            if LocalPlayer.Character.Humanoid.JumpPower ~= v then defJump = LocalPlayer.Character.Humanoid.JumpPower end
            LocalPlayer.Character.Humanoid.JumpPower = v
        else
            LocalPlayer.Character.Humanoid.JumpPower = defJump
        end
    end
end)

CreateToggle(P1, "rbxthumb://type=Asset&id=17894477536&w=150&h=150", ColGreen, nil, "Inf_T", "Inf_D", function(s) _G.InfJump = s end)
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

CreateToggle(P1, "rbxthumb://type=Asset&id=6695068956&w=150&h=150", ColPurple, nil, "Noclip_T", "Noclip_D", function(s) 
    CFG.Noclip = s 
    if not s and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end 
        end
    end
end)

local flying, flySpeed = false, 50
CreateToggleSlider(P1, "rbxthumb://type=Asset&id=17588630193&w=150&h=150", ColPurple, "Fly_T", "Fly_D", 10, 300, 50, "", function(s, v) flying = s; flySpeed = v end)

local bg, bv
RunService.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        if CFG.Speed then hum.WalkSpeed = CFG.SpeedVal end
        if CFG.Jump then hum.JumpPower = CFG.JumpVal end
    end
    if CFG.Noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
end)

local wasFlying = false
RunService.RenderStepped:Connect(function()
    if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
        wasFlying = true
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local hum = LocalPlayer.Character.Humanoid
        
        if not bg then 
            bg = Instance.new("BodyGyro", hrp)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = hrp.CFrame 
        end
        
        if not bv then 
            bv = Instance.new("BodyVelocity", hrp)
            bv.velocity = Vector3.new(0, 0, 0) 
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
        end

        hum.PlatformStand = true
        bg.cframe = Camera.CFrame
        
        local dir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
        
        bv.velocity = dir * flySpeed
    else
        if wasFlying then
            wasFlying = false
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.PlatformStand = false
            end
            if bg then bg:Destroy(); bg = nil end
            if bv then bv:Destroy(); bv = nil end
        end
    end
end)

local ESP_Box_Color = Color3.fromRGB(255, 255, 255)
local ESP_NameDist, ESP_Health, ESP_Box = false, false, false
local ESPFolder = Instance.new("Folder", CoreGui); ESPFolder.Name = "VickESP_HighlightMutlak"
local Highlights = {}
local hueOffset = 0

CreateToggle(P2, "rbxthumb://type=Asset&id=5219208999&w=150&h=150", Color3.fromRGB(255, 255, 255), ColPink, "ESP_T", "ESP_D", function(s) ESP_NameDist = s end)
CreateToggle(P2, "rbxthumb://type=Asset&id=13288270283&w=150&h=150", ColPink, nil, "HP_T", "HP_D", function(s) ESP_Health = s end)

-- BOX ESP TOGGLE (DENGAN DROPDOWN MANJA)
local BoxFrame = Instance.new("Frame", P2)
BoxFrame.Size = UDim2.new(1, -4, 0, 75)
BoxFrame.BackgroundColor3 = ColorMain
BoxFrame.BackgroundTransparency = 0.5
Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 8)

local BoxImg = Instance.new("ImageLabel", BoxFrame)
BoxImg.Size = UDim2.new(0, 18, 0, 18)
BoxImg.AnchorPoint = Vector2.new(0, 0.5)
BoxImg.Position = UDim2.new(0, 12, 0.5, 0) -- TENGAH MUTLAK KIRI!
BoxImg.BackgroundTransparency = 1
BoxImg.Image = "rbxthumb://type=Asset&id=112499571301742&w=150&h=150" 
BoxImg.ImageColor3 = Color3.fromRGB(255, 255, 255) 

local BoxTitle = Instance.new("TextLabel", BoxFrame)
BoxTitle.Size = UDim2.new(1, -129, 0, 16) 
BoxTitle.Position = UDim2.new(0, 48, 0, 8) -- RAPIH, LEGA, GESER KANAN!
BoxTitle.BackgroundTransparency = 1
BoxTitle.TextColor3 = ColorText
BoxTitle.Font = FontMain
BoxTitle.TextSize = 12
BoxTitle.TextXAlignment = Enum.TextXAlignment.Left
RegisterTranslation(BoxTitle, "Text", "Box_T")

local BoxDesc = Instance.new("TextLabel", BoxFrame)
BoxDesc.Size = UDim2.new(1, -129, 0, 42) -- PAS 42, NGGAK NYENTUH LANTAI!
BoxDesc.Position = UDim2.new(0, 48, 0, 26) -- DITENGAH DENGAN SEMPURNA!
BoxDesc.BackgroundTransparency = 1
BoxDesc.TextColor3 = ColorDesc
BoxDesc.Font = FontDesc
BoxDesc.TextSize = 10
BoxDesc.TextXAlignment = Enum.TextXAlignment.Left
BoxDesc.TextYAlignment = Enum.TextYAlignment.Top
BoxDesc.TextWrapped = true
RegisterTranslation(BoxDesc, "Text", "Box_D")

BoxFrame.ClipsDescendants = true -- OBAT MUTLAK BIAR BAYANGAN KOTAK SEPELE IKUT TUMPUL MANJA!

-- TOGGLE BUTTON BOX ESP 
local BoxBtn = Instance.new("TextButton", BoxFrame)
BoxBtn.Size = UDim2.new(0, 38, 0, 18)
BoxBtn.Position = UDim2.new(1, -85, 0.5, -9)
BoxBtn.BackgroundColor3 = ColorToggleOff
BoxBtn.Text = ""
BoxBtn.AutoButtonColor = false
BoxBtn.Active = true
BoxBtn.ZIndex = 100
Instance.new("UICorner", BoxBtn).CornerRadius = UDim.new(1, 0)

local BoxInd = Instance.new("Frame", BoxBtn)
BoxInd.Size = UDim2.new(0, 14, 0, 14)
BoxInd.Position = UDim2.new(0, 2, 0.5, -7)
BoxInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BoxInd.ZIndex = 100
Instance.new("UICorner", BoxInd).CornerRadius = UDim.new(1, 0)

-- ICON DROPDOWN LEMAH LEMBUT MANJA
local DropBtn = Instance.new("TextButton", BoxFrame)
DropBtn.Size = UDim2.new(0, 30, 0, 30)
DropBtn.Position = UDim2.new(1, -40, 0.5, -15)
DropBtn.BackgroundTransparency = 1
DropBtn.Text = ""
DropBtn.Active = true
DropBtn.ZIndex = 100

local DropIcon = Instance.new("ImageLabel", DropBtn)
DropIcon.Size = UDim2.new(0, 16, 0, 16)
DropIcon.AnchorPoint = Vector2.new(0.5, 0.5)
DropIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
DropIcon.BackgroundTransparency = 1
DropIcon.Image = "rbxthumb://type=Asset&id=5279719076&w=150&h=150"
DropIcon.ImageColor3 = ColorDesc
DropIcon.ZIndex = 100

-- FRAME COLOR PICKER
local CP_Frame = Instance.new("Frame", P2)
CP_Frame.Size = UDim2.new(1, -4, 0, 0) 
CP_Frame.BackgroundColor3 = ColorMain
CP_Frame.BackgroundTransparency = 0.8
CP_Frame.ClipsDescendants = true 
CP_Frame.Visible = false
CP_Frame.ZIndex = 5 
Instance.new("UICorner", CP_Frame).CornerRadius = UDim.new(0, 8)

-- ==========================================================
-- ICON CUSTOM COLOR ESP & TEKS (SEJAJAR MUTLAK)
-- ==========================================================
local CP_Icon = Instance.new("ImageLabel", CP_Frame)
CP_Icon.Size = UDim2.new(0, 18, 0, 18)
CP_Icon.AnchorPoint = Vector2.new(0, 0.5)
CP_Icon.Position = UDim2.new(0, 12, 0, 24) -- TENGAH MUTLAK SEJAJAR SAMA ICON LAIN!
CP_Icon.BackgroundTransparency = 1
CP_Icon.Image = "rbxthumb://type=Asset&id=111189222786853&w=150&h=150"
CP_Icon.ImageColor3 = ColPink 

local CP_Title = Instance.new("TextLabel", CP_Frame)
CP_Title.Size = UDim2.new(1, -60, 0, 16)
CP_Title.AnchorPoint = Vector2.new(0, 0.5)
CP_Title.Position = UDim2.new(0, 48, 0, 24) -- SEJAJAR RAPIH KE KANAN!
CP_Title.BackgroundTransparency = 1
CP_Title.Text = "Custom Color Box ESP"
CP_Title.TextColor3 = ColorDesc
CP_Title.Font = FontMain
CP_Title.TextSize = 12
CP_Title.TextXAlignment = Enum.TextXAlignment.Left

local CP_Btn = Instance.new("TextButton", CP_Frame)
CP_Btn.Size = UDim2.new(0, 38, 0, 18)
CP_Btn.Position = UDim2.new(1, -85, 0, 15) -- SEJAJAR MUTLAK SAMA TOGGLE BOX ESP!
CP_Btn.BackgroundColor3 = ColorToggleOff
CP_Btn.Text = ""
Instance.new("UICorner", CP_Btn).CornerRadius = UDim.new(1, 0)

local CP_Ind = Instance.new("Frame", CP_Btn)
CP_Ind.Size = UDim2.new(0, 14, 0, 14)
CP_Ind.Position = UDim2.new(0, 2, 0.5, -7)
CP_Ind.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", CP_Ind).CornerRadius = UDim.new(1, 0)

local ColorWheel = Instance.new("ImageLabel", CP_Frame)
ColorWheel.Size = UDim2.new(0, 100, 0, 100) 
ColorWheel.Position = UDim2.new(0, 10, 0, 50) 
ColorWheel.BackgroundTransparency = 1
ColorWheel.Image = "rbxthumb://type=Asset&id=81067781901104&w=150&h=150" 
ColorWheel.ImageColor3 = Color3.fromRGB(255, 255, 255)

local WheelKnob = Instance.new("Frame", ColorWheel)
WheelKnob.Size = UDim2.new(0, 4, 0, 4) 
WheelKnob.AnchorPoint = Vector2.new(0.5, 0.5)
WheelKnob.Position = UDim2.new(0.5, 0, 0.5, 0)
WheelKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WheelKnob.BorderSizePixel = 0
WheelKnob.Visible = false
Instance.new("UICorner", WheelKnob).CornerRadius = UDim.new(1, 0)
local WStroke = Instance.new("UIStroke", WheelKnob)
WStroke.Color = Color3.fromRGB(0, 0, 0)
WStroke.Thickness = 1

local ValBar = Instance.new("Frame", CP_Frame)
ValBar.Size = UDim2.new(0, 15, 0, 100)
ValBar.Position = UDim2.new(0, 125, 0, 50) 
ValBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ValBar).CornerRadius = UDim.new(1, 0)

local ValGrad = Instance.new("UIGradient", ValBar)
ValGrad.Rotation = 90
ValGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1,1,1)), ColorSequenceKeypoint.new(1, Color3.new(0,0,0))})

local ValKnob = Instance.new("Frame", ValBar)
ValKnob.Size = UDim2.new(1, 4, 0, 4)
ValKnob.Position = UDim2.new(0.5, 0, 0, 0)
ValKnob.AnchorPoint = Vector2.new(0.5, 0.5)
ValKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ValKnob.BorderSizePixel = 0
Instance.new("UICorner", ValKnob).CornerRadius = UDim.new(1, 0)
local ValStroke = Instance.new("UIStroke", ValKnob)
ValStroke.Color = Color3.fromRGB(0, 0, 0)
ValStroke.Thickness = 1

local ColorShow = Instance.new("Frame", CP_Frame)
ColorShow.Size = UDim2.new(0, 100, 0, 100)
ColorShow.Position = UDim2.new(0, 155, 0, 50) 
ColorShow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ColorShow).CornerRadius = UDim.new(0, 14)
local CS_Stroke = Instance.new("UIStroke", ColorShow)
CS_Stroke.Color = Color3.fromRGB(255, 255, 255)
CS_Stroke.Thickness = 1.5
CS_Stroke.Transparency = 0.8

-- HEX CONTAINER REVAMP
local HexContainer = Instance.new("Frame", ColorShow)
HexContainer.Size = UDim2.new(1, 0, 0, 22)
HexContainer.Position = UDim2.new(0, 0, 0, 4)
HexContainer.BackgroundTransparency = 1

local HexText = Instance.new("TextLabel", HexContainer)
HexText.Size = UDim2.new(1, -28, 1, 0)
HexText.Position = UDim2.new(0, 8, 0, 0) 
HexText.BackgroundTransparency = 1
HexText.Text = "#FFFFFF"
HexText.TextColor3 = Color3.fromRGB(255, 255, 255)
HexText.Font = Enum.Font.Oswald 
HexText.TextSize = 13
HexText.TextXAlignment = Enum.TextXAlignment.Left

local HexStroke = Instance.new("UIStroke", HexText)
HexStroke.Thickness = 1.2
HexStroke.Enabled = true

local CopyBtn = Instance.new("TextButton", HexContainer)
CopyBtn.Size = UDim2.new(0, 14, 0, 14)
CopyBtn.Position = UDim2.new(1, -20, 0.5, -7) 
CopyBtn.BackgroundTransparency = 1
CopyBtn.Text = ""

local CopyIcon = Instance.new("ImageLabel", CopyBtn)
CopyIcon.Size = UDim2.new(1, 0, 1, 0)
CopyIcon.AnchorPoint = Vector2.new(0.5, 0.5)
CopyIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
CopyIcon.BackgroundTransparency = 1
CopyIcon.Image = "rbxthumb://type=Asset&id=139712002348440&w=150&h=150"
CopyIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

-- LOGIKA RGB ANIMASI (Soft Spoken)
RunService.RenderStepped:Connect(function()
    if DropIcon and DropIcon.Parent then
        DropIcon.ImageColor3 = Color3.fromHSV((tick() * 0.15) % 1, 0.9, 1) 
    end
    if HexStroke and HexStroke.Parent then
        HexStroke.Color = Color3.fromHSV((tick() * 0.4) % 1, 1, 1)
    end
end)

local Spacer = Instance.new("Frame", P2)
Spacer.Size = UDim2.new(1, 0, 0, 1) 
Spacer.BackgroundTransparency = 1
Spacer.Visible = false
Spacer.LayoutOrder = 1 
CP_Frame.LayoutOrder = 2 

local hue, sat, val = 0, 0, 1
local cpActive = false
local dropOpen = false
local draggingWheel, draggingVal = false, false

-- ==========================================================
-- NOTIFIKASI MERAH ANTI-SPAM (CERAH & LEBIH TUMPUL)
-- ==========================================================
local ActiveRedNotif = nil -- Variabel penjaga biar ga numpuk!

local function SendRedNotif()
    if ActiveRedNotif and ActiveRedNotif.Parent then
        Tween(ActiveRedNotif, {Position = UDim2.new(1, -25, 1, -20)}, 0.05).Completed:Connect(function()
            Tween(ActiveRedNotif, {Position = UDim2.new(1, -20, 1, -20)}, 0.05)
        end)
        return
    end

    local NotifFrame = Instance.new("Frame", ScreenGui)
    NotifFrame.Size = UDim2.new(0, 280, 0, 70)
    NotifFrame.AnchorPoint = Vector2.new(1, 1)
    NotifFrame.Position = UDim2.new(1, 300, 1, -20)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18) -- Solid gelap bersih, bukan transparan dekil
    NotifFrame.BackgroundTransparency = 0.05 -- Transparan tipis banget biar warna teks tetep terang
    NotifFrame.ZIndex = 9999
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 16) -- FIX: JAUH LEBIH TUMPUL (DARI 8 JADI 16)
    
    ActiveRedNotif = NotifFrame -- Set jadi aktif!
    
    local NotifStroke = Instance.new("UIStroke", NotifFrame)
    NotifStroke.Color = Color3.fromRGB(255, 50, 50) 
    NotifStroke.Transparency = 0.3
    NotifStroke.Thickness = 1
    
    local NotifLogo = Instance.new("ImageLabel", NotifFrame)
    NotifLogo.Size = UDim2.new(0, 30, 0, 30)
    NotifLogo.Position = UDim2.new(0, 15, 0.5, -15)
    NotifLogo.BackgroundTransparency = 1
    NotifLogo.Image = "rbxthumb://type=Asset&id=124812207341425&w=150&h=150" 
    NotifLogo.ImageColor3 = Color3.fromRGB(255, 50, 50) 
    
    NotifLogo.ZIndex = 10000 
    local NTitle = Instance.new("TextLabel", NotifFrame)
    NTitle.Size = UDim2.new(1, -60, 0, 20)
    NTitle.Position = UDim2.new(0, 55, 0, 10)
    NTitle.BackgroundTransparency = 1
    NTitle.TextColor3 = Color3.fromRGB(255, 255, 255) 
    NTitle.Font = FontTitle
    NTitle.TextSize = 14
    NTitle.TextXAlignment = Enum.TextXAlignment.Left
    NTitle.ZIndex = 10000 
    RegisterTranslation(NTitle, "Text", "NotifRed_T") -- FIX MUTLAK BAHASA!
    
    local NDesc = Instance.new("TextLabel", NotifFrame)
    NDesc.Size = UDim2.new(1, -60, 0, 30)
    NDesc.Position = UDim2.new(0, 55, 0, 30)
    NDesc.BackgroundTransparency = 1
    NDesc.TextColor3 = Color3.fromRGB(255, 255, 255) 
    NDesc.Font = FontDesc
    NDesc.TextSize = 11
    NDesc.TextXAlignment = Enum.TextXAlignment.Left
    NDesc.TextYAlignment = Enum.TextYAlignment.Top
    NDesc.TextWrapped = true
    NDesc.ZIndex = 10000 
    RegisterTranslation(NDesc, "Text", "NotifRed_D") -- FIX MUTLAK BAHASA!
 
    Tween(NotifFrame, {Position = UDim2.new(1, -20, 1, -20)}, 0.5)
    task.delay(4, function()
        local hideTw = Tween(NotifFrame, {Position = UDim2.new(1, 300, 1, -20), BackgroundTransparency = 1}, 0.5)
        hideTw.Completed:Connect(function() 
            NotifFrame:Destroy() 
            ActiveRedNotif = nil -- Kosongin lagi pas udah ilang
        end)
    end)
end

DropBtn.MouseButton1Click:Connect(function()
    dropOpen = not dropOpen
    if dropOpen then
        Spacer.Visible = true
        CP_Frame.Visible = true
        Tween(CP_Frame, {Size = UDim2.new(1, -4, 0, 160)}, 0.4) -- UKURAN FRAME 160 BIAR LEGA GA DEMPETAN
        Tween(DropIcon, {Rotation = -180}, 0.4) 
    else
        Tween(DropIcon, {Rotation = 0}, 0.4)
        local t = Tween(CP_Frame, {Size = UDim2.new(1, -4, 0, 0)}, 0.4)
        t.Completed:Connect(function()
            if not dropOpen then 
                CP_Frame.Visible = false 
                Spacer.Visible = false
            end
        end)
    end
end)

local ActiveGreen = Color3.fromRGB(45, 140, 80) 
local DimmedColor = Color3.fromRGB(70, 70, 70) 
local NormalWhite = Color3.fromRGB(255, 255, 255)

local function UpdateColor()
    local rgbColor = Color3.fromHSV(hue, sat, val)
    
    if cpActive then
        ColorShow.BackgroundColor3 = rgbColor
    else
        ColorShow.BackgroundColor3 = Color3.new(
            rgbColor.R * 0.3 + 0.3,
            rgbColor.G * 0.3 + 0.3,
            rgbColor.B * 0.3 + 0.3
        )
    end
    
    ValGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, sat, 1)), ColorSequenceKeypoint.new(1, Color3.new(0,0,0))})
    
    local r = math.floor(rgbColor.R * 255)
    local g = math.floor(rgbColor.G * 255)
    local b = math.floor(rgbColor.B * 255)
    HexText.Text = string.format("#%02X%02X%02X", r, g, b)
    
    if (r*0.299 + g*0.587 + b*0.114) > 186 then
        HexText.TextColor3 = Color3.fromRGB(20, 20, 20)
        CopyIcon.ImageColor3 = Color3.fromRGB(20, 20, 20)
    else
        HexText.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end

    if cpActive and ESP_Box then ESP_Box_Color = rgbColor else ESP_Box_Color = Color3.fromRGB(255, 255, 255) end
end

CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard or toclipboard then
        local clipFunc = setclipboard or toclipboard
        clipFunc(HexText.Text)
        
        CopyIcon.Image = "rbxthumb://type=Asset&id=139712002348440&w=150&h=150"
        CopyIcon.Size = UDim2.new(1, 0, 1, 0)
        
        local flip1 = TweenService:Create(CopyIcon, TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 1, 0)})
        flip1:Play()
        
        flip1.Completed:Connect(function()
            CopyIcon.Image = "rbxthumb://type=Asset&id=7404086171&w=150&h=150"
            CopyIcon.ImageColor3 = Color3.fromRGB(50, 255, 100)
            TweenService:Create(CopyIcon, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
        end)
    end
end)

local function SetCPState(state)
    cpActive = state
    Tween(CP_Btn, {BackgroundColor3 = cpActive and ActiveGreen or ColorToggleOff}, 0.25)
    Tween(CP_Ind, {Position = cpActive and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}, 0.25)
    Tween(ColorWheel, {ImageColor3 = cpActive and NormalWhite or DimmedColor}, 0.3)
    Tween(ValBar, {BackgroundColor3 = cpActive and NormalWhite or DimmedColor}, 0.3)
    CP_Title.TextColor3 = ColorText 
    WheelKnob.Visible = cpActive
    UpdateColor() 
end

BoxBtn.MouseButton1Click:Connect(function()
    ESP_Box = not ESP_Box
    Tween(BoxBtn, {BackgroundColor3 = ESP_Box and ColPink or ColorToggleOff}, 0.25) -- SEKARANG COL-PINK (WARNA PENTING) WOY, BUKAN PUTIH LAGI!
    Tween(BoxInd, {Position = ESP_Box and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}, 0.25)
    for p, data in pairs(Highlights) do
        if data.Highlight then data.Highlight:Destroy() end
        if data.Bill then data.Bill:Destroy() end
    end
    table.clear(Highlights)
    
    if not ESP_Box and cpActive then
        SetCPState(false)
    end
end)

CP_Btn.MouseButton1Click:Connect(function()
    if not ESP_Box then 
        SendRedNotif() 
        return 
    end
    SetCPState(not cpActive)
end)

ColorWheel.Active = true 
ValBar.Active = true 

ColorWheel.InputBegan:Connect(function(input)
    if cpActive and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
        draggingWheel = true; P2.ScrollingEnabled = false 
    end
end)
ValBar.InputBegan:Connect(function(input)
    if cpActive and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
        draggingVal = true; P2.ScrollingEnabled = false 
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        draggingWheel = false; draggingVal = false; P2.ScrollingEnabled = true 
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not cpActive then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if draggingWheel then
            local mp = input.Position
            local center = ColorWheel.AbsolutePosition + (ColorWheel.AbsoluteSize / 2)
            local dist = (Vector2.new(mp.X, mp.Y) - center)
            local radius = (ColorWheel.AbsoluteSize.X / 2) - 4
            if dist.Magnitude > radius then dist = dist.Unit * radius end
            WheelKnob.Position = UDim2.new(0.5, dist.X, 0.5, dist.Y)
            local angle = math.atan2(-dist.Y, dist.X) 
            local h = angle / (math.pi * 2)
            if h < 0 then h = h + 1 end
            hue = h
            sat = dist.Magnitude / radius
            UpdateColor()
        elseif draggingVal then
            local mp = input.Position.Y
            local rel = math.clamp((mp - ValBar.AbsolutePosition.Y) / ValBar.AbsoluteSize.Y, 0, 1)
            ValKnob.Position = UDim2.new(0.5, 0, rel, 0)
            val = 1 - rel
            UpdateColor()
        end
    end
end)

local function GetRainbowText(text, offset)
    local res = ""
    local len = string.len(text)
    for i = 1, len do
        local c = string.sub(text, i, i)
        if c == " " then res = res .. " " else
            local hue = (offset - (i * 0.05)) % 1
            local clr = Color3.fromHSV(hue, 1, 1)
            res = res .. string.format("<font color='rgb(%d,%d,%d)'>%s</font>", math.floor(clr.R*255), math.floor(clr.G*255), math.floor(clr.B*255), c)
        end
    end
    return res
end

-- =========================================================================
-- RENDER ESP HIGHLIGHT MUTLAK! 
-- =========================================================================
local function UpdateHighlightESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                
                if Highlights[p] and Highlights[p].Highlight.Adornee ~= char then
                    Highlights[p].Highlight:Destroy()
                    Highlights[p].Bill:Destroy()
                    Highlights[p] = nil 
                end

                if not Highlights[p] then
                    local hl = Instance.new("Highlight", ESPFolder)
                    hl.Name = p.Name .. "_ESP"
                    hl.FillTransparency = 1 -- FIX: Dalamnya bolong mutlak, cuma garis outline!
                    hl.OutlineTransparency = 0 -- FIX: Pinggirannya nyala!
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    
                    local txtGui = Instance.new("BillboardGui", ESPFolder)
                    txtGui.Name = "TextGui_"..p.Name
                    txtGui.Size = UDim2.new(0, 400, 0, 40)
                    txtGui.AlwaysOnTop = true
                    txtGui.StudsOffset = Vector3.new(0, 3.5, 0)
                    
                    local tl = Instance.new("TextLabel", txtGui)
                    tl.Size = UDim2.new(1, 0, 1, 0)
                    tl.BackgroundTransparency = 1
                    tl.TextStrokeTransparency = 0.3
                    tl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                    tl.Font = FontESP
                    tl.TextSize = 14
                    tl.RichText = true
                    tl.TextYAlignment = Enum.TextYAlignment.Bottom
                    
                    Highlights[p] = {Highlight = hl, Bill = txtGui, Text = tl}
                end
                
                local espData = Highlights[p]
                espData.Highlight.Adornee = char
                espData.Bill.Adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                
                -- Logika ESP Highlight (Siluet Nempel Badan)
                if ESP_Box then
                    espData.Highlight.Enabled = true
                    if cpActive then
                        espData.Highlight.OutlineColor = ESP_Box_Color
                    else
                        -- Efek RGB Neon gerak manja kalau custom color mati
                        espData.Highlight.OutlineColor = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
                    end
                else
                    espData.Highlight.Enabled = false
                end
                
                -- Logika Text ESP (Nama & Darah)
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                
                local line1, line2, line3 = "", "", ""
                if ESP_NameDist then 
                    line1 = GetRainbowText(p.Name, hueOffset)
                    line2 = "<font color='rgb(50,255,50)'>[" .. math.floor(dist) .. "m]</font>" 
                end
                if ESP_Health then 
                    local max = hum.MaxHealth > 0 and hum.MaxHealth or 100
                    local cur = hum.Health
                    local perc = math.clamp(cur / max, 0, 1)
                    local hpCol = perc > 0.7 and "rgb(50,255,255)" or (perc >= 0.3 and "rgb(255,255,0)" or "rgb(255,50,50)")
                    line3 = "<font color='" .. hpCol .. "'>HP: " .. tostring(math.floor(cur)) .. "</font>" 
                end
                
                local finalTxt = ""
                if line1 ~= "" then finalTxt = line1 .. "\n" .. line2 end
                if line3 ~= "" then finalTxt = (finalTxt ~= "" and finalTxt .. "\n" .. line3) or line3 end
                
                espData.Text.Text = finalTxt
                espData.Bill.Enabled = (ESP_NameDist or ESP_Health)
            else
                -- Sembunyiin kalau mati / belum spawn biar ga bug
                if Highlights[p] then
                    Highlights[p].Highlight.Enabled = false
                    Highlights[p].Bill.Enabled = false
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function(dt)
    hueOffset = (hueOffset + dt * 0.4) % 1
    UpdateHighlightESP()
    
    -- 🔥 CURI RGB DARI FITUR NAME ESP BUAT ICON "NAME ESP" & "BOX ESP"!
    -- Ini pake rumus Name ESP lu: (tick() * 0.5) % 1
    local rgbNyuri = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
    
    for _, obj in pairs(P2:GetDescendants()) do
        if obj:IsA("ImageLabel") then
            -- Deteksi icon mata Naruto & icon Box ESP secara otomatis!
            if obj.Image == "rbxthumb://type=Asset&id=5219208999&w=150&h=150" or obj.Image == "rbxthumb://type=Asset&id=112499571301742&w=150&h=150" then
                obj.ImageColor3 = rgbNyuri
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if Highlights[p] then
        Highlights[p].Highlight:Destroy()
        Highlights[p].Bill:Destroy()
        Highlights[p] = nil
    end
end)

local oAmb, oOut, oTime = Lighting.Ambient, Lighting.OutdoorAmbient, Lighting.ClockTime
CreateToggle(P3, "rbxthumb://type=Asset&id=14482048782&w=150&h=150", ColGrey, ColSun, "Day_T", "Day_D", function(s) Lighting.ClockTime = s and 12 or oTime end)
CreateToggle(P3, "rbxthumb://type=Asset&id=16833255787&w=150&h=150", ColGrey, ColSun, "Glow_T", "Glow_D", function(s) 
    Lighting.GlobalShadows = not s
    if s then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.OutdoorAmbient = Color3.new(1, 1, 1) else Lighting.Ambient = oAmb; Lighting.OutdoorAmbient = oOut end
end)

-- ==========================================================
-- 🔥 FITUR ANTI-AFK PREMIUM (ICON GEDE SEBARIS & TRANSISI LEMAH LEMBUT!)
-- ==========================================================
local AFK_Frame = Instance.new("Frame", P4)
AFK_Frame.Size = UDim2.new(1, -4, 0, 75)
AFK_Frame.BackgroundColor3 = ColorMain
AFK_Frame.BackgroundTransparency = 0.5
Instance.new("UICorner", AFK_Frame).CornerRadius = UDim.new(0, 8)

-- ICON OFF (MERAH)
local AFK_IconOff = Instance.new("ImageLabel", AFK_Frame)
AFK_IconOff.Size = UDim2.new(0, 40, 0, 40) -- 🔥 GEDE LEGA SEKURAN JUDUL SAMPE KETERANGAN!
AFK_IconOff.Position = UDim2.new(0, 10, 0.5, -20) -- TETEP DI POSISI BIASA (KIRI)
AFK_IconOff.BackgroundTransparency = 1
AFK_IconOff.Image = "rbxthumb://type=Asset&id=96165359287667&w=150&h=150"
AFK_IconOff.ZIndex = 1

-- ICON ON (HIJAU PREMIUM) DITUMPUK DI ATASNYA!
local AFK_IconOn = Instance.new("ImageLabel", AFK_Frame)
AFK_IconOn.Size = UDim2.new(0, 40, 0, 40) 
AFK_IconOn.Position = UDim2.new(0, 10, 0.5, -20)
AFK_IconOn.BackgroundTransparency = 1
AFK_IconOn.Image = "rbxthumb://type=Asset&id=93330283163178&w=150&h=150"
AFK_IconOn.ImageTransparency = 1 -- Awalnya transparan/hilang
AFK_IconOn.ZIndex = 2

local AFK_Title = Instance.new("TextLabel", AFK_Frame)
AFK_Title.Size = UDim2.new(1, -114, 0, 16) 
AFK_Title.Position = UDim2.new(0, 60, 0, 12)
AFK_Title.BackgroundTransparency = 1
AFK_Title.TextColor3 = ColorText
AFK_Title.Font = FontMain
AFK_Title.TextSize = 12
AFK_Title.TextXAlignment = Enum.TextXAlignment.Left
RegisterTranslation(AFK_Title, "Text", "AFK_T")

local AFK_Desc = Instance.new("TextLabel", AFK_Frame)
AFK_Desc.Size = UDim2.new(1, -114, 0, 40) 
AFK_Desc.Position = UDim2.new(0, 60, 0, 30)
AFK_Desc.BackgroundTransparency = 1
AFK_Desc.TextColor3 = ColorDesc
AFK_Desc.Font = FontDesc
AFK_Desc.TextSize = 10
AFK_Desc.TextXAlignment = Enum.TextXAlignment.Left
AFK_Desc.TextYAlignment = Enum.TextYAlignment.Top
AFK_Desc.TextWrapped = true
RegisterTranslation(AFK_Desc, "Text", "AFK_D")

local AFK_Btn = Instance.new("TextButton", AFK_Frame)
AFK_Btn.Size = UDim2.new(0, 38, 0, 18)
AFK_Btn.Position = UDim2.new(1, -48, 0.5, -9)
AFK_Btn.BackgroundColor3 = ColorToggleOff
AFK_Btn.Text = ""
AFK_Btn.AutoButtonColor = false
Instance.new("UICorner", AFK_Btn).CornerRadius = UDim.new(1, 0)

local AFK_Ind = Instance.new("Frame", AFK_Btn)
AFK_Ind.Size = UDim2.new(0, 14, 0, 14)
AFK_Ind.Position = UDim2.new(0, 2, 0.5, -7)
AFK_Ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AFK_Ind).CornerRadius = UDim.new(1, 0)

AFK_Btn.MouseButton1Click:Connect(function()
    _G.AntiAFK = not _G.AntiAFK
    local state = _G.AntiAFK
    
    -- 🔥 TRANSISI SOFT SPOKEN, MEMANJAKAN MATA, NGEJRENGG LEMAH LEMBUT!
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    
    TweenService:Create(AFK_Btn, tweenInfo, {BackgroundColor3 = state and Color3.fromRGB(50, 255, 100) or ColorToggleOff}):Play()
    TweenService:Create(AFK_Ind, tweenInfo, {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
    
    -- Crossfade animasi ganti icon!
    TweenService:Create(AFK_IconOn, tweenInfo, {ImageTransparency = state and 0 or 1}):Play()
    TweenService:Create(AFK_IconOff, tweenInfo, {ImageTransparency = state and 1 or 0}):Play()
end)

LocalPlayer.Idled:Connect(function() 
    if _G.AntiAFK then 
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new()) 
    end 
end)

-- 🗿 ICON PUTIH MURNI & KOPONG!
local lPing = CreateInfo(P4, "rbxthumb://type=Asset&id=82571483730620&w=150&h=150", Color3.fromRGB(255, 255, 255), "Ping", "0 ms")
local lFps = CreateInfo(P4, "rbxthumb://type=Asset&id=134742030444605&w=150&h=150", Color3.fromRGB(255, 255, 255), "FPS", "0 FPS")
local lTime = CreateInfo(P4, "rbxthumb://type=Asset&id=17551409714&w=150&h=150", Color3.fromRGB(255, 255, 255), "Clock", "00:00:00")

-- SISTEM FPS MUTLAK (Hitung Frame Asli, Bukan Physics Game)
local frames = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
end)

-- 🔥 FUNGSI FPS, PING, JAM GW BIKIN KOPONG TOTAL SESUAI PERINTAH LU BRAY
task.spawn(function()
    while task.wait(1) do
        if not ScreenGui.Parent then break end 
        -- KOSONG MELOMPONG BRAY!
    end
end)

local DropFrame = Instance.new("Frame", P4)
DropFrame.Size = UDim2.new(1, -4, 0, 75) 
DropFrame.BackgroundColor3 = ColorMain
DropFrame.BackgroundTransparency = 0.5
Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 8)

local LangImg = Instance.new("ImageLabel", DropFrame)
LangImg.Size = UDim2.new(0, 24, 0, 24)
LangImg.AnchorPoint = Vector2.new(0, 0.5)
LangImg.Position = UDim2.new(0, 12, 0.5, 0) 
LangImg.BackgroundTransparency = 1
LangImg.Image = "rbxthumb://type=Asset&id=137384997162705&w=150&h=150" -- ICON DEFAULT INDO BOS!
LangImg.ImageColor3 = Color3.fromRGB(255, 255, 255)

local LangShine = Instance.new("ImageLabel", LangImg)
LangShine.Size = UDim2.new(1, 0, 1, 0)
LangShine.BackgroundTransparency = 1
LangShine.Image = LangImg.Image 
LangShine.ImageColor3 = Color3.fromRGB(255, 245, 180) 
LangShine.ZIndex = 2
local LGrad = Instance.new("UIGradient", LangShine)
LGrad.Rotation = 45
LGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.2, 1),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(0.8, 1),
    NumberSequenceKeypoint.new(1, 1)
})
RunService.RenderStepped:Connect(function()
    local t = (tick() % 4) / 4 
    LGrad.Offset = Vector2.new(-1.5 + (t * 3), 0)
end)

local LangTitle = Instance.new("TextLabel", DropFrame)
LangTitle.Size = UDim2.new(0.7, 0, 0, 16)
LangTitle.Position = UDim2.new(0, 48, 0, 10) -- NAIK SEUPIL BIAR PERFECT!
LangTitle.BackgroundTransparency = 1
LangTitle.TextColor3 = ColorText
LangTitle.Font = FontMain
LangTitle.TextSize = 12
LangTitle.TextXAlignment = Enum.TextXAlignment.Left
RegisterTranslation(LangTitle, "Text", "Lang_T")

local LangDesc = Instance.new("TextLabel", DropFrame)
LangDesc.Size = UDim2.new(1, -90, 0, 42) 
LangDesc.Position = UDim2.new(0, 48, 0, 24) -- SEJAJAR TENGAH SAMA JUDUL!
LangDesc.BackgroundTransparency = 1
LangDesc.TextColor3 = ColorDesc
LangDesc.Font = FontDesc
LangDesc.TextSize = 10
LangDesc.TextXAlignment = Enum.TextXAlignment.Left
LangDesc.TextYAlignment = Enum.TextYAlignment.Top
LangDesc.TextWrapped = true
RegisterTranslation(LangDesc, "Text", "Lang_D")

local LangLbl = Instance.new("TextLabel", DropFrame)
LangLbl.Visible = false 
LangLbl.Text = "Bahasa: Indonesia (Default)"

local LangDropBtn = Instance.new("TextButton", DropFrame)
LangDropBtn.Size = UDim2.new(1, 0, 1, 0)
LangDropBtn.BackgroundTransparency = 1
LangDropBtn.Text = ""
LangDropBtn.ZIndex = 50

local PtrImg2 = Instance.new("ImageLabel", DropFrame)
PtrImg2.Size = UDim2.new(0, 16, 0, 16)
PtrImg2.AnchorPoint = Vector2.new(0.5, 0.5)
PtrImg2.Position = UDim2.new(1, -22, 0.5, 0)
PtrImg2.BackgroundTransparency = 1
PtrImg2.Image = "rbxthumb://type=Asset&id=5279719076&w=150&h=150" 
PtrImg2.ImageColor3 = ColorAccent

local LangScroll = Instance.new("ScrollingFrame", P4)
LangScroll.Size = UDim2.new(1, -4, 0, 0) 
LangScroll.BackgroundColor3 = ColorMain
LangScroll.BackgroundTransparency = 0.15
LangScroll.ScrollBarThickness = 3
LangScroll.Visible = false
LangScroll.ClipsDescendants = true 
LangScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LangScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
LangScroll.ScrollingDirection = Enum.ScrollingDirection.Y 
LangScroll.ElasticBehavior = Enum.ElasticBehavior.Never

Instance.new("UICorner", LangScroll).CornerRadius = UDim.new(0, 8)

local LLayout = Instance.new("UIListLayout", LangScroll)
LLayout.Padding = UDim.new(0, 2)

-- LOGIKA BUKA TUTUP DROPDOWN & AUTO-SCROLL MANJA
local langOpen = false
LangDropBtn.MouseButton1Click:Connect(function()
    langOpen = not langOpen
    if langOpen then
        LangScroll.Visible = true        
        local selectedIndex = 1
        for i, l in ipairs(LangList) do
            if l == ActiveLanguage then selectedIndex = i; break end
        end
        
        -- KARENA SEKARANG ITEMNYA GEDE (65px), KITA KALIIN 65!
        LangScroll.CanvasPosition = Vector2.new(0, (selectedIndex - 1) * 65)
        Tween(LangScroll, {Size = UDim2.new(1, -4, 0, 205)}, 0.35) -- TINGGI 205 BIAR PAS 3 ITEM LEGA!
    else
        Tween(LangScroll, {Size = UDim2.new(1, -4, 0, 0)}, 0.35).Completed:Connect(function()
            if not langOpen then LangScroll.Visible = false end
        end)
    end
    Tween(PtrImg2, {Rotation = langOpen and -180 or 0}, 0.35)
end)

local function UpdateLanguageSystem(lang)
    ActiveLanguage = lang
    local useUniversal = (lang == "\u{4e2d}\u{6587} (Zh\u{014d}ngwén)" or lang == "\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)" or lang == "\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)" or lang == "\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})")
    
    for _, item in pairs(TranslationElements) do
        if item.Element and item.Element.Parent then
            item.Element[item.Property] = GetText(item.Key)
            if item.Property == "Text" then
                item.Element.Font = useUniversal and FontUniversal or FontMain
            end
        end
    end
end

-- KUMPULAN DESKRIPSI PREMIUM UNTUK TIAP BAHASA (TEGAS & MUDAH DIPAHAMI)
local LangDescs = {
    ["Indonesia (Default)"] = "Gunakan bahasa Indonesia untuk antarmuka. Semua fitur dan instruksi akan diterjemahkan dengan sangat akurat dan tegas.",
    ["English"] = "Set the interface to English. All features and instructions will be translated for a seamless and premium experience.",
    ["Português"] = "Defina a interface para Português. Todos os recursos e instruções serão traduzidos para uma experiência premium e clara.",
    ["\u{4e2d}\u{6587} (Zh\u{014d}ngwén)"] = "将界面设置为中文。所有功能和说明都将被翻译，为您提供无缝、优质且非常清晰的体验。",
    ["Español"] = "Configura la interfaz en Español. Todas las funciones e instrucciones se traducirán para una experiencia fluida y muy premium.",
    ["\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)"] = "قم بتعيين الواجهة إلى اللغة العربية. سيتم ترجمة جميع الميزات والتعليمات لتجربة سلسة وواضحة جدا وحازمة.",
    ["Français"] = "Définissez l'interface en Français. Toutes les fonctionnalités et instructions seront traduites de manière précise et élégante.",
    ["\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)"] = "Установите русский язык. Все функции и инструкции будут переведены для обеспечения бесперебойной и понятной работы.",
    ["\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})"] = "इंटरफ़ेस को हिंदी में सेट करें। एक सहज और प्रीमियम अनुभव के लिए सभी सुविधाओं और निर्देशों का अनुवाद किया जाएगा।",
    ["Deutsch"] = "Stelle die Benutzeroberfläche auf Deutsch ein. Alle Funktionen und Anweisungen werden für ein nahtloses Erlebnis übersetzt."
}

for _, lang in ipairs(LangList) do
    local bContainer = Instance.new("Frame", LangScroll)
    bContainer.Size = UDim2.new(1, 0, 0, 65) -- TINGGI LEGA PREMIUM (SAMA KAYAK FITUR!)
    bContainer.BackgroundTransparency = 1
    
    local b = Instance.new("TextButton", bContainer)
    b.Size = UDim2.new(1, -12, 1, -4) 
    b.Position = UDim2.new(0, 6, 0, 2)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 25) 
    b.BackgroundTransparency = 0.7 -- MUTLAK LEBIH TRANSPARAN BIAR PREMIUM STYLE
    b.Text = ""
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8) -- TUMPUL MANJA
    
    b.MouseEnter:Connect(function() Tween(b, {BackgroundColor3 = ColorToggleOff, BackgroundTransparency = 0.3}, 0.25) end)
    b.MouseLeave:Connect(function() Tween(b, {BackgroundColor3 = Color3.fromRGB(20, 20, 25), BackgroundTransparency = 0.7}, 0.25) end)  
    
    local flagIcon = Instance.new("ImageLabel", b)
    flagIcon.Size = UDim2.new(0, 24, 0, 24) -- SEUKURAN ICON FITUR!
    flagIcon.AnchorPoint = Vector2.new(0, 0.5)
    flagIcon.Position = UDim2.new(0, 12, 0.5, 0) 
    flagIcon.BackgroundTransparency = 1
    flagIcon.Image = "rbxthumb://type=Asset&id=" .. LangFlags[lang] .. "&w=150&h=150"
    flagIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)    
    
    local lTitle = Instance.new("TextLabel", b)
    lTitle.Size = UDim2.new(1, -54, 0, 16)
    lTitle.Position = UDim2.new(0, 48, 0, 8) -- RAPIH MUTLAK, GA NABRAK BENDERA!
    lTitle.BackgroundTransparency = 1
    lTitle.TextColor3 = ColorText
    lTitle.Font = (lang == "\u{4e2d}\u{6587} (Zh\u{014d}ngwén)" or lang == "\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)" or lang == "\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)" or lang == "\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})") and FontUniversal or FontMain
    lTitle.TextSize = 12
    lTitle.TextXAlignment = Enum.TextXAlignment.Left
    lTitle.Text = lang

    local lDesc = Instance.new("TextLabel", b)
    lDesc.Size = UDim2.new(1, -54, 0, 40)
    lDesc.Position = UDim2.new(0, 48, 0, 24) -- PAS DITENGAH KEK FITUR ASLI!
    lDesc.BackgroundTransparency = 1
    lDesc.TextColor3 = ColorDesc
    lDesc.Font = FontDesc
    lDesc.TextSize = 10
    lDesc.TextXAlignment = Enum.TextXAlignment.Left
    lDesc.TextYAlignment = Enum.TextYAlignment.Top
    lDesc.TextWrapped = true
    lDesc.Text = LangDescs[lang] -- DESKRIPSI SPESIFIK BAHASA!
    
    b.MouseButton1Click:Connect(function()
        langOpen = false
        Tween(LangScroll, {Size = UDim2.new(1, -4, 0, 0)}, 0.35).Completed:Connect(function()
            if not langOpen then LangScroll.Visible = false end
        end)
        Tween(PtrImg2, {Rotation = 0}, 0.35) 
        
        LangLbl.Text = "Bahasa: " .. lang        
        
        local iconTween = Tween(LangImg, {ImageTransparency = 1}, 0.15)
        Tween(LangShine, {ImageTransparency = 1}, 0.15) 
        iconTween.Completed:Connect(function()
            local newThumb = "rbxthumb://type=Asset&id=" .. LangFlags[lang] .. "&w=150&h=150"
            LangImg.Image = newThumb
            LangShine.Image = newThumb 
            Tween(LangImg, {ImageTransparency = 0}, 0.15)
            Tween(LangShine, {ImageTransparency = 0}, 0.15)
        end)
        
        UpdateLanguageSystem(lang)
    end)    
end
