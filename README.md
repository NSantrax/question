# УРОК 17
# Реализовать следующие истории:
#1. Отправка ежедневного письма-дайджеста всем пользователям. Дайджест содержит
#список всех вопросов, созданных за последние сутки
#2. Автор вопроса получает уведомление на email при появлении нового ответа на свой
#вопрос
#3. Любой залогиненный пользователь может подписаться на обновления вопроса. При это
#он будет получать уведомления по email при появлении новых ответов на этот вопрос. Кол-во
#вопросов, на которые может быть подписан пользователь не ограничено.
#Отправку писем реализовать через очередь задач. Использовать delayde_job + whenever либо
#sidekiq + sidetiq на выбор

# Запустить в отдельном терминале: rackup private_pub.ru -s thin -E production
# redis-server
# sidekiq



