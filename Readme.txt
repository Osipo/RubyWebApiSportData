LAUNCH:
    Из папки SportDataStorage запустить приложение командой
    rails server -p 3000

    Далее для запуска NewsReader из одноимённой папки
    выполнить rails server -p 5000

    Для консольного приложения достаточно выполнить из папки
    ./Exe.rb

    При этом убедитесь, что сервер и приложение SportDataStorage запущено.

Console app:
    exit - exit from application
    help - information about available commands.
    searchdata [title|content|url [& other attributes...n]] ={keyword}
    Ищёт данные по keyword и заданным аттрибутам.
    Если аттрибуты не указаны, то по умолчанию берётся аттрибут title.

    NewsReader:
        Поисковая строка с радиокнопками для каждого аттрибута.
        Аттрибут по умолчанию - title.
