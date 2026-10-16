#import "template/template.typ": *

#show: resume.with(
  name: "Jméno Příjmení",
  about: [
    Krátký popis toho, čemu se věnujete\
    Škola nebo obor
  ],
  accent-color: rgb("222"),
  aside: [
    #side-title("Kontakt")
    #contacts(
      fa-icon("envelope", solid: true), link("mailto:mail@example.com")[mail\@example.com],
      fa-icon("phone", solid: true), link("tel:+420000000000")[+420 000 000 000],
    )

    #side-title("Jazyky")
    Čeština: mateřský jazyk \
    Angličtina: B1

    #side-title("Dovednosti")
    #skill-group("Skupina", "Nástroj", "Další")
  ],
)

= Vzdělání

#entry(
  "Obor (titul)",
  years: "2021–2025",
  org: [Škola],
)

= Pracovní zkušenosti

#entry(
  "Pozice",
  years: "Aktuální",
  org: [Organizace],
)[
  Stručný popis práce: co jste dělali a k čemu to sloužilo.
]

= Další zkušenosti

#entry("Aktivita", years: "Aktuální", org: [Organizace])[
  Co v ní děláte, jednou nebo dvěma větami.
]
