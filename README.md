# flower-shop-lab
Інструкція запуску:

Аплікація: 
1. Встановити останню версію Flutter
2. Перемкнути на beta версію і увімкнути підтримку web-аплікацій:
flutter channel beta
$ flutter upgrade
$ flutter config --enable-web
3. Запустити аплцікацію на localhost у Google Chrome:
flutter run -d chrome


Бекенд:
1. Зклонувати репку
git clone git@github.com:tooSadman/flower-shop-lab.git
2. Запустити apiserver
go run cmd/apiserver.go


Адміністративна панель:
Потрібно вказати в pg.yml файлі шлях до бази данних, тобто адресу сервера без вказування порта. Або ж скористатись базою даних, яка створиться автоматично скриптом. Для запуску адмінки необхідно мати встановлений Docker на вашому комп'ютері і, в залежності від вашої ОС, запустити create.bat чи create.sh файл, який створить та запустить все автоматично. В браузері впишіть localhost:3000/<entity>, де ви і зможете редагувати/створювати/видаляти дані.
