<?php

class HomeController extends BaseController // recette de l'objet, description
{
    public function show() // afficher la page
    {

       return $this->view('home', [
           'pre' => "Bienvenue chez",
           'title' => "Chocolatte",
           'employees' => Employee::getHomepageEmployees()
       ]);
    }
}
// sur qu'il n'y a que ça qui s'affiche, pas bien