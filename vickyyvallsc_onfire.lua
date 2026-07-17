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

-- ЁЯФе BYPASS TINGKAT DEWA: Cari tempat paling aman buat nempel GUI!
local TargetGui
local success, result = pcall(function() return gethui() end)
if success and result then
    TargetGui = result
else
    -- Kalau gethui gagal, otomatis ngumpet di PlayerGui (1000% AMAN)
    TargetGui = LocalPlayer:WaitForChild("PlayerGui")
end

-- Hapus GUI lama kalo udah ada di TargetGui yang bener
if TargetGui:FindFirstChild(HubName) then TargetGui[HubName]:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = HubName
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.IgnoreGuiInset = true
-- ЁЯФе MASUK JALUR AMAN BOSQU!
ScreenGui.Parent = TargetGui 

local FontTitle = Enum.Font.GothamBold
local FontMain = Enum.Font.GothamBold
local FontDesc = Enum.Font.GothamMedium
local FontESP = Enum.Font.GothamBold
local FontUniversal = Enum.Font.SourceSansBold 

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
    ["Char_Title"] = {ID = "Karakter", EN = "Character", PT = "Personagem", ZH = "шзТшЙ▓", ES = "Personaje", AR = "╪┤╪о╪╡┘К╪й", FR = "Personnage", RU = "╨Я╨╡╤А╤Б╨╛╨╜╨░╨╢", HI = "рдЪрд░рд┐рддреНрд░", DE = "Charakter"},
    ["Vis_Title"] = {ID = "Visual", EN = "Visual", PT = "Visual", ZH = "шзЖшзЙ", ES = "Visual", AR = "╪и╪╡╪▒┘К", FR = "Visuel", RU = "╨Т╨╕╨╖╤Г╨░╨╗", HI = "рджреГрд╢реНрдп", DE = "Visuell"},
    ["World_Title"] = {ID = "Dunia", EN = "World", PT = "Mundo", ZH = "ф╕ЦчХМ", ES = "Mundo", AR = "╪╣╪з┘Д┘Е", FR = "Monde", RU = "╨Ь╨╕╤А", HI = "рд╡рд┐рд╢реНрд╡", DE = "Welt"},
    ["Sys_Title"] = {ID = "Info & Sistem", EN = "Info & System", PT = "Informa├з├гo", ZH = "ф┐бцБпф╕Оч│╗ч╗Я", ES = "Informaci├│n", AR = "╪з┘Д┘Ж╪╕╪з┘Е", FR = "Info & Syst├иme", RU = "╨б╨╕╤Б╤В╨╡╨╝╨░", HI = "рд╕рд┐рд╕реНрдЯрдо", DE = "Info & System"},
    
    ["Reset_T"] = {ID = "Respawn", EN = "Respawn", PT = "Renascer", ZH = "щЗНч╜о", ES = "Reaparecer", AR = "╪е╪╣╪з╪п╪й ╪к╪╣┘К┘К┘Ж", FR = "R├йappara├оtre", RU = "╨а╨╡╤Б╨┐╨░╨▓╨╜", HI = "рдкреБрдирд░реНрдЬрдиреНрдо", DE = "Wiederbelebung"},
    ["Reset_D"] = {
        ID = "Hancurkan karaktermu untuk hidup kembali di titik awal! Sangat seru dan berguna jika kamu tersesat atau butuh darah penuh seketika.",
        EN = "Destroy your character to respawn at the start! Very fun and useful if you are lost or need full health instantly.",
        PT = "Destrua seu personagem para renascer no in├нcio! Muito divertido e ├║til se voc├к se perder ou precisar de sa├║de instant├вnea.",
        ZH = "цСзцпБф╜ачЪДшзТшЙ▓х╣╢хЬиш╡╖чВ╣щЗНчФЯя╝БхжВцЮЬф╜аш┐╖ш╖пцИЦщЬАшжБчлЛхИ╗цБвхдНц╗бшбАя╝Мш┐ЩщЭЮх╕╕цЬЙш╢гф╕ФцЬЙчФиуАВ",
        ES = "┬бDestruye tu personaje para reaparecer al principio! Muy divertido y ├║til si te pierdes o necesitas salud al instante.",
        AR = "╪п┘Е╪▒ ╪┤╪о╪╡┘К╪к┘Г ┘Д╪к┘И┘Д╪п ┘Е┘Ж ╪м╪п┘К╪п ┘Б┘К ╪з┘Д╪и╪п╪з┘К╪й! ┘Е┘Е╪к╪╣ ┘И┘Е┘Б┘К╪п ╪м╪п╪з ╪е╪░╪з ╪╢┘Д┘Д╪к ╪╖╪▒┘К┘В┘Г ╪г┘И ╪з╪н╪к╪м╪к ┘Д╪╡╪н╪й ┘Г╪з┘Е┘Д╪й.",
        FR = "D├йtruis ton personnage pour r├йappara├оtre au d├йbut ! Tr├иs amusant et utile si tu es perdu ou as besoin de sant├й.",
        RU = "╨г╨╜╨╕╤З╤В╨╛╨╢╤М╤В╨╡ ╨┐╨╡╤А╤Б╨╛╨╜╨░╨╢╨░, ╤З╤В╨╛╨▒╤Л ╨▓╨╛╨╖╤А╨╛╨┤╨╕╤В╤М╤Б╤П! ╨Ю╤З╨╡╨╜╤М ╨▓╨╡╤Б╨╡╨╗╨╛ ╨╕ ╨┐╨╛╨╗╨╡╨╖╨╜╨╛, ╨╡╤Б╨╗╨╕ ╨▓╤Л ╨╖╨░╨▒╨╗╤Г╨┤╨╕╨╗╨╕╤Б╤М ╨╕╨╗╨╕ ╨╜╤Г╨╢╨╜╨╛ ╨┐╨╛╨╗╨╜╨╛╨╡ ╨╖╨┤╨╛╤А╨╛╨▓╤М╨╡.",
        HI = "рд╢реБрд░реБрдЖрдд рдореЗрдВ рдлрд┐рд░ рд╕реЗ рдЬрдиреНрдо рд▓реЗрдиреЗ рдХреЗ рд▓рд┐рдП рдЕрдкрдиреЗ рдЪрд░рд┐рддреНрд░ рдХреЛ рдирд╖реНрдЯ рдХрд░реЗрдВ! рдпрджрд┐ рдЖрдк рдЦреЛ рдЧрдП рд╣реИрдВ рддреЛ рдмрд╣реБрдд рдордЬреЗрджрд╛рд░ рдФрд░ рдЙрдкрдпреЛрдЧреА рд╣реИред",
        DE = "Zerst├╢re deinen Charakter, um am Start neu zu spawnen! Sehr lustig und n├╝tzlich, wenn du dich verirrst."
    },
    
    ["Rejoin_T"] = {ID = "Rejoin", EN = "Rejoin", PT = "Reentrar", ZH = "щЗНцЦ░хКахЕе", ES = "Reunirse", AR = "╪е╪╣╪з╪п╪й ╪з┘Д╪з┘Ж╪╢┘Е╪з┘Е", FR = "Rejoindre", RU = "╨Я╨╡╤А╨╡╨╖╨░╨╣╤В╨╕", HI = "рдлрд┐рд░ рд╕реЗ рдЬреБрдбрд╝реЗрдВ", DE = "Erneut beitreten"},
    ["Rejoin_D"] = {
        ID = "Keluar sebentar dan masuk lagi ke server yang sama bagaikan kilat! Cocok banget untuk menyegarkan game kamu yang sedang lag.",
        EN = "Leave briefly and rejoin the same server like lightning! Perfect for refreshing your game if it's lagging.",
        PT = "Saia brevemente e volte ao mesmo servidor como um raio! Perfeito para atualizar seu jogo se estiver travando.",
        ZH = "чЯнцЪВчж╗х╝Ах╣╢щЧкчФ╡шИмщЗНцЦ░хКахЕехРМф╕Аф╕кцЬНхКбхЩия╝БхжВцЮЬц╕╕цИПхНбщб┐я╝Мш┐ЩцШпхИ╖цЦ░ц╕╕цИПчЪДхоМч╛ОщАЙцЛйуАВ",
        ES = "┬бSal brevemente y vuelve al mismo servidor como un rayo! Perfecto para refrescar tu juego si hay lag.",
        AR = "╪з╪о╪▒╪м ┘Д┘Б╪к╪▒╪й ┘И╪м┘К╪▓╪й ┘И╪╣╪п ╪е┘Д┘Й ┘Ж┘Б╪│ ╪з┘Д╪о╪з╪п┘Е ┘Е╪л┘Д ╪з┘Д╪и╪▒┘В! ┘Е╪л╪з┘Д┘К ┘Д╪к╪н╪п┘К╪л ┘Д╪╣╪и╪к┘Г ╪е╪░╪з ┘Г╪з┘Ж╪к ╪и╪╖┘К╪ж╪й.",
        FR = "Quittez bri├иvement et rejoignez le m├кme serveur comme l'├йclair ! Parfait pour rafra├оchir un jeu qui lag.",
        RU = "╨Э╨╡╨╜╨░╨┤╨╛╨╗╨│╨╛ ╨▓╤Л╨╣╨┤╨╕╤В╨╡ ╨╕ ╨╝╨╛╨╗╨╜╨╕╨╡╨╜╨╛╤Б╨╜╨╛ ╨▓╨╡╤А╨╜╨╕╤В╨╡╤Б╤М ╨╜╨░ ╤В╨╛╤В ╨╢╨╡ ╤Б╨╡╤А╨▓╨╡╤А! ╨Ш╨┤╨╡╨░╨╗╤М╨╜╨╛ ╨┤╨╗╤П ╨╛╨▒╨╜╨╛╨▓╨╗╨╡╨╜╨╕╤П ╨╕╨│╤А╤Л ╨┐╤А╨╕ ╨╗╨░╨│╨░╤Е.",
        HI = "рдереЛрдбрд╝реА рджреЗрд░ рдХреЗ рд▓рд┐рдП рдЫреЛрдбрд╝реЗрдВ рдФрд░ рдЙрд╕реА рд╕рд░реНрд╡рд░ рдореЗрдВ рдмрд┐рдЬрд▓реА рдХреА рддрд░рд╣ рдлрд┐рд░ рд╕реЗ рдЬреБрдбрд╝реЗрдВ! рдЧреЗрдо рддрд╛рдЬрд╝рд╛ рдХрд░рдиреЗ рдХреЗ рд▓рд┐рдП рдПрдХрджрдо рд╕рд╣реА рд╣реИред",
        DE = "Verlasse das Spiel kurz und trete demselben Server wie ein Blitz wieder bei! Perfekt bei Lags."
    },
    
    ["Hop_T"] = {ID = "Server Hop", EN = "Server Hop", PT = "Pular Servidor", ZH = "хп╗цЙ╛цЦ░цЬНхКбхЩи", ES = "Salto de servidor", AR = "╪к╪║┘К┘К╪▒ ╪з┘Д╪о╪з╪п┘Е", FR = "Saut de serveur", RU = "╨б╨╝╨╡╨╜╨░ ╤Б╨╡╤А╨▓╨╡╤А╨░", HI = "рд╕рд░реНрд╡рд░ рдмрджрд▓реЗрдВ", DE = "Server-Hop"},
    ["Hop_D"] = {
        ID = "Jalan-jalan mencari server baru yang lebih seru! Sistem akan otomatis memindahkanmu untuk bertemu teman dan petualangan baru.",
        EN = "Take a trip to find a more exciting new server! The system will automatically move you to meet new friends.",
        PT = "Fa├зa uma viagem para encontrar um servidor mais emocionante! O sistema mover├б voc├к automaticamente.",
        ZH = "хО╗хп╗цЙ╛ф╕Аф╕кцЫ┤хИ║ц┐АчЪДцЦ░цЬНхКбхЩихРзя╝Бч│╗ч╗Яф╝ЪшЗкхКих░Жф╜аш╜мчз╗я╝МхО╗ч╗УшпЖцЦ░цЬЛхПЛхТМцЦ░хЖТщЩйуАВ",
        ES = "┬бHaz un viaje para encontrar un servidor m├бs emocionante! El sistema te mover├б autom├бticamente para conocer nuevos amigos.",
        AR = "┘В┘Е ╪и╪▒╪н┘Д╪й ┘Д┘Д╪╣╪л┘И╪▒ ╪╣┘Д┘Й ╪о╪з╪п┘Е ╪м╪п┘К╪п ╪г┘Г╪л╪▒ ╪е╪л╪з╪▒╪й! ╪│┘К┘Ж┘В┘Д┘Г ╪з┘Д┘Ж╪╕╪з┘Е ╪к┘Д┘В╪з╪ж┘К┘Л╪з ┘Д┘Е┘В╪з╪и┘Д╪й ╪г╪╡╪п┘В╪з╪б ╪м╪п╪п.",
        FR = "Partez ├а la recherche d'un nouveau serveur plus excitant ! Le syst├иme vous d├йplacera automatiquement.",
        RU = "╨Ю╤В╨┐╤А╨░╨▓╨╗╤П╨╣╤В╨╡╤Б╤М ╨╜╨░ ╨┐╨╛╨╕╤Б╨║╨╕ ╨▒╨╛╨╗╨╡╨╡ ╨╖╨░╤Е╨▓╨░╤В╤Л╨▓╨░╤О╤Й╨╡╨│╨╛ ╤Б╨╡╤А╨▓╨╡╤А╨░! ╨б╨╕╤Б╤В╨╡╨╝╨░ ╨░╨▓╤В╨╛╨╝╨░╤В╨╕╤З╨╡╤Б╨║╨╕ ╨┐╨╡╤А╨╡╨╝╨╡╤Б╤В╨╕╤В ╨▓╨░╤Б ╨║ ╨╜╨╛╨▓╤Л╨╝ ╨┤╤А╤Г╨╖╤М╤П╨╝.",
        HI = "рдЕрдзрд┐рдХ рд░реЛрдорд╛рдВрдЪрдХ рд╕рд░реНрд╡рд░ рдЦреЛрдЬрдиреЗ рдХреЗ рд▓рд┐рдП рдпрд╛рддреНрд░рд╛ рдХрд░реЗрдВ! рд╕рд┐рд╕реНрдЯрдо рд╕реНрд╡рдЪрд╛рд▓рд┐рдд рд░реВрдк рд╕реЗ рдЖрдкрдХреЛ рдирдП рджреЛрд╕реНрддреЛрдВ рд╕реЗ рдорд┐рд▓рдиреЗ рдХреЗ рд▓рд┐рдП рд▓реЗ рдЬрд╛рдПрдЧрд╛ред",
        DE = "Mach dich auf die Suche nach einem aufregenderen Server! Das System verschiebt dich automatisch."
    },
    
    ["Speed_T"] = {ID = "Run Speed", EN = "Run Speed", PT = "Velocidade", ZH = "чз╗хКищАЯх║ж", ES = "Velocidad", AR = "╪з┘Д╪│╪▒╪╣╪й", FR = "Vitesse", RU = "╨б╨║╨╛╤А╨╛╤Б╤В╤М ╨▒╨╡╨│╨░", HI = "рдЧрддрд┐", DE = "Laufgeschwindigkeit"},
    ["Speed_D"] = {
        ID = "Berlari secepat pahlawan super! Jelajahi seluruh dunia dengan kecepatan kilat tanpa takut tertinggal oleh teman-temanmu.",
        EN = "Run as fast as a superhero! Explore the whole world at lightning speed without fear of being left behind.",
        PT = "Corra t├гo r├бpido quanto um super-her├│i! Explore o mundo inteiro na velocidade da luz.",
        ZH = "хГПш╢Еч║зшЛ▒щЫДф╕Аца╖хеФш╖Ся╝Бф╗ещЧкчФ╡шИмчЪДщАЯх║жцОвч┤вцХ┤ф╕кф╕ЦчХМя╝Мф╕НцАХшвлцЬЛхПЛцКЫхЬихРОщЭвуАВ",
        ES = "┬бCorre tan r├бpido como un superh├йroe! Explora el mundo a la velocidad del rayo sin miedo a quedarte atr├бs.",
        AR = "╪з╪▒┘Г╪╢ ╪и╪│╪▒╪╣╪й ╪и╪╖┘Д ╪о╪з╪▒┘В! ╪з╪│╪к┘Г╪┤┘Б ╪з┘Д╪╣╪з┘Д┘Е ┘Г┘Д┘З ╪и╪│╪▒╪╣╪й ╪з┘Д╪и╪▒┘В ╪п┘И┘Ж ╪о┘И┘Б ┘Е┘Ж ╪з┘Д╪к╪о┘Д┘Б ╪╣┘Ж ╪з┘Д╪▒┘Г╪и.",
        FR = "Courez aussi vite qu'un super-h├йros ! Explorez le monde ├а la vitesse de l'├йclair.",
        RU = "╨С╨╡╨│╨╕ ╤В╨░╨║ ╨╢╨╡ ╨▒╤Л╤Б╤В╤А╨╛, ╨║╨░╨║ ╤Б╤Г╨┐╨╡╤А╨│╨╡╤А╨╛╨╣! ╨Ш╤Б╤Б╨╗╨╡╨┤╤Г╨╣ ╨▓╨╡╤Б╤М ╨╝╨╕╤А ╤Б╨╛ ╤Б╨║╨╛╤А╨╛╤Б╤В╤М╤О ╨╝╨╛╨╗╨╜╨╕╨╕.",
        HI = "рдПрдХ рд╕реБрдкрд░рд╣реАрд░реЛ рдХреА рддрд░рд╣ рддреЗрдЬреА рд╕реЗ рджреМрдбрд╝реЗрдВ! рдкреАрдЫреЗ рдЫреВрдЯрдиреЗ рдХреЗ рдбрд░ рдХреЗ рдмрд┐рдирд╛ рдкреВрд░реА рджреБрдирд┐рдпрд╛ рдХрд╛ рдЕрдиреНрд╡реЗрд╖рдг рдХрд░реЗрдВред",
        DE = "Renne so schnell wie ein Superheld! Erkunde die ganze Welt in Blitzgeschwindigkeit."
    },
    
    ["Jump_T"] = {ID = "Jump Power", EN = "Jump Power", PT = "Pulo", ZH = "ш╖│ш╖ГщлШх║ж", ES = "Poder de salto", AR = "┘В┘И╪й ╪з┘Д┘В┘Б╪▓", FR = "Puissance de saut", RU = "╨б╨╕╨╗╨░ ╨┐╤А╤Л╨╢╨║╨░", HI = "рдЬрдВрдк рдкрд╛рд╡рд░", DE = "Sprungkraft"},
    ["Jump_D"] = {
        ID = "Lompat super tinggi seperti katak ajaib! Lewati gedung dan rintangan besar dengan sangat mudah dan menyenangkan.",
        EN = "Jump super high like a magic frog! Pass huge buildings and obstacles very easily and happily.",
        PT = "Pule super alto como um sapo m├бgico! Passe por pr├йdios e obst├бculos enormes com muita facilidade.",
        ZH = "хГПчеЮхеЗчЪДщЭТшЫЩф╕Аца╖ш╖│х╛Чш╢Еч║зщлШя╝БщЭЮх╕╕ш╜╗цЭ╛цДЙх┐лхЬ░ш╢Кш┐Зх╖ихдзчЪДх╗║чнСчЙйхТМщЪЬчвНчЙйуАВ",
        ES = "┬бSalta s├║per alto como una rana m├бgica! Pasa edificios y obst├бculos enormes muy f├бcilmente.",
        AR = "╪з┘В┘Б╪▓ ╪╣╪з┘Д┘К╪з ╪м╪п╪з ┘Е╪л┘Д ╪з┘Д╪╢┘Б╪п╪╣ ╪з┘Д╪│╪н╪▒┘К! ╪к╪м╪з┘И╪▓ ╪з┘Д┘Е╪и╪з┘Ж┘К ┘И╪з┘Д╪╣┘В╪и╪з╪к ╪з┘Д╪╢╪о┘Е╪й ╪и╪│┘З┘И┘Д╪й ╪┤╪п┘К╪п╪й ┘И╪│╪╣╪з╪п╪й.",
        FR = "Sautez tr├иs haut comme une grenouille magique ! D├йpassez les grands b├вtiments et les obstacles facilement.",
        RU = "╨Я╤А╤Л╨│╨░╨╣ ╤Б╤Г╨┐╨╡╤А ╨▓╤Л╤Б╨╛╨║╨╛, ╨║╨░╨║ ╨▓╨╛╨╗╤И╨╡╨▒╨╜╨░╤П ╨╗╤П╨│╤Г╤И╨║╨░! ╨Ы╨╡╨│╨║╨╛ ╨┐╤А╨╡╨╛╨┤╨╛╨╗╨╡╨▓╨░╨╣ ╨╛╨│╤А╨╛╨╝╨╜╤Л╨╡ ╨╖╨┤╨░╨╜╨╕╤П ╨╕ ╨┐╤А╨╡╨┐╤П╤В╤Б╤В╨▓╨╕╤П.",
        HI = "рдПрдХ рдЬрд╛рджреБрдИ рдореЗрдВрдврдХ рдХреА рддрд░рд╣ рд╕реБрдкрд░ рд╣рд╛рдИ рдЬрдВрдк рдХрд░реЗрдВ! рдмрдбрд╝реА рдЗрдорд╛рд░рддреЛрдВ рдФрд░ рдмрд╛рдзрд╛рдУрдВ рдХреЛ рдмрд╣реБрдд рдЖрд╕рд╛рдиреА рд╕реЗ рдкрд╛рд░ рдХрд░реЗрдВред",
        DE = "Spring super hoch wie ein magischer Frosch! ├Ьberwinde riesige Geb├дude und Hindernisse ganz einfach."
    },
    
    ["Inf_T"] = {ID = "Inf Jump", EN = "Inf Jump", PT = "Pulo Infinito", ZH = "цЧащЩРш╖│ш╖Г", ES = "Salto infinito", AR = "┘В┘Б╪▓ ╪║┘К╪▒ ┘Е╪н╪п┘И╪п", FR = "Saut infini", RU = "╨С╨╡╤Б╨║╨╛╨╜╨╡╤З╨╜╤Л╨╡ ╨┐╤А╤Л╨╢╨║╨╕", HI = "рдЕрдирдВрдд рдЬрдВрдк", DE = "Unendlicher Sprung"},
    ["Inf_D"] = {
        ID = "Terbang ke angkasa dengan melompat berkali-kali di udara! Rasakan keajaiban melayang tanpa harus menyentuh tanah.",
        EN = "Fly into the sky by jumping multiple times in the air! Feel the magic of floating without touching the ground.",
        PT = "Voe para o c├йu pulando v├бrias vezes no ar! Sinta a magia de flutuar sem tocar o ch├гo.",
        ZH = "хЬичй║ф╕нхдЪцмбш╖│ш╖ГщгЮхРСхдйчй║я╝БцДЯхПЧшДЪф╕Нц▓╛хЬ░ц╝Вц╡очЪДщнФхКЫуАВ",
        ES = "┬бVuela hacia el cielo saltando varias veces en el aire! Siente la magia de flotar sin tocar el suelo.",
        AR = "╪╖┘Р╪▒ ╪е┘Д┘Й ╪з┘Д╪│┘Е╪з╪б ╪и╪з┘Д┘В┘Б╪▓ ╪╣╪п╪й ┘Е╪▒╪з╪к ┘Б┘К ╪з┘Д┘З┘И╪з╪б! ╪з╪┤╪╣╪▒ ╪и╪│╪н╪▒ ╪з┘Д╪╖┘Б┘И ╪п┘И┘Ж ╪г┘Ж ╪к┘Д┘Е╪│ ╪з┘Д╪г╪▒╪╢.",
        FR = "Volez dans le ciel en sautant plusieurs fois en l'air ! Sentez la magia de flotter sans toucher le sol.",
        RU = "╨Ы╨╡╤В╨╕ ╨▓ ╨╜╨╡╨▒╨╛, ╨┐╤А╤Л╨│╨░╤П ╨▓ ╨▓╨╛╨╖╨┤╤Г╤Е╨╡ ╨╜╨╡╤Б╨║╨╛╨╗╤М╨║╨╛ ╤А╨░╨╖! ╨Я╨╛╤З╤Г╨▓╤Б╤В╨▓╤Г╨╣ ╨╝╨░╨│╨╕╤О ╨┐╨╛╨╗╨╡╤В╨░, ╨╜╨╡ ╨║╨░╤Б╨░╤П╤Б╤М ╨╖╨╡╨╝╨╗╨╕.",
        HI = "рд╣рд╡рд╛ рдореЗрдВ рдХрдИ рдмрд╛рд░ рдХреВрджрдХрд░ рдЖрд╕рдорд╛рди рдореЗрдВ рдЙрдбрд╝реЗрдВ! рдЬрдореАрди рдХреЛ рдЫреБрдП рдмрд┐рдирд╛ рддреИрд░рдиреЗ рдХреЗ рдЬрд╛рджреВ рдХреЛ рдорд╣рд╕реВрд╕ рдХрд░реЗрдВред",
        DE = "Fliege in den Himmel, indem du mehrmals in die Luft springst! Sp├╝re die Magie des Schwebens."
    },
    
    ["Noclip_T"] = {ID = "Noclip", EN = "Noclip", PT = "Noclip", ZH = "чй┐хвЩ", ES = "Atravesar", AR = "╪з╪о╪к╪▒╪з┘В ╪з┘Д╪м╪п╪▒╪з┘Ж", FR = "Passe-muraille", RU = "╨б╨║╨▓╨╛╨╖╤М ╤Б╤В╨╡╨╜╤Л", HI = "рджреАрд╡рд╛рд░ рдХреЗ рдкрд╛рд░", DE = "Durch W├дnde gehen"},
    ["Noclip_D"] = {
        ID = "Jadilah hantu sakti yang bisa menembus tembok tebal dan rintangan apapun! Jalan pintas terbaik untuk menjelajahi map.",
        EN = "Become a magic ghost that can pass through thick walls and any obstacles! The best shortcut to explore the map.",
        PT = "Torne-se um fantasma m├бgico que pode passar por paredes grossas! O melhor atalho para explorar o mapa.",
        ZH = "цИРф╕║ф╕Аф╕кхПпф╗ечй┐щАПхОЪхвЩхТМф╗╗ф╜ХщЪЬчвНчЙйчЪДчеЮхеЗх╣╜чБ╡я╝БцОвч┤вхЬ░хЫ╛чЪДцЬАф╜│цН╖х╛ДуАВ",
        ES = "┬бConvi├йrtete en un fantasma m├бgico que puede atravesar paredes gruesas! El mejor atajo para explorar el mapa.",
        AR = "┘Г┘Ж ╪┤╪и╪н┘Л╪з ╪│╪н╪▒┘К┘Л╪з ┘К┘Е┘Г┘Ж┘З ╪з┘Д┘Е╪▒┘И╪▒ ╪╣╪и╪▒ ╪з┘Д╪м╪п╪▒╪з┘Ж ╪з┘Д╪│┘Е┘К┘Г╪й! ╪г┘Б╪╢┘Д ╪╖╪▒┘К┘В ┘Е╪о╪к╪╡╪▒ ┘Д╪з╪│╪к┘Г╪┤╪з┘Б ╪з┘Д╪о╪▒┘К╪╖╪й.",
        FR = "Devenez un fant├┤me magique qui traverse les murs ├йpais ! Le meilleur raccourci pour explorer la carte.",
        RU = "╨б╤В╨░╨╜╤М╤В╨╡ ╨▓╨╛╨╗╤И╨╡╨▒╨╜╤Л╨╝ ╨┐╤А╨╕╨╖╤А╨░╨║╨╛╨╝, ╨┐╤А╨╛╤Е╨╛╨┤╤П╤Й╨╕╨╝ ╤Б╨║╨▓╨╛╨╖╤М ╤В╨╛╨╗╤Б╤В╤Л╨╡ ╤Б╤В╨╡╨╜╤Л! ╨Ы╤Г╤З╤И╨╕╨╣ ╨║╨╛╤А╨╛╤В╨║╨╕╨╣ ╨┐╤Г╤В╤М ╨┤╨╗╤П ╨╕╤Б╤Б╨╗╨╡╨┤╨╛╨▓╨░╨╜╨╕╤П ╨║╨░╤А╤В╤Л.",
        HI = "рдПрдХ рдЬрд╛рджреБрдИ рднреВрдд рдмрдиреЗрдВ рдЬреЛ рдореЛрдЯреА рджреАрд╡рд╛рд░реЛрдВ рдФрд░ рдХрд┐рд╕реА рднреА рдмрд╛рдзрд╛ рд╕реЗ рдЧреБрдЬрд░ рд╕рдХрддрд╛ рд╣реИ! рдирдХреНрд╢реЗ рдХрд╛ рдкрддрд╛ рд▓рдЧрд╛рдиреЗ рдХрд╛ рд╕рдмрд╕реЗ рдЕрдЪреНрдЫрд╛ рд╢реЙрд░реНрдЯрдХрдЯред",
        DE = "Werde zum magischen Geist, der durch dicke W├дnde gehen kann! Die beste Abk├╝rzung, um die Karte zu erkunden."
    },
    
    ["Fly_T"] = {ID = "Fly Mode", EN = "Fly Mode", PT = "Voar", ZH = "щгЮшбМцибх╝П", ES = "Volar", AR = "╪╖┘К╪▒╪з┘Ж", FR = "Voler", RU = "╨Я╨╛╨╗╨╡╤В", HI = "рдЙрдбрд╝рдирд╛", DE = "Fliegen"},
    ["Fly_D"] = {
        ID = "Terbang bebas seperti burung di langit! Bebas arahkan kameramu dan lihat indahnya seluruh dunia dari atas awan.",
        EN = "Fly freely like a bird in the sky! Point your camera freely and see the beauty of the world from above the clouds.",
        PT = "Voe livremente como um p├бssaro no c├йu! Aponte sua c├вmera e veja a beleza do mundo de cima.",
        ZH = "хГПхдйчй║ф╕нчЪДщ╕ЯхД┐ф╕Аца╖шЗкчФ▒щгЮч┐Фя╝БшЗкчФ▒ш╜мхКиф╜ачЪДчЫ╕цЬ║я╝Мф╗Оф║Счлпф┐пчЮ░ф╕ЦчХМчЪДч╛Оф╕╜уАВ",
        ES = "┬бVuela libremente como un p├бjaro en el cielo! Apunta tu c├бmara y mira la belleza del mundo desde arriba.",
        AR = "╪╖╪▒ ╪и╪н╪▒┘К╪й ┘Е╪л┘Д ╪╖╪з╪ж╪▒ ┘Б┘К ╪з┘Д╪│┘Е╪з╪б! ┘И╪м┘З ╪з┘Д┘Г╪з┘Е┘К╪▒╪з ╪и╪н╪▒┘К╪й ┘И╪┤╪з┘З╪п ╪м┘Е╪з┘Д ╪з┘Д╪╣╪з┘Д┘Е ┘Е┘Ж ┘Б┘И┘В ╪з┘Д╪│╪н╪з╪и.",
        FR = "Volez librement comme un oiseau dans le ciel ! Pointez votre cam├йra et admirez la beaut├й du monde.",
        RU = "╨Ы╨╡╤В╨░╨╣ ╤Б╨▓╨╛╨▒╨╛╨┤╨╜╨╛, ╨║╨░╨║ ╨┐╤В╨╕╤Ж╨░ ╨▓ ╨╜╨╡╨▒╨╡! ╨Э╨░╨┐╤А╨░╨▓╨╗╤П╨╣ ╨║╨░╨╝╨╡╤А╤Г ╨╕ ╤Б╨╝╨╛╤В╤А╨╕ ╨╜╨░ ╨║╤А╨░╤Б╨╛╤В╤Г ╨╝╨╕╤А╨░ ╨╕╨╖-╨╖╨░ ╨╛╨▒╨╗╨░╨║╨╛╨▓.",
        HI = "рдЖрд╕рдорд╛рди рдореЗрдВ рдПрдХ рдкрдХреНрд╖реА рдХреА рддрд░рд╣ рд╕реНрд╡рддрдВрддреНрд░ рд░реВрдк рд╕реЗ рдЙрдбрд╝реЗрдВ! рдЕрдкрдиреЗ рдХреИрдорд░реЗ рдХреЛ рдШреБрдорд╛рдПрдВ рдФрд░ рдмрд╛рджрд▓реЛрдВ рдХреЗ рдКрдкрд░ рд╕реЗ рджреБрдирд┐рдпрд╛ рдХреА рд╕реБрдВрджрд░рддрд╛ рджреЗрдЦреЗрдВред",
        DE = "Fliege frei wie ein Vogel im Himmel! Richte deine Kamera aus und sieh dir die Sch├╢nheit der Welt von oben an."
    },
    
    ["ESP_T"] = {ID = "Name ESP", EN = "Name ESP", PT = "ESP Nome", ZH = "хРНхнЧ ESP", ES = "ESP Nombre", AR = "┘Г╪з╪┤┘Б ╪з┘Д╪г╪│┘Е╪з╪б", FR = "Nom ESP", RU = "╨Т╨е ╨Ш╨╝╨╡╨╜╨░", HI = "рдирд╛рдо ESP", DE = "Name ESP"},
    ["ESP_D"] = {
        ID = "Mata-mata super! Lihat nama dan jarak semua pemain dari jauh, bahkan kalau mereka sedang ngumpet di balik dinding.",
        EN = "Super spy! See the names and distances of all players from afar, even if they are hiding behind walls.",
        PT = "Super espi├гo! Veja os nomes e dist├вncias de todos os jogadores, mesmo se eles estiverem escondidos.",
        ZH = "ш╢Еч║зщЧ┤ш░Ня╝Бф╗Ош┐ЬхдДчЬЛхИ░цЙАцЬЙчОйхо╢чЪДхРНхнЧхТМш╖Эчж╗я╝МхН│ф╜┐ф╗Цф╗мш║▓хЬихвЩхРОуАВ",
        ES = "┬бS├║per esp├нa! Mira los nombres y las distancias de todos los jugadores desde lejos, incluso si se esconden.",
        AR = "╪м╪з╪│┘И╪│ ╪о╪з╪▒┘В! ╪┤╪з┘З╪п ╪г╪│┘Е╪з╪б ┘И┘Е╪│╪з┘Б╪з╪к ╪м┘Е┘К╪╣ ╪з┘Д┘Д╪з╪╣╪и┘К┘Ж ┘Е┘Ж ╪и╪╣┘К╪п╪М ╪н╪к┘Й ┘Д┘И ┘Г╪з┘Ж┘И╪з ┘К╪о╪к╪и╪ж┘И┘Ж ╪о┘Д┘Б ╪з┘Д╪м╪п╪▒╪з┘Ж.",
        FR = "Super espion ! Voyez les noms et les distances de tous les joueurs de loin, m├кme s'ils se cachent.",
        RU = "╨б╤Г╨┐╨╡╤А╤И╨┐╨╕╨╛╨╜! ╨б╨╝╨╛╤В╤А╨╕ ╨╕╨╝╨╡╨╜╨░ ╨╕ ╤А╨░╤Б╤Б╤В╨╛╤П╨╜╨╕╤П ╨▓╤Б╨╡╤Е ╨╕╨│╤А╨╛╨║╨╛╨▓ ╨╕╨╖╨┤╨░╨╗╨╡╨║╨░, ╨┤╨░╨╢╨╡ ╨╡╤Б╨╗╨╕ ╨╛╨╜╨╕ ╨┐╤А╤П╤З╤Г╤В╤Б╤П ╨╖╨░ ╤Б╤В╨╡╨╜╨░╨╝╨╕.",
        HI = "рд╕реБрдкрд░ рдЬрд╛рд╕реВрд╕! рджреВрд░ рд╕реЗ рд╕рднреА рдЦрд┐рд▓рд╛рдбрд╝рд┐рдпреЛрдВ рдХреЗ рдирд╛рдо рдФрд░ рджреВрд░рд┐рдпрд╛рдВ рджреЗрдЦреЗрдВ, рднрд▓реЗ рд╣реА рд╡реЗ рджреАрд╡рд╛рд░реЛрдВ рдХреЗ рдкреАрдЫреЗ рдЫрд┐рдкреЗ рд╣реЛрдВред",
        DE = "Superspion! Sieh die Namen und Entfernungen aller Spieler von weitem, selbst wenn sie sich verstecken."
    },
    
    ["HP_T"] = {ID = "Health ESP", EN = "Health ESP", PT = "ESP Vida", ZH = "шбАщЗП ESP", ES = "ESP Salud", AR = "┘Г╪з╪┤┘Б ╪з┘Д╪╡╪н╪й", FR = "Sant├й ESP", RU = "╨Т╨е ╨Ч╨┤╨╛╤А╨╛╨▓╤М╨╡", HI = "рд╕реНрд╡рд╛рд╕реНрдереНрдп ESP", DE = "Gesundheit ESP"},
    ["HP_D"] = {
        ID = "Kacamata medis canggih! Ketahui sisa darah musuhmu dengan cepat. Sangat berguna untuk tahu siapa yang harus dikejar.",
        EN = "Advanced medical glasses! Know your enemy's remaining health quickly. Very useful to know who to chase.",
        PT = "├Уculos m├йdicos avan├зados! Saiba a sa├║de restante do seu inimigo rapidamente. Muito ├║til para saber quem perseguir.",
        ZH = "щлШч║зхМ╗чЦЧчЬ╝щХЬя╝Бх┐лщАЯф║ЖшзгцХМф║║чЪДхЙйф╜ЩчФЯхС╜хА╝уАВщЭЮх╕╕цЬЙчФия╝МчЯещБУшпеш┐╜ш░БуАВ",
        ES = "┬бGafas m├йdicas avanzadas! Conoce la salud restante de tu enemigo r├бpidamente. Muy ├║til para saber a qui├йn perseguir.",
        AR = "┘Ж╪╕╪з╪▒╪з╪к ╪╖╪и┘К╪й ┘Е╪к┘В╪п┘Е╪й! ╪к╪╣╪▒┘Б ╪╣┘Д┘Й ╪╡╪н╪й ╪╣╪п┘И┘Г ╪з┘Д┘Е╪к╪и┘В┘К╪й ╪и╪│╪▒╪╣╪й. ┘Е┘Б┘К╪п ╪м╪п╪з ┘Д┘Е╪╣╪▒┘Б╪й ┘Е┘Ж ┘К╪м╪и ┘Е╪╖╪з╪▒╪п╪к┘З.",
        FR = "Lunettes m├йdicales avanc├йes ! Connaissez rapidement la sant├й restante de vos ennemis. Tr├иs utile.",
        RU = "╨Я╨╡╤А╨╡╨┤╨╛╨▓╤Л╨╡ ╨╝╨╡╨┤╨╕╤Ж╨╕╨╜╤Б╨║╨╕╨╡ ╨╛╤З╨║╨╕! ╨С╤Л╤Б╤В╤А╨╛ ╤Г╨╖╨╜╨░╨╣ ╨╛╤Б╤В╨░╨▓╤И╨╡╨╡╤Б╤П ╨╖╨┤╨╛╤А╨╛╨▓╤М╨╡ ╨▓╤А╨░╨│╨░. ╨Ю╤З╨╡╨╜╤М ╨┐╨╛╨╗╨╡╨╖╨╜╨╛ ╨╖╨╜╨░╤В╤М, ╨╖╨░ ╨║╨╡╨╝ ╨│╨╜╨░╤В╤М╤Б╤П.",
        HI = "рдЙрдиреНрдирдд рдЪрд┐рдХрд┐рддреНрд╕рд╛ рдЪрд╢реНрдорд╛! рдЕрдкрдиреЗ рджреБрд╢реНрдорди рдХреЗ рд╢реЗрд╖ рд╕реНрд╡рд╛рд╕реНрдереНрдп рдХреЛ рдЬрд▓реНрджреА рд╕реЗ рдЬрд╛рдиреЗрдВред рдпрд╣ рдЬрд╛рдирдирд╛ рдмрд╣реБрдд рдЙрдкрдпреЛрдЧреА рд╣реИ рдХрд┐ рдХрд┐рд╕рдХрд╛ рдкреАрдЫрд╛ рдХрд░рдирд╛ рд╣реИред",
        DE = "Erweiterte medizinische Brille! Erkenne schnell die verbleibende Gesundheit deines Feindes. Sehr n├╝tzlich."
    },
    
    ["Box_T"] = {ID = "Box ESP", EN = "Box ESP", PT = "ESP Caixa", ZH = "цЦ╣цбЖ ESP", ES = "ESP Caja", AR = "┘Г╪з╪┤┘Б ╪з┘Д╪╡┘Ж╪з╪п┘К┘В", FR = "Bo├оte ESP", RU = "╨Т╨е ╨С╨╛╨║╤Б╤Л", HI = "рдмреЙрдХреНрд╕ ESP", DE = "Box ESP"},
    ["Box_D"] = {
        ID = "Kurung musuh dalam kotak cahaya ajaib! Kamu tidak akan pernah kehilangan jejak mereka meski dari jarak jauh sekalipun.",
        EN = "Enclose enemies in a magic light box! You will never lose track of them even from a very long distance.",
        PT = "Cerque inimigos em uma caixa de luz m├бgica! Voc├к nunca os perder├б de vista, mesmo de longe.",
        ZH = "х░ЖцХМф║║хЕ│хЬичеЮхеЗчЪДчБпчо▒ф╕ня╝БхН│ф╜┐хЬих╛Иш┐ЬчЪДш╖Эчж╗я╝Мф╜аф╣Яц░╕ш┐Ьф╕Нф╝Ъхд▒хО╗ф╗Цф╗мчЪДш╕кш┐╣уАВ",
        ES = "┬бEnierra a los enemigos en una caja de luz m├бgica! Nunca les perder├бs el rastro, incluso desde muy lejos.",
        AR = "┘В┘Е ╪и╪н╪и╪│ ╪з┘Д╪г╪╣╪п╪з╪б ┘Б┘К ╪╡┘Ж╪п┘И┘В ╪е╪╢╪з╪б╪й ╪│╪н╪▒┘К! ┘Д┘Ж ╪к┘Б┘В╪п ╪г╪л╪▒┘З┘Е ╪г╪и╪п╪з ╪н╪к┘Й ┘Е┘Ж ┘Е╪│╪з┘Б╪й ╪и╪╣┘К╪п╪й ╪м╪п╪з.",
        FR = "Enfermez les ennemis dans une bo├оte lumineuse magique ! Vous ne perdrez jamais leur trace.",
        RU = "╨Я╨╛╨╝╨╡╤Б╤В╨╕ ╨▓╤А╨░╨│╨╛╨▓ ╨▓ ╨▓╨╛╨╗╤И╨╡╨▒╨╜╤Г╤О ╤Б╨▓╨╡╤В╨╛╨▓╤Г╤О ╨║╨╛╤А╨╛╨▒╨║╤Г! ╨в╤Л ╨╜╨╕╨║╨╛╨│╨┤╨░ ╨╜╨╡ ╨┐╨╛╤В╨╡╤А╤П╨╡╤И╤М ╨╕╤Е ╨╕╨╖ ╨▓╨╕╨┤╤Г ╨┤╨░╨╢╨╡ ╨╕╨╖╨┤╨░╨╗╨╡╨║╨░.",
        HI = "рджреБрд╢реНрдордиреЛрдВ рдХреЛ рдПрдХ рдЬрд╛рджреБрдИ рдкреНрд░рдХрд╛рд╢ рдмреЙрдХреНрд╕ рдореЗрдВ рдмрдВрдж рдХрд░реЗрдВ! рдЖрдк рдХрднреА рднреА рдЙрдирдХрд╛ рдЯреНрд░реИрдХ рдирд╣реАрдВ рдЦреЛрдПрдВрдЧреЗ, рдпрд╣рд╛рдВ рддрдХ рдХрд┐ рдмрд╣реБрдд рджреВрд░ рд╕реЗ рднреАред",
        DE = "Sperre Feinde in eine magische Lichtbox ein! Du wirst sie auch aus gro├Яer Entfernung nie aus den Augen verlieren."
    },

    ["Map_NotFound"] = {ID = "Tidak Ditemukan", EN = "Not Found", PT = "N├гo Encontrado", ZH = "цЬкцЙ╛хИ░", ES = "No Encontrado", AR = "╪║┘К╪▒ ┘Е┘И╪м┘И╪п", FR = "Introuvable", RU = "╨Э╨╡ ╨╜╨░╨╣╨┤╨╡╨╜╨╛", HI = "рдирд╣реАрдВ рдорд┐рд▓рд╛", DE = "Nicht gefunden"},        
    
    ["Day_T"] = {ID = "Daylight", EN = "Daylight", PT = "Dia", ZH = "чЩ╜цШ╝цибх╝П", ES = "D├нa", AR = "┘Ж┘З╪з╪▒ ╪п╪з╪ж┘Е", FR = "Jour", RU = "╨Т╨╡╤З╨╜╤Л╨╣ ╨┤╨╡╨╜╤М", HI = "рджрд┐рди рдХрд╛ рд╕рдордп", DE = "Tageslicht"},
    ["Day_D"] = {
        ID = "Sulap malam yang gelap gulita menjadi siang yang cerah abadi! Main jadi lebih asyik karena kamu bisa melihat semuanya.",
        EN = "Turn the pitch-black night into an eternal bright day! Playing is more fun because you can see everything.",
        PT = "Transforme a noite escura em um dia claro e eterno! Brincar ├й mais divertido porque voc├к pode ver tudo.",
        ZH = "х░Жц╝Жщ╗СчЪДхдЬцЩЪхПШцИРц░╕цБТчЪДцШОф║очЩ╜хдйя╝Бц╕╕цИПцЫ┤цЬЙш╢гя╝МхЫаф╕║ф╜ахПпф╗ечЬЛхИ░ф╕АхИЗуАВ",
        ES = "┬бConvierte la noche oscura en un d├нa brillante y eterno! Jugar es m├бs divertido porque puedes ver todo.",
        AR = "╪н┘И┘Д ╪з┘Д┘Д┘К┘Д ╪з┘Д┘Е╪╕┘Д┘Е ╪е┘Д┘Й ┘Ж┘З╪з╪▒ ┘Е╪┤╪▒┘В ╪г╪и╪п┘К! ╪з┘Д┘Д╪╣╪и ╪г┘Г╪л╪▒ ┘Е╪к╪╣╪й ┘Д╪г┘Ж┘Г ╪к╪│╪к╪╖┘К╪╣ ╪▒╪д┘К╪й ┘Г┘Д ╪┤┘К╪б.",
        FR = "Transformez la nuit noire en un jour ├йternellement lumineux ! Jouer est plus amusant car vous voyez tout.",
        RU = "╨Я╤А╨╡╨▓╤А╨░╤В╨╕ ╨║╤А╨╛╨╝╨╡╤И╨╜╤Г╤О ╨╜╨╛╤З╤М ╨▓ ╨▓╨╡╤З╨╜╤Л╨╣ ╤П╤А╨║╨╕╨╣ ╨┤╨╡╨╜╤М! ╨Ш╨│╤А╨░╤В╤М ╨▓╨╡╤Б╨╡╨╗╨╡╨╡, ╨┐╨╛╤В╨╛╨╝╤Г ╤З╤В╨╛ ╤В╤Л ╨▓╤Б╨╡ ╨▓╨╕╨┤╨╕╤И╤М.",
        HI = "рдШрдиреА рдЕрдВрдзреЗрд░реА рд░рд╛рдд рдХреЛ рдПрдХ рдЕрдирдиреНрдд рдЙрдЬреНрдЬреНрд╡рд▓ рджрд┐рди рдореЗрдВ рдмрджрд▓ рджреЗрдВ! рдЦреЗрд▓рдирд╛ рдЕрдзрд┐рдХ рдордЬреЗрджрд╛рд░ рд╣реИ рдХреНрдпреЛрдВрдХрд┐ рдЖрдк рд╕рдм рдХреБрдЫ рджреЗрдЦ рд╕рдХрддреЗ рд╣реИрдВред",
        DE = "Verwandle die pechschwarze Nacht in einen ewigen, hellen Tag! Das Spielen macht mehr Spa├Я."
    },
    
    ["Glow_T"] = {ID = "Fullbright", EN = "Fullbright", PT = "Brilho Total", ZH = "хЕиф║оцибх╝П", ES = "Brillo Total", AR = "╪│╪╖┘И╪╣ ┘Г╪з┘Е┘Д", FR = "Luminosit├й", RU = "╨п╤А╨║╨╛╤Б╤В╤М", HI = "рдлреБрд▓рдмреНрд░рд╛рдЗрдЯ", DE = "Volle Helligkeit"},
    ["Glow_D"] = {
        ID = "Nyalakan lampu ke seluruh penjuru dunia! Hapus semua bayangan seram agar setiap gua dan ruangan jadi terang benderang.",
        EN = "Turn on the lights all over the world! Remove all scary shadows so every cave and room becomes bright.",
        PT = "Acenda as luzes de todo o mundo! Remova todas as sombras assustadoras para que cada caverna fique iluminada.",
        ZH = "цЙУх╝АхЕиф╕ЦчХМчЪДчБпя╝Бц╢ИщЩдцЙАцЬЙхПпцАХчЪДщШ┤х╜▒я╝МшойцпПф╕кц┤Ючй┤хТМцИ┐щЧ┤щГ╜хПШх╛ЧцШОф║оуАВ",
        ES = "┬бEnciende las luces en todo el mundo! Elimina las sombras aterradoras para que cada cueva y habitaci├│n brille.",
        AR = "╪┤╪║┘Д ╪з┘Д╪г╪╢┘И╪з╪б ┘Б┘К ╪м┘Е┘К╪╣ ╪г┘Ж╪н╪з╪б ╪з┘Д╪╣╪з┘Д┘Е! ┘В┘Е ╪и╪е╪▓╪з┘Д╪й ╪м┘Е┘К╪╣ ╪з┘Д╪╕┘Д╪з┘Д ╪з┘Д┘Е╪о┘К┘Б╪й ╪н╪к┘Й ┘К╪╡╪и╪н ┘Г┘Д ┘Г┘З┘Б ┘И╪║╪▒┘Б╪й ┘Е╪┤╪▒┘В╪з.",
        FR = "Allumez les lumi├иres partout ! Supprimez toutes les ombres effrayantes pour que chaque grotte soit lumineuse.",
        RU = "╨Т╨║╨╗╤О╤З╨╕ ╤Б╨▓╨╡╤В ╨┐╨╛ ╨▓╤Б╨╡╨╝╤Г ╨╝╨╕╤А╤Г! ╨г╨▒╨╡╤А╨╕ ╨▓╤Б╨╡ ╤Б╤В╤А╨░╤И╨╜╤Л╨╡ ╤В╨╡╨╜╨╕, ╤З╤В╨╛╨▒╤Л ╨║╨░╨╢╨┤╨░╤П ╨┐╨╡╤Й╨╡╤А╨░ ╨╕ ╨║╨╛╨╝╨╜╨░╤В╨░ ╤Б╤В╨░╨╗╨╕ ╤Б╨▓╨╡╤В╨╗╤Л╨╝╨╕.",
        HI = "рдкреВрд░реА рджреБрдирд┐рдпрд╛ рдореЗрдВ рд░реЛрд╢рдиреА рдЪрд╛рд▓реВ рдХрд░реЗрдВ! рд╕рднреА рдбрд░рд╛рд╡рдиреА рдкрд░рдЫрд╛рдЗрдпреЛрдВ рдХреЛ рд╣рдЯрд╛ рджреЗрдВ рддрд╛рдХрд┐ рд╣рд░ рдЧреБрдлрд╛ рдФрд░ рдХрдорд░рд╛ рдЙрдЬреНрдЬреНрд╡рд▓ рд╣реЛ рдЬрд╛рдПред",
        DE = "Schalte die Lichter auf der ganzen Welt ein! Entferne alle gruseligen Schatten, damit jede H├╢hle hell wird."
    },
    
    ["AFK_T"] = {ID = "Anti-AFK", EN = "Anti-AFK", PT = "Anti-AFK", ZH = "щШ▓цМВцЬ║", ES = "Anti-AFK", AR = "┘Е╪╢╪з╪п ╪з┘Д╪╖╪▒╪п", FR = "Anti-AFK", RU = "╨Р╨╜╤В╨╕-╨Р╨д╨Ъ", HI = "рдПрдВрдЯреА-AFK", DE = "Anti-AFK"},
    ["AFK_D"] = {
        ID = "Perlindungan super agar kamu tidak ditendang keluar saat diam! Bisa ditinggal tidur atau makan dengan 100% aman.",
        EN = "Super protection so you don't get kicked out when idle! You can leave it to sleep or eat 100% safely.",
        PT = "Super prote├з├гo para voc├к n├гo ser expulso! Voc├к pode deixar para dormir ou comer com 100% de seguran├зa.",
        ZH = "ш╢Еч║зф┐ЭцКдя╝Мшойф╜ахЬихПСхСЖцЧ╢ф╕Нф╝Ъшвлш╕вхЗ║ц╕╕цИПя╝Бф╜ахПпф╗е100%хоЙхЕихЬ░чж╗х╝АхО╗чЭбшзЙцИЦхРГщенуАВ",
        ES = "┬бS├║per protecci├│n para que no te expulsen cuando est├бs inactivo! Puedes ir a dormir o comer 100% seguro.",
        AR = "╪н┘Е╪з┘К╪й ┘Б╪з╪ж┘В╪й ╪н╪к┘Й ┘Д╪з ┘К╪к┘Е ╪╖╪▒╪п┘Г ╪╣┘Ж╪п ╪з┘Д╪о┘Е┘И┘Д! ┘К┘Е┘Г┘Ж┘Г ╪к╪▒┘Г┘З ┘Д┘Д┘Ж┘И┘Е ╪г┘И ╪к┘Ж╪з┘И┘Д ╪з┘Д╪╖╪╣╪з┘Е ╪и╪г┘Е╪з┘Ж ╪к╪з┘Е.",
        FR = "Super protection pour ne pas ├кtre expuls├й ! Laissez le jeu pour dormir ou manger en toute s├йcurit├й.",
        RU = "╨б╤Г╨┐╨╡╤А ╨╖╨░╤Й╨╕╤В╨░, ╤З╤В╨╛╨▒╤Л ╤В╨╡╨▒╤П ╨╜╨╡ ╨▓╤Л╨│╨╜╨░╨╗╨╕, ╨║╨╛╨│╨┤╨░ ╤В╤Л ╨Р╨д╨Ъ! ╨Ь╨╛╨╢╨╡╤И╤М ╤Б╨╝╨╡╨╗╨╛ ╤Б╨┐╨░╤В╤М ╨╕╨╗╨╕ ╨╡╤Б╤В╤М ╨╜╨░ 100% ╨▒╨╡╨╖╨╛╨┐╨░╤Б╨╜╨╛.",
        HI = "рд╕реБрдкрд░ рд╕реБрд░рдХреНрд╖рд╛ рддрд╛рдХрд┐ рдЬрдм рдЖрдк рдирд┐рд╖реНрдХреНрд░рд┐рдп рд╣реЛрдВ рддреЛ рдЖрдкрдХреЛ рдмрд╛рд╣рд░ рди рдирд┐рдХрд╛рд▓рд╛ рдЬрд╛рдП! рдЖрдк рд╕реБрд░рдХреНрд╖рд┐рдд рд░реВрдк рд╕реЗ рд╕реЛ рд╕рдХрддреЗ рд╣реИрдВ рдпрд╛ рдЦрд╛ рд╕рдХрддреЗ рд╣реИрдВред",
        DE = "Super Schutz, damit du nicht gekickt wirst! Du kannst das Spiel sicher verlassen, um zu schlafen oder zu essen."
    },
    
    ["Ping"] = {ID = "Ping", EN = "Ping", PT = "Ping", ZH = "х╗╢ш┐Я", ES = "Ping", AR = "╪з┘Д╪и┘К┘Ж╪║", FR = "Ping", RU = "╨Я╨╕╨╜╨│", HI = "рдкрд┐рдВрдЧ", DE = "Ping"},
    ["FPS"] = {ID = "FPS", EN = "FPS", PT = "FPS", ZH = "х╕зчОЗ", ES = "FPS", AR = "╪з┘Д╪е╪╖╪з╪▒╪з╪к", FR = "IPS", RU = "╨д╨Я╨б", HI = "рдПрдлрдкреАрдПрд╕", DE = "FPS"},
    ["Clock"] = {ID = "Jam", EN = "Clock", PT = "Rel├│gio", ZH = "цЧ╢щЧ┤", ES = "Reloj", AR = "╪з┘Д┘И┘В╪к", FR = "Horloge", RU = "╨Т╤А╨╡╨╝╤П", HI = "рд╕рдордп", DE = "Uhr"},
    
    ["Notif_T"] = {ID = "Berhasil Dieksekusi!", EN = "Successfully Executed!", PT = "Executado com Sucesso!", ZH = "цЙзшбМцИРхКЯя╝Б", ES = "┬бEjecutado con ├йxito!", AR = "╪к┘Е ╪з┘Д╪к┘Ж┘Б┘К╪░ ╪и┘Ж╪м╪з╪н!", FR = "Ex├йcut├й avec succ├иs!", RU = "╨г╤Б╨┐╨╡╤И╨╜╨╛ ╨╖╨░╨┐╤Г╤Й╨╡╨╜╨╛!", HI = "рд╕рдлрд▓рддрд╛рдкреВрд░реНрд╡рдХ!", DE = "Erfolgreich ausgef├╝hrt!"},
    ["Notif_D"] = {
        ID = "Selamat datang di Vickyyvall Hub! Semuanya sudah siap, ayo mulai petualangan seru dan jadilah yang terhebat!",
        EN = "Welcome to Vickyyvall Hub! Everything is ready, let's start an exciting adventure and be the greatest!",
        PT = "Bem-vindo ao Vickyyvall Hub! Tudo pronto, vamos come├зar uma aventura e ser o melhor!",
        ZH = "цмвш┐ОцЭехИ░ Vickyyvall Hubя╝Бф╕АхИЗхЗЖхдЗх░▒ч╗кя╝МшойцИСф╗мх╝АхзЛц┐АхКиф║║х┐ГчЪДхЖТщЩйя╝МцИРф╕║цЬАцгТчЪДхРзя╝Б",
        ES = "┬бBienvenido a Vickyyvall Hub! Todo est├б listo, ┬бcomienza una aventura emocionante y s├й el mejor!",
        AR = "┘Е╪▒╪н╪и╪з ╪и┘Г ┘Б┘К Vickyyvall Hub! ┘Г┘Д ╪┤┘К╪б ╪м╪з┘З╪▓╪М ┘Д┘Ж╪и╪п╪г ┘Е╪║╪з┘Е╪▒╪й ┘Е╪л┘К╪▒╪й ┘И┘Ж┘Г┘И┘Ж ╪з┘Д╪г╪╣╪╕┘Е!",
        FR = "Bienvenue sur Vickyyvall Hub ! Tout est pr├кt, commencez une aventure passionnante et soyez le meilleur !",
        RU = "╨Ф╨╛╨▒╤А╨╛ ╨┐╨╛╨╢╨░╨╗╨╛╨▓╨░╤В╤М ╨▓ Vickyyvall Hub! ╨Т╤Б╨╡ ╨│╨╛╤В╨╛╨▓╨╛, ╨┤╨░╨▓╨░╨╣ ╨╜╨░╤З╨╜╨╡╨╝ ╨┐╤А╨╕╨║╨╗╤О╤З╨╡╨╜╨╕╨╡ ╨╕ ╤Б╤В╨░╨╜╨╡╨╝ ╨╗╤Г╤З╤И╨╕╨╝╨╕!",
        HI = "Vickyyvall рд╣рдм рдореЗрдВ рдЖрдкрдХрд╛ рд╕реНрд╡рд╛рдЧрдд рд╣реИ! рд╕рдм рдХреБрдЫ рддреИрдпрд╛рд░ рд╣реИ, рдЖрдЗрдП рдПрдХ рд░реЛрдорд╛рдВрдЪрдХ рд╕рд╛рд╣рд╕рд┐рдХ рдХрд╛рд░реНрдп рд╢реБрд░реВ рдХрд░реЗрдВ!",
        DE = "Willkommen im Vickyyvall Hub! Alles ist bereit, lass uns ein aufregendes Abenteuer beginnen!"
    },
    
    ["Pop_Title"] = {ID = "Keluar dari Hub?", EN = "Exit Hub?", PT = "Sair do Hub?", ZH = "щААхЗ║ф╕нх┐ГхРЧя╝Я", ES = "┬┐Salir del Hub?", AR = "╪о╪▒┘И╪м╪Я", FR = "Quitter le Hub?", RU = "╨Т╤Л╨╣╤В╨╕ ╨╕╨╖ Hub?", HI = "рд╣рдм рдЫреЛрдбрд╝реЗрдВ?", DE = "Hub verlassen?"},
    ["Pop_Desc"] = {
        ID = "Apakah Anda yakin ingin mematikan script Vickyyvall Hub?", 
        EN = "Are you sure you want to close the script?", 
        PT = "Tem certeza de que deseja fechar o script?", 
        ZH = "\u{60a8}\u{786e}\u{5b9a}\u{8981}\u{5173}\u{95ed}\u{811a}\u{672c}\u{5417}\u{ff1f}", 
        ES = "┬┐Est├бs seguro de que quieres cerrar el script?", 
        AR = "\u{0647}\u{0644} \u{0625}\u{0646}\u{062a} \u{0645}\u{062a}\u{0623}\u{0643}\u{062f}\u{061f}", 
        FR = "├Кtes-vous s├╗r?", 
        RU = "\u{0412}\u{044b} \u{0443}\u{0432}\u{0435}\u{0440}\u{0435}\u{043d}\u{044b}?", 
        HI = "\u{0915}\u{094d}\u{092f}\u{093e} \u{0906}\u{092a} \u{0938}\u{094d}\u{0915}\u{094d}\u{0930}\u{093f}\u{092a}\u{094d}\u{091f} \u{092c}\u{0902}\u{0926} \u{0915}\u{0930}\u{0928}\u{093e} \u{091a}\u{093e}\u{0939}\u{0924}\u{0947} \u{0939}\u{0948}\u{0902}?", 
        DE = "Sind Sie sicher?"
    },
    
    ["Pop_Yes"] = {ID = "Ya", EN = "Yes", PT = "Sim", ZH = "цШп", ES = "S├н", AR = "┘Ж╪╣┘Е", FR = "Oui", RU = "╨Ф╨░", HI = "рд╣рд╛рдБ", DE = "Ja"},
    ["Pop_No"] = {ID = "Batal", EN = "Cancel", PT = "Cancelar", ZH = "хПЦц╢И", ES = "Cancelar", AR = "╪е┘Д╪║╪з╪б", FR = "Annuler", RU = "╨Ю╤В╨╝╨╡╨╜╨░", HI = "рд░рджреНрдж рдХрд░реЗрдВ", DE = "Abbrechen"},

    ["Lang_T"] = {ID = "Pengaturan Bahasa", EN = "Language Settings", PT = "Idioma", ZH = "шпншиАшо╛ч╜о", ES = "Idioma", AR = "╪з┘Д┘Д╪║╪й", FR = "Langue", RU = "╨п╨╖╤Л╨║", HI = "рднрд╛рд╖рд╛ рд╕реЗрдЯрд┐рдВрдЧреНрд╕", DE = "Sprache"},
    ["Lang_D"] = {
        ID = "Ganti bahasa menumu dengan sangat mudah! Tampilannya keren dan sangat gampang dipahami oleh siapapun.",
        EN = "Change your menu language very easily! It looks cool and is very easy for anyone to understand.",
        PT = "Mude o idioma do seu menu facilmente! Parece legal e ├й muito f├бcil de entender para qualquer um.",
        ZH = "щЭЮх╕╕ш╜╗цЭ╛хЬ░цЫ┤цФ╣шПЬхНХшпншиАя╝БхоГчЬЛш╡╖цЭех╛ИщЕ╖я╝Мф╗╗ф╜Хф║║щГ╜шГ╜х╛Ихо╣цШУчРЖшзгуАВ",
        ES = "┬бCambia el idioma del men├║ muy f├бcilmente! Se ve genial y es muy f├бcil de entender para cualquiera.",
        AR = "┘В┘Е ╪и╪к╪║┘К┘К╪▒ ┘Д╪║╪й ╪з┘Д┘В╪з╪ж┘Е╪й ╪з┘Д╪о╪з╪╡╪й ╪и┘Г ╪и╪│┘З┘И┘Д╪й ╪┤╪п┘К╪п╪й! ┘К╪и╪п┘И ╪▒╪з╪ж╪╣╪з ┘И╪│┘З┘Д ╪з┘Д┘Б┘З┘Е ┘Д╪г┘К ╪┤╪о╪╡.",
        FR = "Changez la langue de votre menu tr├иs facilement ! C'est cool et tr├иs facile ├а comprendre pour tout le monde.",
        RU = "╨Ь╨╡╨╜╤П╨╣ ╤П╨╖╤Л╨║ ╨╝╨╡╨╜╤О ╨╛╤З╨╡╨╜╤М ╨╗╨╡╨│╨║╨╛! ╨Т╤Л╨│╨╗╤П╨┤╨╕╤В ╨║╤А╤Г╤В╨╛ ╨╕ ╨┐╨╛╨╜╤П╤В╨╜╨╛ ╨░╨▒╤Б╨╛╨╗╤О╤В╨╜╨╛ ╨▓╤Б╨╡╨╝.",
        HI = "рдЕрдкрдиреА рдореЗрдиреВ рднрд╛рд╖рд╛ рдмрд╣реБрдд рдЖрд╕рд╛рдиреА рд╕реЗ рдмрджрд▓реЗрдВ! рдпрд╣ рдЕрдЪреНрдЫрд╛ рд▓рдЧ рд░рд╣рд╛ рд╣реИ рдФрд░ рдХрд┐рд╕реА рдХреЗ рд▓рд┐рдП рднреА рд╕рдордЭрдирд╛ рдмрд╣реБрдд рдЖрд╕рд╛рди рд╣реИред",
        DE = "├Дndere deine Men├╝sprache ganz einfach! Es sieht cool aus und ist f├╝r jeden leicht zu verstehen."
    },
    
    ["NotifRed_T"] = {ID = "Eits, Dilarang Akses!", EN = "Oops, Access Denied!", PT = "Ops, Acesso Negado!", ZH = "хУОхСАя╝МцЛТч╗Эшо┐щЧоя╝Б", ES = "┬бUy, Acceso Denegado!", AR = "╪╣┘Б┘И╪з╪М ╪║┘К╪▒ ┘Е╪│┘Е┘И╪н!", FR = "Oups, Acc├иs Refus├й!", RU = "╨Ю╨╣, ╨Ф╨╛╤Б╤В╤Г╨┐ ╨Ч╨░╨┐╤А╨╡╤Й╨╡╨╜!", HI = "рдЙрдлрд╝, рдкрд╣реБрдВрдЪ рдЕрд╕реНрд╡реАрдХреГрдд!", DE = "Hoppla, Zugriff verweigert!"},
    ["NotifRed_D"] = {
        ID = "Aktifin Box ESP-nya dulu bos! Jangan asal pencet!", 
        EN = "Activate Box ESP first, boss! Don't just click randomly!", 
        PT = "Ative o Box ESP primeiro, chefe! N├гo clique ├а toa!", 
        ZH = "шАБцЭ┐я╝Мшп╖хЕИц┐Ац┤╗ Box ESPя╝БхИлф╣▒цМЙя╝Б", 
        ES = "┬бActiva Box ESP primero, jefe! ┬бNo hagas clic al azar!", 
        AR = "┘В┘Е ╪и╪к┘Ж╪┤┘К╪╖ Box ESP ╪г┘И┘Д╪з┘Л ┘К╪з ╪▓╪╣┘К┘Е! ┘Д╪з ╪к┘Ж┘В╪▒ ╪╣╪┤┘И╪з╪ж┘К╪з┘Л!", 
        FR = "Activez d'abord Box ESP, chef ! Ne cliquez pas au hasard !", 
        RU = "╨б╨╜╨░╤З╨░╨╗╨░ ╨░╨║╤В╨╕╨▓╨╕╤А╤Г╨╣ Box ESP, ╨▒╨╛╤Б╤Б! ╨Э╨╡ ╨╢╨╝╨╕ ╨╜╨░╤Г╨│╨░╨┤!", 
        HI = "рдмреЙрд╕, рдкрд╣рд▓реЗ рдмреЙрдХреНрд╕ ESP рд╕рдХреНрд░рд┐рдп рдХрд░реЗрдВ! рдмреЗрддрд░рддреАрдм рдврдВрдЧ рд╕реЗ рдХреНрд▓рд┐рдХ рди рдХрд░реЗрдВ!", 
        DE = "Aktiviere zuerst Box ESP, Boss! Klick nicht einfach wild herum!"    
    }
}

