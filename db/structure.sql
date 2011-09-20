DROP TABLE IF EXISTS `column_info_reset_users`;

CREATE TABLE `column_info_reset_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(127) DEFAULT NULL,
  `state` varchar(127) DEFAULT NULL,
  `country` varchar(127) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
