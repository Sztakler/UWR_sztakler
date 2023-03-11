<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class TransferController extends AbstractController
{
    /**
     * @Route("/przelewy", name="transfers")
     */
    public function index(): Response
    {
        return $this->forward('App\Controller\TransferController::onForeignAccount', [
            'controller_name' => 'PrzelewyController',
            'title' => 'Przelewy',
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }

    /**
     * @Route("/przelewy/krajowe", name="domesticTransfers")
     */
    public function domesticTransfer(): Response
    {
        return $this->forward('App\Controller\TransferController::onForeignAccount', [
            'controller_name' => 'PrzelewyController',
            'title' => 'Przelewy krajowe',
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }

    /**
     * @Route("/przelewy/krajowe/na_wlasny_rachunek", name="domesticTransfersClientAccount")
     */
    public function onClientAccount(): Response
    {
        return $this->render('main_page/index.html.twig', [
            'controller_name' => 'PrzelewyController',
            'title' => "Przelewy krajowe na rachunek własny",
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }

    /**
     * @Route("/przelewy/krajowe/na_obcy_rachunek", name="domesticTransfersForeignAccount")
     */
    public function onForeignAccount(): Response
    {
        return $this->render('main_page/index.html.twig', [
            'controller_name' => 'PrzelewyController',
            'title' => "Przelewy krajowe na rachunek obcy",
            'header' => "Nagłówek",
            'footer' => "Stopka"
        ]);
    }
}
