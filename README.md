# Elementum — corso Godot per imparare a programmare

Un corso pratico per imparare a programmare da zero, costruendo insieme un
piccolo dungeon crawler 2D ispirato a **Dungeons & Dragons** (statistiche e
tiri di dado), **Genshin Impact** (poteri elementali e reazioni) e
**Magic: The Gathering** (incantesimi giocati come carte).

Si programma con **GDScript** dentro **Godot Engine 4.x**.

## Come iniziare

1. Leggete [`lessons/00-setup-git-e-godot.md`](lessons/00-setup-git-e-godot.md)
   per installare Godot e collegarvi alla repository condivisa.
2. Andate avanti una lezione alla volta, nell'ordine dell'indice qui sotto.
3. Ogni lezione ha un **Checkpoint**: se F5/F6 mostra quello che è descritto
   lì, siete pronti per la lezione successiva.

**Versione di Godot usata per questo progetto**: 4.7.x (Standard, non .NET).
Usate la stessa versione minore su entrambi i computer.

## Indice delle lezioni

| # | Lezione | Cosa costruisci |
|---|---|---|
| 0 | [Prepariamo il computer](lessons/00-setup-git-e-godot.md) | Ambiente pronto su entrambi i computer |
| 1 | [Il tuo eroe si muove!](lessons/01-il-tuo-eroe-si-muove.md) | Uno sprite che si muove con le frecce |
| 2 | [Il tuo primo dungeon](lessons/02-il-tuo-primo-dungeon.md) | L'eroe bloccato dai muri di una stanza |
| 3 | [Porte e stanze](lessons/03-porte-e-stanze.md) | Si passa da una stanza all'altra |
| 4 | Statistiche del personaggio | HP e attacco del tuo eroe |
| 5 | HUD e barra vita | Barra vita in alto allo schermo |
| 6 | Il primo nemico e i dadi | Nemico colpibile, danno calcolato coi dadi (d20!) |
| 7 | Il nemico si sveglia | Un nemico che ti insegue e attacca |
| 8 | I poteri elementali | Lanci la tua prima palla di fuoco |
| 9 | La mano delle carte | Scegli tra 2-4 incantesimi come carte |
| 10 | Reazioni elementali | Combina fuoco/acqua/ghiaccio/elettro per effetti speciali |
| 11 | Stanze piene di nemici | Ripulisci una stanza per sbloccare la porta successiva |
| 12 | Il boss finale | Il gioco completo, dal menu alla vittoria |
| 13 *(facoltativa)* | Salvare i progressi | Salvataggio tra una partita e l'altra |
| 14 *(facoltativa)* | Personalizza e pubblica | Un file eseguibile da far provare agli amici |

Le lezioni dalla 2 in poi vengono scritte man mano che si avanza nel corso,
per restare allineate al ritmo di chi impara.

## Struttura del progetto

```
lessons/    — il materiale del corso, una lezione per file
game/       — il progetto Godot vero e proprio (apritelo da qui)
```

## Come si lavora insieme sulla repo

- Si lavora tutti direttamente su `main`, senza branch: è più semplice per
  chi comincia, e il lavoro procede quasi sempre una persona alla volta.
- Alla fine di ogni lezione si fa un commit e si crea un **tag** (es.
  `lezione-06`): è un "segnalibro" su quel punto della cronologia, utile per
  rivedere cosa è cambiato (`git diff lezione-05 lezione-06`) o tornare
  indietro se qualcosa si rompe.
- **Prima di iniziare una sessione**: fate un pull/fetch degli ultimi
  cambiamenti. **Alla fine**: commit + push, per non lasciare lavoro solo
  sul proprio computer.
- Il figlio può usare [GitHub Desktop](https://desktop.github.com/) (bottoni
  invece di comandi da terminale); il papà può continuare da riga di
  comando.