local LangList = {
    "Indonesia (Default)", "English", "Portugu├кs", "\u{4e2d}\u{6587} (Zh\u{014d}ngw├йn)", "Espa├▒ol", "\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)", "Fran├зais", "\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)", "\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})", "Deutsch"
}

local LangMap = {
    ["Indonesia (Default)"] = "ID",
    ["English"] = "EN",
    ["Portugu├кs"] = "PT",
    ["\u{4e2d}\u{6587} (Zh\u{014d}ngw├йn)"] = "ZH",
    ["Espa├▒ol"] = "ES",
    ["\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)"] = "AR",
    ["Fran├зais"] = "FR",
    ["\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)"] = "RU",
    ["\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})"] = "HI",
    ["Deutsch"] = "DE"
}

local LangFlags = {
    ["Indonesia (Default)"] = "137384997162705",
    ["English"] = "120282236775675",
    ["Portugu├кs"] = "86904547771543",
    ["\u{4e2d}\u{6587} (Zh\u{014d}ngw├йn)"] = "137557692066436",
    ["Espa├▒ol"] = "74820341814573",
    ["\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)"] = "136150632302206",
    ["Fran├зais"] = "72328939051445",
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
    NotifFrame.ZIndex = 9999 
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
Capsule.Size = UDim2.new(0, 130, 0, 34) 
Capsule.AnchorPoint = Vector2.new(0.5, 0)
Capsule.Position = UDim2.new(0.5, 0, 0, 10)
Capsule.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Capsule.BackgroundTransparency = 0.15
Capsule.Text = "    vickyyvall hub"
Capsule.TextColor3 = Color3.fromRGB(240, 240, 240)
Capsule.Font = FontTitle
Capsule.TextSize = 12 
Capsule.Visible = true
Capsule.AutoButtonColor = false
Capsule.ZIndex = 10 
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
LogoContainer.Size = UDim2.new(0, 26, 0, 26) 
LogoContainer.Position = UDim2.new(0, 16, 0.5, -13)
LogoContainer.BackgroundTransparency = 1


local LogoIcon = Instance.new("ImageLabel", LogoContainer)
LogoIcon.Size = UDim2.new(1, 0, 1, 0)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Image = "rbxthumb://type=Asset&id=128173125009119&w=150&h=150" 
LogoIcon.ZIndex = 1


local LogoShine = Instance.new("ImageLabel", LogoContainer)
LogoShine.Size = UDim2.new(1, 0, 1, 0)
LogoShine.BackgroundTransparency = 1
LogoShine.Image = "rbxthumb://type=Asset&id=128173125009119&w=150&h=150" 
LogoShine.ImageColor3 = Color3.fromRGB(255, 245, 180) 
LogoShine.ZIndex = 2

local ShineGrad = Instance.new("UIGradient", LogoShine)
ShineGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.2, 1),
    NumberSequenceKeypoint.new(0.5, 0), 
    NumberSequenceKeypoint.new(0.8, 1),
    NumberSequenceKeypoint.new(1, 1)
})
ShineGrad.Rotation = 45

