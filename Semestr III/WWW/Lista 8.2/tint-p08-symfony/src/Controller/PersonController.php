<?php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\SearchType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\Length;
use App\Entity\Person;
use App\Form\PersonType;

class PersonController extends AbstractController
{ 
    /**
     * @Route("/form3", name="form3")
     * @Template()
     */
    public function form3Action(Request $request) {
        $form = $this->createFormBuilder()
                ->add('text', TextType::class, ['constraints' => [new NotBlank(), new Length(['min'=>5, 'max'=>10])]])
                ->add('email', EmailType::class)
                ->add('integer', IntegerType::class)
                ->add('plec', ChoiceType::class, ['label'=>'Płeć', 'choices' => ['m' => 'Male', 'f' => 'Female']])
                ->add('datetime', DateTimeType::class)
                ->add('save', SubmitType::class, ['label' => 'Utwórz profil'])
                ->getForm();

        $form->handleRequest($request);        

        return array('header'=>'Nagłówek', 'footer' => "Stopka", 'form' => $form->createView());
    }    
}