<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Entity\Transfer;
use App\Form\TransferType;

class TransferController extends AbstractController
{
    /**
     * @Route("/", name="transfer")
     */
    public function index(Request $request): Response
    {
        $transfer = new Transfer();
        $form = $this->createForm(TransferType::class, $transfer);

        $form->handleRequest($request);
       

        if ($form->isSubmitted())
        {
            $response = $this->forward('App\Controller\TransferController::result', 
            [
                'form' => $form->createView()->vars['value']
            ]
            );

            return $response;
        }
        
        return $this->render('transfer/index.html.twig', [
                        'transfer_form' => $form->createView()
                    ]);
    }

    public function result($form): Response
    {
        return $this->render('result/index.html.twig', [
            'controller_name' => 'ResultController',
            'form_result' => [
                'Account from' => $form->getAccountFrom(),
                'Account to' => $form->getAccountTo(),
                'Name' => $form->getName(),
                'Street' => $form->getStreet(),
                'City' => $form->getCity(),
                'Postcode' => $form->getPostcode(),
                'Amount' => $form->getAmount(),
                'Title' => $form->getTitle(),
                'Date' => $form->getDate()
                ]
        ]);
    }

    
}