RunService.RenderStepped:Connect(function()
    LogoIcon.ImageColor3 = Color3.fromHSV((tick() * 0.15) % 1, 0.9, 1)
    ShineGrad.Rotation = 45 
    local t = (tick() % 2) / 2 
    ShineGrad.Offset = Vector2.new(-1.5 + (t * 3), 0)
end)

local Watermark = Instance.new("TextLabel", TopBar)
Watermark.Size = UDim2.new(0, 200, 1, 0)
Watermark.Position = UDim2.new(0, 44, 0, 0) 
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




local NameStack = Instance.new("Frame", ProfileFrame)
NameStack.Size = UDim2.new(1, -48, 0, 16)
NameStack.Position = UDim2.new(0, 46, 0, 8)
NameStack.BackgroundTransparency = 1

local NLayout = Instance.new("UIListLayout", NameStack)
NLayout.FillDirection = Enum.FillDirection.Horizontal
NLayout.SortOrder = Enum.SortOrder.LayoutOrder
NLayout.Padding = UDim.new(0, 4) 
NLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local ProfileDisp = Instance.new("TextLabel", NameStack)
ProfileDisp.Size = UDim2.new(0, 0, 1, 0)
ProfileDisp.AutomaticSize = Enum.AutomaticSize.X 
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
    img.Position = UDim2.new(0, 12, 0.5, 0) 
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = iconColor
    
    local tLbl = Instance.new("TextLabel", btn)
    tLbl.Size = UDim2.new(1, -70, 0, 16) 
    tLbl.Position = UDim2.new(0, 48, 0, 8) 
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", keyT)
    
    local dLbl = Instance.new("TextLabel", btn)
    dLbl.Size = UDim2.new(1, -70, 0, 42) 
    dLbl.Position = UDim2.new(0, 48, 0, 26) 
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
    img.Position = UDim2.new(0, 12, 0.5, 0) 
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = baseIconColor
    
    local tLbl = Instance.new("TextLabel", f)
    tLbl.Size = UDim2.new(1, -92, 0, 16) 
    tLbl.Position = UDim2.new(0, 48, 0, 8) 
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", keyT)
    
    local dLbl = Instance.new("TextLabel", f)
    dLbl.Size = UDim2.new(1, -92, 0, 42) 
    dLbl.Position = UDim2.new(0, 48, 0, 26) 
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
    img.Position = UDim2.new(0, 12, 0, 37.5) 
    img.BackgroundTransparency = 1
    img.Image = iconId
    img.ImageColor3 = iconColor
    
    local tLbl = Instance.new("TextLabel", f)
    tLbl.Size = UDim2.new(1, -86, 0, 16) 
    tLbl.Position = UDim2.new(0, 48, 0, 8) 
    tLbl.BackgroundTransparency = 1
    tLbl.TextColor3 = ColorText
    tLbl.Font = FontMain
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterTranslation(tLbl, "Text", keyT)
    
    local dLbl = Instance.new("TextLabel", f)
    dLbl.Size = UDim2.new(1, -86, 0, 42) 
    dLbl.Position = UDim2.new(0, 48, 0, 26) 
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




