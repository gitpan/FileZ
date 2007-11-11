
--
-- Structure de la table `acls`
--

CREATE TABLE IF NOT EXISTS `acls` (
  `acl_id` int(10) unsigned NOT NULL auto_increment,
  `folder_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `mode` varchar(45) NOT NULL,
  PRIMARY KEY  (`acl_id`),
  KEY `FK_acls_1` (`folder_id`),
  KEY `FK_acls_2` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `file_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_content` longblob NOT NULL,
  PRIMARY KEY  (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Structure de la table `folders`
--

CREATE TABLE IF NOT EXISTS `folders` (
  `folder_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL,
  `folder_name` varchar(255) NOT NULL,
  `parent_folder_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`folder_id`),
  KEY `FK_folders_1` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `acls`
--
ALTER TABLE `acls`
  ADD CONSTRAINT `FK_acls_1` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`folder_id`),
  ADD CONSTRAINT `FK_acls_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Contraintes pour la table `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `FK_folders_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
