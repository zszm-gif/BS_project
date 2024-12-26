首先确保整个文件夹在你的主机上

在目标主机的项目目录下，启动docker-compose
docker-compose up -d

确认数据库卷名称，在目标主机运行
docker volume ls
找到你的数据库卷名称（例如 bs_project_db_data）

还原备份数据
将 mysql_backup.tar.gz 还原到数据库卷
docker run --rm -v bs_project_db_data:/var/lib/mysql -v /目标目录:/backup alpine sh -c "cd / && tar xzf /backup/mysql_backup.tar.gz"

如果在某些情况下需要后端迁移，输入
docker exec -it bs_project-backend-1 bash
在进入的bash中输入
python manage.py makemigrations
python manage.py migrate