local TrackerFrame = Instance.new("Frame", P3)
TrackerFrame.Size = UDim2.new(1, -4, 0, 140) 
TrackerFrame.BackgroundColor3 = ColorMain
TrackerFrame.BackgroundTransparency = 0.5
TrackerFrame.LayoutOrder = -1
Instance.new("UICorner", TrackerFrame).CornerRadius = UDim.new(0, 16)


local MapImageBg = Instance.new("Frame", TrackerFrame)
MapImageBg.Size = UDim2.new(0, 80, 0, 80)
MapImageBg.Position = UDim2.new(0, 12, 0, 12) 
MapImageBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Instance.new("UICorner", MapImageBg).CornerRadius = UDim.new(0, 18) 
MapImageBg.ClipsDescendants = true

local MapImage = Instance.new("ImageLabel", MapImageBg)
MapImage.Size = UDim2.new(1, 0, 1, 0)
MapImage.AnchorPoint = Vector2.new(0.5, 0.5)
MapImage.Position = UDim2.new(0.5, 0, 0.5, 0)
MapImage.BackgroundTransparency = 1
MapImage.ScaleType = Enum.ScaleType.Crop 
MapImage.Image = "rbxthumb://type=Asset&id=14563958719&w=150&h=150" 






local IconJudul = Instance.new("ImageLabel", TrackerFrame)
IconJudul.Size = UDim2.new(0, 14, 0, 14)
IconJudul.Position = UDim2.new(0, 105, 0, 17)
IconJudul.BackgroundTransparency = 1
IconJudul.Image = "rbxthumb://type=Asset&id=2129457776&w=150&h=150" 
IconJudul.ImageColor3 = ColorAccent

