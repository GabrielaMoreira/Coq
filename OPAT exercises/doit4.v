Add LoadPath "." as OPAT.
Require Import OPAT.aula3 OPAT.aula4 OPAT.aula5 OPAT.aula6.

(** **** Exercise: 2 star (snd_fst_is_swap)  *)
Theorem snd_fst_is_swap : forall (p : natprod),
  (snd p, fst p) = swap_pair p.
Proof.
  intros p.
  destruct p as [n m].
  simpl. reflexivity.
Qed.

(** **** Exercise: 2 star, optional (fst_swap_is_snd)  *)
Theorem fst_swap_is_snd : forall (p : natprod),
  fst (swap_pair p) = snd p.
Proof.
  intros p.
  destruct p as [n m].
  simpl. reflexivity.
Qed.
