# BS_project

## 项目简介

BS_ Project是一个基于 Vue 前端、Django 后端和 MySQL 数据库的商品比价网站。本项目使用 Docker 容器化技术部署，确保了环境一致性和易于迁移。3220105868——宋汝毅

## 项目结构

- **backend**: Django 后端代码目录。
- **frontend**: Vue 前端代码目录。
- **docker-compose.yml**: 项目容器编排文件。
- **mysql_backup.tar.gz**: MySQL 数据库备份文件。
- **README.md**: 项目说明文件。
- **.gitignore**: Git 忽略文件配置。
- **BS_project_docker_image**: 项目所需的镜像文件。

## 写给老师

我是3220105868 宋汝毅，2024/12/27我去线下验收过了，所有功能已经都验收完毕，但是验收时我有一个问题就是数据库的数据没办法同步迁移过去，经过我回来后的一些改正，解决了这个问题。另外，演示功能的视频其实录制的时候是在较早的时间前，因此有些地方和当前的版本可能有所出入，演示视频可能也有些细枝末节没有演示到位，但是全部的功能已经在验收时跟您当面验过了，谢谢老师！！

## 快速启动指南

### 1. 确保项目文件已下载到主机

确保完整项目文件夹在目标主机上。

### 2. 启动 Docker 容器

进入项目目录后，运行以下命令启动 Docker 容器：

```
docker-compose up -d
```

注意：这里可能会要求从某些网站拉取镜像，请确保你的网络是畅通的！！！可以访问外网的！！！

### 3. 确认数据库卷名称

运行以下命令，确认 MySQL 数据库卷的名称：

```
docker volume ls
```

找到数据库卷名称，例如 `bs_project_db_data`。

### 4. 还原备份数据

将 `mysql_backup.tar.gz` 数据库备份文件还原到数据库卷中：

```
docker run --rm -v bs_project_db_data:/var/lib/mysql -v /目标目录:/backup alpine sh -c "cd / && tar xzf /backup/mysql_backup.tar.gz"
```

将 `/目标目录` 替换为你的项目目录路径。假如你的目标目录是`C:\Users\14296\Desktop`，那么你要运行的指令是（一定要把路径linux化！！！）

```
docker run --rm -v bs_project_db_data:/var/lib/mysql -v /c/Users/14296/Desktop:/backup alpine sh -c "cd / && tar xzf /backup/mysql_backup.tar.gz"
```

### 5. 后端迁移（如有必要）

如果需要进行数据库迁移，请执行以下操作：

1. 进入后端容器：

   ```
   docker exec -it bs_project-backend-1 bash
   ```

2. 在容器内运行以下命令：

   ```
   python manage.py makemigrations
   python manage.py migrate
   ```

### 6. 运行

运行请直接输入：

```
localhost:8080
```

## 注意事项

1. **确保 Docker 环境已正确安装和配置。**
2. **数据库备份文件** `**mysql_backup.tar.gz**` **应放置在项目根目录。**
3. **在目标主机上，网络配置需允许所需的端口通信：**
   - 前端：`8080`
   - 后端：`8000`
   - 数据库：`3306`

## 常见问题

### 数据库数据丢失

如果容器重启或迁移到其他主机后发现数据丢失，请确保正确挂载数据库卷并还原备份数据。

### 无法访问服务

1. 确认容器已启动：

   ```
   docker ps
   ```

2. 检查防火墙或网络配置是否允许所需端口通信。

## 联系方式

如有问题，请联系开发者。

邮箱：3220105868@zju.edu.cn

备注：以上内容均由本人3220105868 宋汝毅独立完成，如有雷同，系抄袭行为