local MapTitle = Instance.new("TextLabel", TrackerFrame)
MapTitle.Size = UDim2.new(1, -130, 0, 14)
MapTitle.Position = UDim2.new(0, 125, 0, 17) 
MapTitle.BackgroundTransparency = 1
MapTitle.Text = GetText("Map_NotFound") 
MapTitle.TextColor3 = ColorText
MapTitle.Font = Enum.Font.GothamBold
MapTitle.TextSize = 13
MapTitle.TextXAlignment = Enum.TextXAlignment.Left
MapTitle.TextTruncate = Enum.TextTruncate.AtEnd


local IconTanggal = Instance.new("ImageLabel", TrackerFrame)
IconTanggal.Size = UDim2.new(0, 14, 0, 14)
IconTanggal.Position = UDim2.new(0, 105, 0, 42)
IconTanggal.BackgroundTransparency = 1
IconTanggal.Image = "rbxthumb://type=Asset&id=106533346160517&w=150&h=150" 
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


local IconWaktu = Instance.new("ImageLabel", TrackerFrame)
IconWaktu.Size = UDim2.new(0, 14, 0, 14)
IconWaktu.Position = UDim2.new(0, 105, 0, 67)
IconWaktu.BackgroundTransparency = 1
IconWaktu.Image = "rbxthumb://type=Asset&id=17551409714&w=150&h=150" 
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
                    
                    local tahun, bulan, tanggal = string.match(info.Created, "(%d+)%-(%d+)%-(%d+)")
                    if tahun and bulan and tanggal then
                        MapDate.Text = "Tanggal dibuat: " .. tanggal .. "/" .. bulan .. "/" .. tahun
                    end
                end
            end
        end
    end)
