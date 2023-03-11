<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MainPageController extends AbstractController
{
    /**
     * @Route("/", name="main_page")
     */
    public function index(): Response
    {
        return $this->render('main_page/index.html.twig', [
            'controller_name' => 'MainPageController',
            'title' => 'Najlepszy bank w Polsce',
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }

    /**
     * @Route("/lista_przelewow/{{date}}/{{amount}}", name="transfersList",
     * requirements={
     * "amount"="^[0-9]+,[0-9]{2}$",
     * "data"="^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
     * },
     * defaults={"date": "yyyy-mm-dd", "amount": "0,00"})
     * 
     */
    public function transfersList(string $date, string $amount): Response
    {
        return $this->render('lista_przelewow/index.html.twig', [
            'controller_name' => 'MainPageController',
            'title' => 'Lista przelewów',
            'header' => "Nagłówek",
            'footer' => "Stopka",
            'date' => $date,
            'amount' => $amount
        ]);
    }

    /**
     * @Route("/karty", name="cards")
     */
    public function cards(): Response
    {
        return $this->forward('App\Controller\MainPageController::creditCards', [
            'controller_name' => 'MainPageController',
            'title' => 'Karty',
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }

    /**
     * @Route("/karty/kredytowe", name="creditCards")
     */
    public function creditCards(): Response
    {
        return $this->render('main_page/index.html.twig', [
            'controller_name' => 'MainPageController',
            'title' => 'Karty kredytowe',
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }

    /**
     * @Route("/karty/do_konta", name="accountCards")
     */
    public function accountCards(): Response
    {
        return $this->render('main_page/index.html.twig', [
            'controller_name' => 'MainPageController',
            'title' => 'Karty do konta',
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }
}
