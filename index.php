<?php

require_once('config.php');
// Inclut tout le continu du fichier()
// Charger toutes les dépendances de code
require_once('controllers/BaseController.php');
require_once('controllers/HomeController.php');
require_once('models/BaseModel.php');
require_once('models/Employee.php');

$controller = new HomeController();

$controller->handle();