end)


RunService.RenderStepped:Connect(function()
    local waktuNyata = Workspace.DistributedGameTime 
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




local FriendList = Instance.new("Frame", TrackerFrame)
FriendList.Size = UDim2.new(1, -24, 0, 26)
FriendList.Position = UDim2.new(0, 12, 0, 105) 
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




local ScrollDownBtn = Instance.new("ImageButton", PageContainer)
ScrollDownBtn.Size = UDim2.new(0, 32, 0, 32)
ScrollDownBtn.AnchorPoint = Vector2.new(1, 1)
ScrollDownBtn.Position = UDim2.new(1, -25, 1, -25) 
ScrollDownBtn.BackgroundTransparency = 1
ScrollDownBtn.Image = "rbxthumb://type=Asset&id=134413307626859&w=150&h=150"
ScrollDownBtn.ZIndex = 9999 
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
        
        TweenService:Create(CurrentActivePage, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, maxScroll)}):Play()
    end
end)

RunService.RenderStepped:Connect(function()
    for _, child in pairs(PageContainer:GetChildren()) do
        if child:IsA("ScrollingFrame") and child.Visible then
            if CurrentActivePage ~= child then
                CurrentActivePage = child
                CheckScrollStatus() 
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


P1.Visible = true

BtnMin.MouseButton1Click:Connect(function()
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0, 27), BackgroundTransparency = 1}, 0.35).Completed:Connect(function() MainFrame.Visible = false end)
end)


