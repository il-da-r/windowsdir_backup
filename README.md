# Скрипт бэкапа директорий Windows в локальную папку бэкапа и сетевые папки
Создавался для бэкапа файловых баз 1С

Для работы скрипта необходим 7-zip (https://www.7-zip.org/)

Для возможности отправки оповещений на почту необходимо установить blat (https://www.blat.net/) и Stunnel (https://www.stunnel.org/). По умолчанию на почту приходит три письма: одно общее о результатах бэкапа и письма с файлами логов robocopy для кажого сетевого диска

Отдельно необходимо создать файл со списком директорий (без кавычек) - формат: имя (латиница) "путь к директории"
Все остальные параметры задаются в файле скрипта
