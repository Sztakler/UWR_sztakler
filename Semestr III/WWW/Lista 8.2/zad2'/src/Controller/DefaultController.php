<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    /**
     * @Route("/", name="index")
     */
    public function index(): Response
    {
        return $this->render('competition.html.twig', [
            'competitors' => [
                ['score' => "20", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "19", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "18", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "10", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "0", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "10", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "10", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "10", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "0", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "10", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "10", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"],
                ['score' => "0", 'name' => "Janek Matusiak", 'city' => "Warszawa", 'team' => "Czerwoni"]
            ]
        ]);
    }
}