local isMaximized = false
BtnMax.MouseButton1Click:Connect(function()
    isMaximized = not isMaximized
    local mainCorner = MainFrame:FindFirstChildOfClass("UICorner") 
    
    if isMaximized then
        Tween(MainFrame, {Size = UDim2.new(0.92, 0, 0.96, 0)}, 0.4) 
        if mainCorner then Tween(mainCorner, {CornerRadius = UDim.new(0, 30)}, 0.4) end 
        
        Tween(SidebarBG, {Size = UDim2.new(0, 140, 1, -50)}, 0.4)
        Tween(PageContainer, {Size = UDim2.new(1, -160, 1, -50), Position = UDim2.new(0, 155, 0, 40)}, 0.4)
        Tween(MaxIcon, {ImageColor3 = ColorAccent}, 0.3)
    else
        Tween(MainFrame, {Size = UDim2.new(0, 420, 0, 300)}, 0.4)
        if mainCorner then Tween(mainCorner, {CornerRadius = UDim.new(0, 18)}, 0.4) end 
        
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


local ConfirmPopup = Instance.new("Frame", ScreenGui)
ConfirmPopup.Size = UDim2.new(0, 250, 0, 120)
ConfirmPopup.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmPopup.Position = UDim2.new(0.5, 0, 0.5, 15)
ConfirmPopup.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
ConfirmPopup.BackgroundTransparency = 1
ConfirmPopup.ClipsDescendants = true 
ConfirmPopup.Visible = false
ConfirmPopup.ZIndex = 999
Instance.new("UICorner", ConfirmPopup).CornerRadius = UDim.new(0, 14)


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
CDesc.Text = "Apakah Anda yakin ingin mematikan script Vickyyvall Hub?" 
CDesc.TextColor3 = ColorDesc
CDesc.TextTransparency = 1
CDesc.TextWrapped = true
CDesc.Font = FontDesc
CDesc.TextSize = 10
CDesc.ZIndex = 1000


LangDict["Pop_Desc"] = {ID = "Apakah Anda yakin ingin mematikan script Vickyyvall Hub?", EN = "Are you sure you want to close the script?", PT = "Tem certeza de que deseja fechar o script?", ZH = "\u{60a8}\u{786e}\u{5b9a}\u{8981}\u{5173}\u{95ed}\u{811a}\u{672c}\u{5417}\u{ff1f}", ES = "┬┐Est├бs seguro de que quieres cerrar el script?", AR = "\u{0647}\u{0644} \u{0625}\u{0646}\u{062a} \u{0645}\u{062a}\u{0623}\u{0643}\u{062f}\u{061f}", FR = "├Кtes-vous s├╗r?", RU = "\u{0412}\u{044b} \u{0443}\u{0432}\u{0435}\u{0440}\u{0435}\u{043d}\u{044b}?", HI = "\u{0915}\u{094d}\u{092f}\u{093e} \u{0906}\u{092a} \u{0938}\u{094d}\u{0915}\u{094d}\u{0930}\u{093f}\u{092a}\u{094d}\u{091f} \u{092c}\u{0902}\u{0926} \u{0915}\u{0930}\u{0928}\u{093e} \u{091a}\u{093e}\u{0939}\u{0924}\u{0947} \u{0939}\u{0948}\u{0902}?", DE = "Sind Sie sicher?"}


local BtnYa = Instance.new("TextButton", ConfirmPopup)
BtnYa.Size = UDim2.new(0, 95, 0, 30)
BtnYa.Position = UDim2.new(0, 20, 0, 75)
BtnYa.BackgroundColor3 = Color3.fromRGB(25, 25, 30) 
BtnYa.BackgroundTransparency = 1
BtnYa.Text = "Ya"
BtnYa.TextColor3 = Color3.fromRGB(255, 75, 75) 
BtnYa.TextTransparency = 1
BtnYa.Font = FontTitle
BtnYa.TextSize = 12
BtnYa.AutoButtonColor = false
BtnYa.ZIndex = 1000
Instance.new("UICorner", BtnYa).CornerRadius = UDim.new(0, 8)


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


local function FadePopup(show)
    local targetAlpha = show and 0 or 1
    local targetBgAlpha = show and 0.15 or 1
    local targetPos = show and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 15)
    local duration = 0.5 
    
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


BtnYa.MouseEnter:Connect(function() Tween(BtnYa, {BackgroundColor3 = Color3.fromRGB(40, 20, 20)}, 0.2) end)
BtnYa.MouseLeave:Connect(function() Tween(BtnYa, {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}, 0.2) end)
BtnBatal.MouseEnter:Connect(function() Tween(BtnBatal, {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}, 0.2) end)
BtnBatal.MouseLeave:Connect(function() Tween(BtnBatal, {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}, 0.2) end)


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


MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0, 27)
MainFrame.Visible = false

task.spawn(function()
    task.wait(0.5) 
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


local BoxFrame = Instance.new("Frame", P2)
BoxFrame.Size = UDim2.new(1, -4, 0, 75)
BoxFrame.BackgroundColor3 = ColorMain
BoxFrame.BackgroundTransparency = 0.5
Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 8)

local BoxImg = Instance.new("ImageLabel", BoxFrame)
BoxImg.Size = UDim2.new(0, 18, 0, 18)
BoxImg.AnchorPoint = Vector2.new(0, 0.5)
BoxImg.Position = UDim2.new(0, 12, 0.5, 0) 
BoxImg.BackgroundTransparency = 1
BoxImg.Image = "rbxthumb://type=Asset&id=112499571301742&w=150&h=150" 
BoxImg.ImageColor3 = Color3.fromRGB(255, 255, 255) 

local BoxTitle = Instance.new("TextLabel", BoxFrame)
BoxTitle.Size = UDim2.new(1, -129, 0, 16) 
BoxTitle.Position = UDim2.new(0, 48, 0, 8) 
BoxTitle.BackgroundTransparency = 1
BoxTitle.TextColor3 = ColorText
BoxTitle.Font = FontMain
BoxTitle.TextSize = 12
BoxTitle.TextXAlignment = Enum.TextXAlignment.Left
RegisterTranslation(BoxTitle, "Text", "Box_T")

local BoxDesc = Instance.new("TextLabel", BoxFrame)
BoxDesc.Size = UDim2.new(1, -129, 0, 42) 
BoxDesc.Position = UDim2.new(0, 48, 0, 26) 
BoxDesc.BackgroundTransparency = 1
BoxDesc.TextColor3 = ColorDesc
BoxDesc.Font = FontDesc
BoxDesc.TextSize = 10
BoxDesc.TextXAlignment = Enum.TextXAlignment.Left
BoxDesc.TextYAlignment = Enum.TextYAlignment.Top
BoxDesc.TextWrapped = true
RegisterTranslation(BoxDesc, "Text", "Box_D")

BoxFrame.ClipsDescendants = true 


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


local CP_Frame = Instance.new("Frame", P2)
CP_Frame.Size = UDim2.new(1, -4, 0, 0) 
CP_Frame.BackgroundColor3 = ColorMain
CP_Frame.BackgroundTransparency = 0.8
CP_Frame.ClipsDescendants = true 
CP_Frame.Visible = false
CP_Frame.ZIndex = 5 
Instance.new("UICorner", CP_Frame).CornerRadius = UDim.new(0, 8)




local CP_Icon = Instance.new("ImageLabel", CP_Frame)
CP_Icon.Size = UDim2.new(0, 18, 0, 18)
CP_Icon.AnchorPoint = Vector2.new(0, 0.5)
CP_Icon.Position = UDim2.new(0, 12, 0, 24) 
CP_Icon.BackgroundTransparency = 1
CP_Icon.Image = "rbxthumb://type=Asset&id=111189222786853&w=150&h=150"
CP_Icon.ImageColor3 = ColPink 

local CP_Title = Instance.new("TextLabel", CP_Frame)
CP_Title.Size = UDim2.new(1, -60, 0, 16)
CP_Title.AnchorPoint = Vector2.new(0, 0.5)
CP_Title.Position = UDim2.new(0, 48, 0, 24) 
CP_Title.BackgroundTransparency = 1
CP_Title.Text = "Custom Color Box ESP"
CP_Title.TextColor3 = ColorDesc
CP_Title.Font = FontMain
CP_Title.TextSize = 12
CP_Title.TextXAlignment = Enum.TextXAlignment.Left

local CP_Btn = Instance.new("TextButton", CP_Frame)
CP_Btn.Size = UDim2.new(0, 38, 0, 18)
CP_Btn.Position = UDim2.new(1, -85, 0, 15) 
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




local ActiveRedNotif = nil 

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
    NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18) 
    NotifFrame.BackgroundTransparency = 0.05 
    NotifFrame.ZIndex = 9999
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 16) 
    
    ActiveRedNotif = NotifFrame 
    
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
    RegisterTranslation(NTitle, "Text", "NotifRed_T") 
    
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
    RegisterTranslation(NDesc, "Text", "NotifRed_D") 
 
    Tween(NotifFrame, {Position = UDim2.new(1, -20, 1, -20)}, 0.5)
    task.delay(4, function()
        local hideTw = Tween(NotifFrame, {Position = UDim2.new(1, 300, 1, -20), BackgroundTransparency = 1}, 0.5)
        hideTw.Completed:Connect(function() 
            NotifFrame:Destroy() 
            ActiveRedNotif = nil 
        end)
    end)
