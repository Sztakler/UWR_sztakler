<?php

namespace App\Entity;

use App\Repository\TransferRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass=TransferRepository::class)
 */
class Transfer
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=26)
     * @Assert\Regex("/^[0-9]{2}12349876[0-9]{16}$/",
     * message="Your property should match XX 12349876 XXXX XXXX XXXX XXXX"
     * )
     */
    private $accountFrom;

    /**
     * @ORM\Column(type="string", length=26)
     * @Assert\Regex("/^[0-9]{2}12349876[0-9]{16}$/",
     * message="Your property should match XX"
     * )
     */
    private $accountTo;

    /**
     * @ORM\Column(type="string", length=255)
     * @Assert\Length(min=0, max=100)",
     * message="Your property should match XX"
     * )
     */
    private $name;

    /**
     * @ORM\Column(type="string", length=255)
     * @Assert\Length(min=1, max=100)
     */
    private $street;

    /**
     * @ORM\Column(type="string", length=255)
     * @Assert\Length(min=1, max=100)
     */
    private $city;

    /**
     * @ORM\Column(type="string", length=6)
     * @Assert\Regex("/^[0-9]{2}-[0-9]{3}$/",
     * message="Your property should match XX-XXX"
     * )
     */
    private $postcode;

    /**
     * @ORM\Column(type="string")
     * @Assert\Regex("/^[0-9]+,[0-9]{2}$/",
     * message="Your property should match /^[0-9]+,[0-9]{2}$/"
     * )
     */
    private $amount;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $title;

    /**
     * @ORM\Column(type="string"),
     * @Assert\Regex("/^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/",
     * message="Your property should match (?:(?:31(/|-|.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(/|-|.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(/|-|.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(/|-|.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})"
     * )
     */
     
    private $date;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setID(string $ID): self
    {
        $this->ID = $ID;

        return $this;
    }

    public function getAccountFrom(): ?string
    {
        return $this->accountFrom;
    }

    public function setAccountFrom(string $accountFrom): self
    {
        $this->accountFrom = $accountFrom;

        return $this;
    }

    public function getAccountTo(): ?string
    {
        return $this->accountTo;
    }

    public function setAccountTo(string $accountTo): self
    {
        $this->accountTo = $accountTo;

        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getStreet(): ?string
    {
        return $this->street;
    }

    public function setStreet(string $street): self
    {
        $this->street = $street;

        return $this;
    }

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(string $city): self
    {
        $this->city = $city;

        return $this;
    }

    public function getPostcode(): ?string
    {
        return $this->postcode;
    }

    public function setPostcode(string $postcode): self
    {
        $this->postcode = $postcode;

        return $this;
    }

    public function getAmount(): ?string
    {
        return $this->amount;
    }

    public function setAmount(?string $amount): self
    {
        $this->amount = $amount;

        return $this;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): self
    {
        $this->title = $title;

        return $this;
    }

    public function getDate(): ?string
    {
        return $this->date;
    }

    public function setDate(string $date): self
    {
        $this->date = $date;

        return $this;
    }
}
