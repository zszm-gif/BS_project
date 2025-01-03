-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: BS_project
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add platform',7,'add_platform'),(26,'Can change platform',7,'change_platform'),(27,'Can delete platform',7,'delete_platform'),(28,'Can view platform',7,'view_platform'),(29,'Can add category',8,'add_category'),(30,'Can change category',8,'change_category'),(31,'Can delete category',8,'delete_category'),(32,'Can view category',8,'view_category'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add price',10,'add_price'),(38,'Can change price',10,'change_price'),(39,'Can delete price',10,'delete_price'),(40,'Can view price',10,'view_price');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_fc02df82_fk_categories_id` (`parent_id`),
  CONSTRAINT `categories_parent_id_fc02df82_fk_categories_id` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'鎵嬫満',1,'2024-12-09 09:33:47.188732',NULL),(2,'鐢佃剳',1,'2024-12-09 09:33:47.197123',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-12-26 05:59:50.935685','15','Product object (15)',1,'[{\"added\": {}}]',9,1),(2,'2024-12-26 06:00:23.025965','17','Price object (17)',1,'[{\"added\": {}}]',10,1),(3,'2024-12-26 09:34:46.128499','6','Category object (6)',3,'',8,1),(4,'2024-12-26 09:34:48.842947','5','Category object (5)',3,'',8,1),(5,'2024-12-26 09:34:52.424061','6','Platform object (6)',3,'',7,1),(6,'2024-12-26 09:34:54.940558','5','Platform object (5)',3,'',7,1),(7,'2024-12-26 09:34:58.887486','20','Price object (20)',3,'',10,1),(8,'2024-12-26 09:35:01.155515','21','Price object (21)',3,'',10,1),(9,'2024-12-26 09:35:06.842997','18','Product object (18)',3,'',9,1),(10,'2024-12-26 09:35:11.136269','19','Product object (19)',3,'',9,1),(11,'2024-12-26 09:36:43.429449','21','Product object (21)',3,'',9,1),(12,'2024-12-26 09:36:46.223026','20','Product object (20)',3,'',9,1),(13,'2024-12-26 09:36:50.137139','23','Price object (23)',3,'',10,1),(14,'2024-12-26 09:36:52.546407','22','Price object (22)',3,'',10,1),(15,'2024-12-26 09:36:56.019389','8','Platform object (8)',3,'',7,1),(16,'2024-12-26 09:37:01.510504','8','Category object (8)',3,'',8,1),(17,'2024-12-26 09:37:04.251681','7','Category object (7)',3,'',8,1),(18,'2024-12-26 09:40:02.108734','7','Platform object (7)',3,'',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'products','category'),(7,'products','platform'),(10,'products','price'),(9,'products','product'),(5,'sessions','session'),(6,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-09 09:23:34.730080'),(2,'contenttypes','0002_remove_content_type_name','2024-12-09 09:23:34.754662'),(3,'auth','0001_initial','2024-12-09 09:23:34.854154'),(4,'auth','0002_alter_permission_name_max_length','2024-12-09 09:23:34.881482'),(5,'auth','0003_alter_user_email_max_length','2024-12-09 09:23:34.884319'),(6,'auth','0004_alter_user_username_opts','2024-12-09 09:23:34.887578'),(7,'auth','0005_alter_user_last_login_null','2024-12-09 09:23:34.890548'),(8,'auth','0006_require_contenttypes_0002','2024-12-09 09:23:34.892548'),(9,'auth','0007_alter_validators_add_error_messages','2024-12-09 09:23:34.895565'),(10,'auth','0008_alter_user_username_max_length','2024-12-09 09:23:34.899024'),(11,'auth','0009_alter_user_last_name_max_length','2024-12-09 09:23:34.902382'),(12,'auth','0010_alter_group_name_max_length','2024-12-09 09:23:34.909895'),(13,'auth','0011_update_proxy_permissions','2024-12-09 09:23:34.914405'),(14,'auth','0012_alter_user_first_name_max_length','2024-12-09 09:23:34.917501'),(15,'users','0001_initial','2024-12-09 09:23:35.048876'),(16,'admin','0001_initial','2024-12-09 09:23:35.109274'),(17,'admin','0002_logentry_remove_auto_add','2024-12-09 09:23:35.113944'),(18,'admin','0003_logentry_add_action_flag_choices','2024-12-09 09:23:35.118477'),(19,'products','0001_initial','2024-12-09 09:23:35.232066'),(20,'sessions','0001_initial','2024-12-09 09:23:35.247812');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('52bu53ckjkq21extolu2kbk3zdhjk7ce','.eJxVjDsOwjAQBe_iGllJ7OzalPScwdqPRQLIluKkQtwdIqWA9s3Me5lE2zqlreUlzWrOpjen341JHrnsQO9UbtVKLesys90Ve9Bmr1Xz83K4fwcTtelbo0cVH5Whkww-kpcwMqITkIGw40ADuxEG7bWPAZj9CIrC4HJgBPP-AOTRN-A:1tQk9F:vgdFCXRnlyesC44-pxOKB9tX90shffnIr93PhGfZRgc','2025-01-09 09:27:17.801493'),('82t51tpsfxx8psvdo0k1260l955jgqsm','.eJxVjDsOwjAQBe_iGllJ7OzalPScwdqPRQLIluKkQtwdIqWA9s3Me5lE2zqlreUlzWrOpjen341JHrnsQO9UbtVKLesys90Ve9Bmr1Xz83K4fwcTtelbo0cVH5Whkww-kpcwMqITkIGw40ADuxEG7bWPAZj9CIrC4HJgBPP-AOTRN-A:1tQOW3:z9p9q9BdTLO3mP-oEM6XeqSUB6VW4-XeQiSSaN4X4oY','2025-01-08 10:21:23.997120'),('olhn4p8xy3iw9706ix6a4hrigwi7cuj5','.eJxVjDsOwjAQBe_iGllJ7OzalPScwdqPRQLIluKkQtwdIqWA9s3Me5lE2zqlreUlzWrOpjen341JHrnsQO9UbtVKLesys90Ve9Bmr1Xz83K4fwcTtelbo0cVH5Whkww-kpcwMqITkIGw40ADuxEG7bWPAZj9CIrC4HJgBPP-AOTRN-A:1tKaAt:zww_jtSMO5afgavt9FqOwL3JH0dhiMJarex8WAx3KVA','2024-12-23 09:35:31.679956');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platforms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `login_required` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` VALUES (1,'浜笢','https://www.jd.com',1,'2024-12-09 09:33:47.199123'),(2,'娣樺疂','https://www.taobao.com',1,'2024-12-09 09:33:47.200124');
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `platform_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prices_platform_id_7b90104c_fk_platforms_id` (`platform_id`),
  KEY `prices_product_id_d8374f06_fk_products_id` (`product_id`),
  CONSTRAINT `prices_platform_id_7b90104c_fk_platforms_id` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`),
  CONSTRAINT `prices_product_id_d8374f06_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,2200.00,'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/4275666976/O1CN01tcW1rx21P3yMv4Fau_!!4275666976.jpg_.webp','2024-12-09 09:40:35.000000',2,1),(2,3699.00,'http://img.alicdn.com/img/i3/45838938/O1CN013AYDgE2Ftf3JSTQ3Y_!!4611686018427384410-0-saturn_solar.jpg_.webp','2024-12-09 09:40:35.864540',2,2),(3,87.00,'http://img.alicdn.com/img/i2/6688307574/O1CN01sR8ohk25ownVsBrnN_!!0-saturn_solar.jpg_.webp','2024-12-09 09:45:39.128800',2,3),(4,546.00,'http://img.alicdn.com/img/i2/6847309284/O1CN01wF9IuI2IS84e55giV_!!0-saturn_solar.jpg_.webp','2024-12-13 23:24:18.672970',2,4),(5,115.00,'http://img.alicdn.com/img/i4/30343644/O1CN01YCmKq31cn0CZEgHDZ_!!0-saturn_solar.jpg_.webp','2024-12-13 23:24:18.672970',2,5),(6,799.00,'http://img.alicdn.com/img/i4/16299050/O1CN01BcCtvV2GixOL2OBpX_!!0-saturn_solar.jpg_.webp','2024-12-13 23:24:18.672970',2,6),(7,1499.00,'https://img13.360buyimg.com/n7/jfs/t1/225903/6/32304/75954/675aed5dFc90c1e69/c41cd19b24ae8578.jpg.avif','2024-12-13 23:24:18.672970',1,7),(8,4399.00,'https://img14.360buyimg.com/n7/jfs/t1/231619/15/31223/116503/675bb3d9Ff06e4223/76eae90564dfa5a1.jpg.avif','2024-12-13 23:24:18.672970',1,8),(9,339.00,'https://img14.360buyimg.com/n7/jfs/t1/227481/1/17061/128453/661f67acF7bc8138e/f501956139ebdc9d.jpg.avif','2024-12-13 23:24:18.672970',1,9),(10,3179.00,'https://img10.360buyimg.com/n7/jfs/t1/239972/18/28452/144194/675baba3Fd1c51772/aa7a556fd2b05cba.png.avif','2024-12-13 23:24:18.672970',1,10),(11,3699.00,'https://img10.360buyimg.com/n7/jfs/t1/227938/30/29180/168476/67590778F96c3547f/5154592df210e7aa.jpg.avif','2024-12-13 23:24:18.672970',1,11),(12,3599.00,'https://img10.360buyimg.com/n7/jfs/t1/227938/30/29180/168476/67590778F96c3547f/5154592df210e7aa.jpg.avif','2024-12-12 23:24:18.672970',1,11),(13,13.00,'http://img.alicdn.com/img/i2/6963683178/O1CN01GrulsG1ZLZh8vkhdc_!!0-saturn_solar.jpg_.webp','2024-12-20 19:48:18.672170',2,12),(14,77.90,'http://img.alicdn.com/img/i1/32298774/O1CN01nxdKsj2EgY66SOjPh_!!4611686018427385622-0-saturn_solar.jpg_.webp','2024-12-20 19:55:30.674110',2,13),(15,260.00,'http://img.alicdn.com/img/i4/5968227016/O1CN01Gycjxd21hNnQ02v24_!!0-saturn_solar.jpg_.webp','2024-12-20 19:59:30.674110',2,14),(16,2000.00,'https://img10.360buyimg.com/n7/jfs/t1/227938/30/29180/168476/67590778F96c3547f/5154592df210e7aa.jpg.avif','2024-12-25 22:24:18.672970',1,11),(17,114514.00,'https://img0.baidu.com/it/u=2234254741,1458217663&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500','2024-12-26 06:00:23.025338',1,15);
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `specifications` json NOT NULL,
  `image_url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keywords` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_a7a3a156_fk_categories_id` (`category_id`),
  CONSTRAINT `products_category_id_a7a3a156_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'銆愪簩鎵嬨€慉pple/鑻规灉 iPhone 13 鍙屽崱鍥借姝ｅ搧13 mini浜屾墜鎵嬫満杩蜂綘','Apple iPhone 13 128GB','{\"color\": \"鏄熷厜鑹瞈", \"storage\": \"128GB\"}','https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/4275666976/O1CN01tcW1rx21P3yMv4Fau_!!4275666976.jpg_.webp','','2024-12-09 09:40:35.864540',1),(2,'涓嬪崟浼樺厛鍙?閫夐€佽豹绀?REDMI 绾㈢背k80Pro 5G鏂版鎵嬫満K80灏忕背瀹樻柟鏃楄埌鍚屾娓告垙鏃楄埌鎵嬫満姝ｅ搧搴梤edmi灏忕背k80Pro','REDMI 绾㈢背k80Pro','{\"color\": \"鐜勫榛慭", \"screen\": \"6.1鑻卞\", \"storage\": \"12GB+128GB\"}','http://img.alicdn.com/img/i3/45838938/O1CN013AYDgE2Ftf3JSTQ3Y_!!4611686018427384410-0-saturn_solar.jpg_.webp','1','2024-12-09 09:40:35.864540',1),(3,'oppofindn2鎵嬫満澹砯indn2鎶樺彔灞忔柊娆緔l瓒呰杽oppo find n2鍏ㄥ寘闃叉憯澹宠啘涓€浣撲繚鎶ゅoppofindn2绠€绾﹀澹冲叏鍖呬繚鎶ゅ','oppofindn2鎵嬫満澹砯indn2鎶樺彔灞?,'{\"color\": \"銆愭澹粦-楂樻竻鐗堛€戣嚮閫夌撼甯曠湡鐨槄360掳閾伴摼鍏ㄥ寘闃叉憯鈽呴浂鎸囩汗\"}','http://img.alicdn.com/img/i2/6688307574/O1CN01sR8ohk25ownVsBrnN_!!0-saturn_solar.jpg_.webp','1','2024-12-09 09:45:39.128800',1),(4,'Cyan Moza銆愯嚦绠€涔嬮潤銆?鑰侀挶椋庣櫨鎼弻闈㈠憿楂樿叞鐩寸瓛瑁欓暱娆惧崐韬鍐?,'楂樿叞鐩寸瓛瑁?,'{\"color\": \"宀╅粦鑹瞈"}','http://img.alicdn.com/img/i2/6847309284/O1CN01wF9IuI2IS84e55giV_!!0-saturn_solar.jpg_.webp','1','2024-12-13 23:24:18.672970',1),(5,'鍝斿摡鍝斿摡澶т細鍛樺勾鍗?2涓湀涓€骞碽ilibili瓒呯骇澶т細鍛樺勾鍗绔橵IP骞村崱','vip浼氬憳24灏忔椂鑷姩鐩村啿绉掑埌','{\"secure\": \"MasterCard Visa\"}','http://img.alicdn.com/img/i4/30343644/O1CN01YCmKq31cn0CZEgHDZ_!!0-saturn_solar.jpg_.webp','1','2024-12-13 23:24:18.672970',1),(6,'姗欏瓙瑁呮満diy閰嶇疆鍜ㄨ瀹氬埗鐢佃剳楂橀厤涓绘満纭欢鍗囩骇鍙板紡瀹剁敤鏁存満娓呭崟','姗欏瓙瑁呮満鍚堜綔绀?,'{\"secure\": \"MasterCard Visa\"}','http://img.alicdn.com/img/i4/16299050/O1CN01BcCtvV2GixOL2OBpX_!!0-saturn_solar.jpg_.webp','1','2024-12-13 23:24:18.672970',1),(7,'鎽╂墭缃楁媺 鑱旀兂moto S50 Neo 鍥涘勾璐ㄤ繚 绾よ杽楂樻竻鍙屾洸灞?搴旂敤鍏紑 澶х數姹犻暱缁埅 5GAI鎵嬫満 12+256GB 鍗冲ⅷ','鎽╂墭缃楁媺鎵嬫満浜笢鑷惀搴?,'{\"color\": \"鍗冲ⅷ\"}','https://img13.360buyimg.com/n7/jfs/t1/225903/6/32304/75954/675aed5dFc90c1e69/c41cd19b24ae8578.jpg.avif','1','2024-12-13 23:24:18.672970',1),(8,'鎴村皵 鍥藉琛ヨ创 鎴愬氨3030S 鍙板紡鐢佃剳(14浠5-14400 16G DDR5 512G+2T娴烽噺瀛樺偍)23.8鎶ょ溂澶у睆 鍔炲叕瀛︿範','鎴村皵浜笢鑷惀瀹樻柟鏃楄埌搴?,'{\"scale\": \"涓绘満+23.8鑻卞鏄剧ず鍣╘"}','https://img14.360buyimg.com/n7/jfs/t1/231619/15/31223/116503/675bb3d9Ff06e4223/76eae90564dfa5a1.jpg.avif','1','2024-12-13 23:24:18.672970',1),(9,'娆ч搨涓斤紙OPPOLIA锛夋┍鏌滃畾鍒?鐜颁唬绠€绾﹀帹鎴垮帹鏌滃畾鍋?鏁翠綋姗辨煖鐭宠嫳鐭冲彴闈㈢伓鍙扮鏌滀竴浣?棰勪粯閲戯紙鍜ㄨ瀹㈡湇瑙ｉ攣鏇村鑺辫壊锛?,'娆ч搨涓藉畼鏂规棗鑸板簵','{\"color\": \"NULL\"}','https://img14.360buyimg.com/n7/jfs/t1/227481/1/17061/128453/661f67acF7bc8138e/f501956139ebdc9d.jpg.avif','1','2024-12-13 23:24:18.672970',1),(10,'杈板▍ 娌欏彂 鑳℃鏈ㄥ叏瀹炴湪娌欏彂缁勫悎鐜颁唬涓紡瀹㈠巺鍐涓ょ敤璐靛鍌ㄧ墿鏈ㄥ鍏?浜斾汉浣?璐靛姒?鑼跺嚑','闄堝▍瀹跺叿瀹樻柟鏃楄埌搴?,'{\"scale\": \"涓変汉浣?璐靛姒籠"}','https://img10.360buyimg.com/n7/jfs/t1/239972/18/28452/144194/675baba3Fd1c51772/aa7a556fd2b05cba.png.avif','1','2024-12-13 23:24:18.672970',1),(11,'娴峰皵锛圚aier锛夊啺绠卞嚭鍝併€愬皬濂跺挅銆?63鍗囬浂璺濈宓屽叆寮忓鐢ㄧ櫧鑹茶秴钖勬硶寮忓闂ㄥ洓寮€闂ㄩ鍐锋棤闇滀竴绾ц兘鏁堝弻鍙橀鐢靛啺绠?463鍗囧ザ娌归+娉曞紡澶氶棬+骞叉箍鍒嗗偍+涓夋。鍙樻俯','娴峰皵鍐扮浜瘹瀹樻柟鏃楄埌搴?,'{\"scale\": \"NULL\"}','https://img10.360buyimg.com/n7/jfs/t1/227938/30/29180/168476/67590778F96c3547f/5154592df210e7aa.jpg.avif','1','2024-12-13 23:24:18.672970',1),(12,'鎵嬭〃鐢疯〃瀛︾敓闊╃増娼祦鏃跺皻鍏ㄨ嚜鍔ㄩ潪鏈烘濂宠〃闃叉按绠€绾﹀鍏夋儏渚ｇ數瀛?,'绛遍泤鎵嬭〃鏃楄埌搴?,'{\"scale\": \"鍏ㄩ粦濂虫\"}','http://img.alicdn.com/img/i2/6963683178/O1CN01GrulsG1ZLZh8vkhdc_!!0-saturn_solar.jpg_.webp','1','2024-12-20 19:48:18.672170',1),(13,'鐟炲＋鍚嶇墝鐢峰＋鎵嬭〃澶氬姛鑳藉鍏夋椂灏氭疆娴佸晢鍔℃墜琛ㄧ敺澹槻姘寸煶鑻辫厱琛ㄧ敺','POEDAGAR鎵嬭〃搴?,'{\"scale\": \"C983鐜噾澹宠摑闈㈤噾閽夐挗甯︽\"}','http://img.alicdn.com/img/i1/32298774/O1CN01nxdKsj2EgY66SOjPh_!!4611686018427385622-0-saturn_solar.jpg_.webp','1','2024-12-20 19:55:30.674110',1),(14,'鐟炲＋ochstin濂ュ彜鏂櫥鏈烘鎵嬭〃鎵嬭〃瀛楅潰琛ㄧ洏娼祦鏃跺皻澶ц〃鐩樿厱琛?,'鐗ц獡浼佷笟搴?,'{\"color\": \"閾跺３鍐涚豢\"}','http://img.alicdn.com/img/i4/5968227016/O1CN01Gycjxd21hNnQ02v24_!!0-saturn_solar.jpg_.webp','1','2024-12-20 19:59:30.674110',1),(15,'3220105868test','3220105868test','{\"test\": \"test\"}','https://img0.baidu.com/it/u=2234254741,1458217663&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500','1','2024-12-26 05:59:50.927512',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pbkdf2_sha256$870000$8KhDultRNjujtGhN7SnCoN$yzggn0GQElbpPja3UsiUGzCt8hWEMu2Yp1l8YpqU9P8=','2024-12-26 09:27:17.798763',1,'','',1,1,'2024-12-09 09:24:18.245520','1429615891@qq.com','1429615891',NULL,'2024-12-09 09:24:18.453330'),(2,'pbkdf2_sha256$870000$rMNQ4ulorj6wI9BoAcnGTW$YPsFZkrUmTqEPxc6Z8mXq7Gci+xda8IO0p6V0BINDgo=',NULL,0,'','',0,1,'2024-12-09 09:25:43.982219','test@example.com','testuser','13800138000','2024-12-09 09:25:44.196315'),(3,'pbkdf2_sha256$870000$hQroohbYRgGnc1pAZLK6lC$ir49YKKfSu9CLCe5OYTCvHky9915UgOSHAaS9/Zn/kM=',NULL,0,'','',0,1,'2024-12-09 11:34:44.084948','ruyisong77@gmail.com','srysry',NULL,'2024-12-09 11:34:44.311271'),(4,'pbkdf2_sha256$870000$XVcbSdEK6ujnNdhfq4blTl$9ABmOd617NNF6f2/xaNSEBEOYH2/J7e5dQVqaBIGwcQ=',NULL,0,'','',0,1,'2024-12-23 12:19:44.700789','3220105868@zju.edu.cn','3220105868',NULL,'2024-12-23 12:19:44.902063'),(5,'pbkdf2_sha256$870000$N9j8FOcBZU8ZLtPwZ3JMni$VnvrpYQ/VtbKaugFxVbcVzwvM0nRceEG1BZ6pd7/0z8=',NULL,0,'','',0,1,'2024-12-25 10:23:37.774503','123456789@qq.com','123456789',NULL,'2024-12-25 10:23:37.989067'),(6,'pbkdf2_sha256$870000$CPFsRhjNGM31Plcj6gv8o4$5CjdV6iHFGehhWA6AVNlJr2btoK/yEFpyZo/l6s2MHM=',NULL,0,'','',0,1,'2024-12-25 10:26:17.493813','987654321@qq.com','987654321',NULL,'2024-12-25 10:26:17.710281');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_user_id_group_id_fc7788e8_uniq` (`user_id`,`group_id`),
  KEY `users_groups_group_id_2f3517aa_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_groups_group_id_2f3517aa_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_groups_user_id_f500bee5_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_permissions`
--

DROP TABLE IF EXISTS `users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_permissions_user_id_permission_id_3b86cbdf_uniq` (`user_id`,`permission_id`),
  KEY `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_permissions_user_id_92473840_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_permissions`
--

LOCK TABLES `users_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-27 16:50:36