end

DropBtn.MouseButton1Click:Connect(function()
    dropOpen = not dropOpen
    if dropOpen then
        Spacer.Visible = true
        CP_Frame.Visible = true
        Tween(CP_Frame, {Size = UDim2.new(1, -4, 0, 160)}, 0.4) 
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
    Tween(BoxBtn, {BackgroundColor3 = ESP_Box and ColPink or ColorToggleOff}, 0.25) 
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
                    hl.FillTransparency = 1 
                    hl.OutlineTransparency = 0 
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
                
                
                if ESP_Box then
                    espData.Highlight.Enabled = true
                    if cpActive then
                        espData.Highlight.OutlineColor = ESP_Box_Color
                    else
                        
                        espData.Highlight.OutlineColor = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
                    end
                else
                    espData.Highlight.Enabled = false
                end
                
                
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
    
    
    
    local rgbNyuri = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
    
    for _, obj in pairs(P2:GetDescendants()) do
        if obj:IsA("ImageLabel") then
            
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




local AFK_Frame = Instance.new("Frame", P4)
AFK_Frame.Size = UDim2.new(1, -4, 0, 75)
AFK_Frame.BackgroundColor3 = ColorMain
AFK_Frame.BackgroundTransparency = 0.5
Instance.new("UICorner", AFK_Frame).CornerRadius = UDim.new(0, 8)


local AFK_IconOff = Instance.new("ImageLabel", AFK_Frame)
AFK_IconOff.Size = UDim2.new(0, 40, 0, 40) 
AFK_IconOff.Position = UDim2.new(0, 10, 0.5, -20) 
AFK_IconOff.BackgroundTransparency = 1
AFK_IconOff.Image = "rbxthumb://type=Asset&id=96165359287667&w=150&h=150"
AFK_IconOff.ZIndex = 1


local AFK_IconOn = Instance.new("ImageLabel", AFK_Frame)
AFK_IconOn.Size = UDim2.new(0, 40, 0, 40) 
AFK_IconOn.Position = UDim2.new(0, 10, 0.5, -20)
AFK_IconOn.BackgroundTransparency = 1
AFK_IconOn.Image = "rbxthumb://type=Asset&id=93330283163178&w=150&h=150"
AFK_IconOn.ImageTransparency = 1 
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
    
    
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    
    TweenService:Create(AFK_Btn, tweenInfo, {BackgroundColor3 = state and Color3.fromRGB(50, 255, 100) or ColorToggleOff}):Play()
    TweenService:Create(AFK_Ind, tweenInfo, {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
    
    
    TweenService:Create(AFK_IconOn, tweenInfo, {ImageTransparency = state and 0 or 1}):Play()
    TweenService:Create(AFK_IconOff, tweenInfo, {ImageTransparency = state and 1 or 0}):Play()
end)

LocalPlayer.Idled:Connect(function() 
    if _G.AntiAFK then 
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new()) 
    end 
end)


local lPing = CreateInfo(P4, "rbxthumb://type=Asset&id=82571483730620&w=150&h=150", Color3.fromRGB(255, 255, 255), "Ping", "0 ms")
local lFps = CreateInfo(P4, "rbxthumb://type=Asset&id=134742030444605&w=150&h=150", Color3.fromRGB(255, 255, 255), "FPS", "0 FPS")
local lTime = CreateInfo(P4, "rbxthumb://type=Asset&id=17551409714&w=150&h=150", Color3.fromRGB(255, 255, 255), "Clock", "00:00:00")


local frames = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
end)


task.spawn(function()
    while task.wait(1) do
        if not ScreenGui.Parent then break end 
        
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
LangImg.Image = "rbxthumb://type=Asset&id=137384997162705&w=150&h=150" 
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
LangTitle.Position = UDim2.new(0, 48, 0, 10) 
LangTitle.BackgroundTransparency = 1
LangTitle.TextColor3 = ColorText
LangTitle.Font = FontMain
LangTitle.TextSize = 12
LangTitle.TextXAlignment = Enum.TextXAlignment.Left
RegisterTranslation(LangTitle, "Text", "Lang_T")

local LangDesc = Instance.new("TextLabel", DropFrame)
LangDesc.Size = UDim2.new(1, -90, 0, 42) 
LangDesc.Position = UDim2.new(0, 48, 0, 24) 
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


local langOpen = false
LangDropBtn.MouseButton1Click:Connect(function()
    langOpen = not langOpen
    if langOpen then
        LangScroll.Visible = true        
        local selectedIndex = 1
        for i, l in ipairs(LangList) do
            if l == ActiveLanguage then selectedIndex = i; break end
        end
        
        
        LangScroll.CanvasPosition = Vector2.new(0, (selectedIndex - 1) * 65)
        Tween(LangScroll, {Size = UDim2.new(1, -4, 0, 205)}, 0.35) 
    else
        Tween(LangScroll, {Size = UDim2.new(1, -4, 0, 0)}, 0.35).Completed:Connect(function()
            if not langOpen then LangScroll.Visible = false end
        end)
    end
    Tween(PtrImg2, {Rotation = langOpen and -180 or 0}, 0.35)
end)

local function UpdateLanguageSystem(lang)
    ActiveLanguage = lang
    local useUniversal = (lang == "\u{4e2d}\u{6587} (Zh\u{014d}ngw├йn)" or lang == "\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)" or lang == "\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)" or lang == "\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})")
    
    for _, item in pairs(TranslationElements) do
        if item.Element and item.Element.Parent then
            item.Element[item.Property] = GetText(item.Key)
            if item.Property == "Text" then
                item.Element.Font = useUniversal and FontUniversal or FontMain
            end
        end
    end
end


local LangDescs = {
    ["Indonesia (Default)"] = "Gunakan bahasa Indonesia untuk antarmuka. Semua fitur dan instruksi akan diterjemahkan dengan sangat akurat dan tegas.",
    ["English"] = "Set the interface to English. All features and instructions will be translated for a seamless and premium experience.",
    ["Portugu├кs"] = "Defina a interface para Portugu├кs. Todos os recursos e instru├з├╡es ser├гo traduzidos para uma experi├кncia premium e clara.",
    ["\u{4e2d}\u{6587} (Zh\u{014d}ngw├йn)"] = "х░ЖчХМщЭвшо╛ч╜оф╕║ф╕нцЦЗуАВцЙАцЬЙхКЯшГ╜хТМшп┤цШОщГ╜х░Жшвлч┐╗шпСя╝Мф╕║цВицПРф╛ЫцЧач╝ЭуАБф╝Шш┤иф╕ФщЭЮх╕╕ц╕ЕцЩ░чЪДф╜УщкМуАВ",
    ["Espa├▒ol"] = "Configura la interfaz en Espa├▒ol. Todas las funciones e instrucciones se traducir├бn para una experiencia fluida y muy premium.",
    ["\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)"] = "┘В┘Е ╪и╪к╪╣┘К┘К┘Ж ╪з┘Д┘И╪з╪м┘З╪й ╪е┘Д┘Й ╪з┘Д┘Д╪║╪й ╪з┘Д╪╣╪▒╪и┘К╪й. ╪│┘К╪к┘Е ╪к╪▒╪м┘Е╪й ╪м┘Е┘К╪╣ ╪з┘Д┘Е┘К╪▓╪з╪к ┘И╪з┘Д╪к╪╣┘Д┘К┘Е╪з╪к ┘Д╪к╪м╪▒╪и╪й ╪│┘Д╪│╪й ┘И┘И╪з╪╢╪н╪й ╪м╪п╪з ┘И╪н╪з╪▓┘Е╪й.",
    ["Fran├зais"] = "D├йfinissez l'interface en Fran├зais. Toutes les fonctionnalit├йs et instructions seront traduites de mani├иre pr├йcise et ├йl├йgante.",
    ["\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)"] = "╨г╤Б╤В╨░╨╜╨╛╨▓╨╕╤В╨╡ ╤А╤Г╤Б╤Б╨║╨╕╨╣ ╤П╨╖╤Л╨║. ╨Т╤Б╨╡ ╤Д╤Г╨╜╨║╤Ж╨╕╨╕ ╨╕ ╨╕╨╜╤Б╤В╤А╤Г╨║╤Ж╨╕╨╕ ╨▒╤Г╨┤╤Г╤В ╨┐╨╡╤А╨╡╨▓╨╡╨┤╨╡╨╜╤Л ╨┤╨╗╤П ╨╛╨▒╨╡╤Б╨┐╨╡╤З╨╡╨╜╨╕╤П ╨▒╨╡╤Б╨┐╨╡╤А╨╡╨▒╨╛╨╣╨╜╨╛╨╣ ╨╕ ╨┐╨╛╨╜╤П╤В╨╜╨╛╨╣ ╤А╨░╨▒╨╛╤В╤Л.",
    ["\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})"] = "рдЗрдВрдЯрд░рдлрд╝реЗрд╕ рдХреЛ рд╣рд┐рдВрджреА рдореЗрдВ рд╕реЗрдЯ рдХрд░реЗрдВред рдПрдХ рд╕рд╣рдЬ рдФрд░ рдкреНрд░реАрдорд┐рдпрдо рдЕрдиреБрднрд╡ рдХреЗ рд▓рд┐рдП рд╕рднреА рд╕реБрд╡рд┐рдзрд╛рдУрдВ рдФрд░ рдирд┐рд░реНрджреЗрд╢реЛрдВ рдХрд╛ рдЕрдиреБрд╡рд╛рдж рдХрд┐рдпрд╛ рдЬрд╛рдПрдЧрд╛ред",
    ["Deutsch"] = "Stelle die Benutzeroberfl├дche auf Deutsch ein. Alle Funktionen und Anweisungen werden f├╝r ein nahtloses Erlebnis ├╝bersetzt."
}

for _, lang in ipairs(LangList) do
    local bContainer = Instance.new("Frame", LangScroll)
    bContainer.Size = UDim2.new(1, 0, 0, 65) 
    bContainer.BackgroundTransparency = 1
    
    local b = Instance.new("TextButton", bContainer)
    b.Size = UDim2.new(1, -12, 1, -4) 
    b.Position = UDim2.new(0, 6, 0, 2)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 25) 
    b.BackgroundTransparency = 0.7 
    b.Text = ""
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8) 
    
    b.MouseEnter:Connect(function() Tween(b, {BackgroundColor3 = ColorToggleOff, BackgroundTransparency = 0.3}, 0.25) end)
    b.MouseLeave:Connect(function() Tween(b, {BackgroundColor3 = Color3.fromRGB(20, 20, 25), BackgroundTransparency = 0.7}, 0.25) end)  
    
    local flagIcon = Instance.new("ImageLabel", b)
    flagIcon.Size = UDim2.new(0, 24, 0, 24) 
    flagIcon.AnchorPoint = Vector2.new(0, 0.5)
    flagIcon.Position = UDim2.new(0, 12, 0.5, 0) 
    flagIcon.BackgroundTransparency = 1
    flagIcon.Image = "rbxthumb://type=Asset&id=" .. LangFlags[lang] .. "&w=150&h=150"
    flagIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)    
    
    local lTitle = Instance.new("TextLabel", b)
    lTitle.Size = UDim2.new(1, -54, 0, 16)
    lTitle.Position = UDim2.new(0, 48, 0, 8) 
    lTitle.BackgroundTransparency = 1
    lTitle.TextColor3 = ColorText
    lTitle.Font = (lang == "\u{4e2d}\u{6587} (Zh\u{014d}ngw├йn)" or lang == "\u{0627}\u{0644}\u{0639}\u{0631}\u{0628}\u{064a}\u{0629} (Al-'Arabiyyah)" or lang == "\u{0420}\u{0443}\u{0441}\u{0441}\u{043a}\u{0438}\u{0439} (Russkiy)" or lang == "\u{0939}\u{093f}\u{0928}\u{094d}\u{0926}\u{0940} (Hind\u{012b})") and FontUniversal or FontMain
    lTitle.TextSize = 12
    lTitle.TextXAlignment = Enum.TextXAlignment.Left
    lTitle.Text = lang

    local lDesc = Instance.new("TextLabel", b)
    lDesc.Size = UDim2.new(1, -54, 0, 40)
    lDesc.Position = UDim2.new(0, 48, 0, 24) 
    lDesc.BackgroundTransparency = 1
    lDesc.TextColor3 = ColorDesc
    lDesc.Font = FontDesc
    lDesc.TextSize = 10
    lDesc.TextXAlignment = Enum.TextXAlignment.Left
    lDesc.TextYAlignment = Enum.TextYAlignment.Top
    lDesc.TextWrapped = true
    lDesc.Text = LangDescs[lang] 
    
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
