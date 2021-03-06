Add LoadPath "." as OPAT.
Require Import OPAT.doit3 OPAT.aula3 OPAT.aula9 OPAT.aula10 OPAT.aula11 OPAT.aula4.
(** adicione outros arquivos que você achar necessário, porém cuidado para não gerar conflito de nomes *)

(** **** Exercise: 3 stars, recommended (plus_n_n_injective)  *)
(** Practice using "in" variants in this proof.  (Hint: use
    [plus_n_Sm].) *)

Theorem plus_n_n_injective : forall n m,
     n + n = m + m ->
     n = m.
Proof.
  intros n. induction n as [| n'].
  - intros m eq. induction m.
    +reflexivity.
    +inversion eq.
  - intros m eq. destruct m.
    +inversion eq.
    +inversion eq. rewrite <- plus_n_Sm in H0. rewrite <- plus_n_Sm in H0. inversion H0.
     apply IHn' in H1. rewrite H1. reflexivity.
Qed.
(** [] *)

(** **** Exercise: 2 stars (beq_nat_true)  *)
Theorem beq_nat_true : forall n m,
    beq_nat n m = true -> n = m.
Proof.
  intros n. induction n.
  -intros m eq. induction m.
   +reflexivity.
   +inversion eq.
  -intros m eq. induction m.
   +inversion eq.
   +inversion eq. apply IHn in H0. rewrite H0. reflexivity.
Qed.
(** [] *)


(** **** Exercise: 3 stars, optional (combine_split)  *)
(** Here is an implementation of the [split] function mentioned in
    chapter [Poly]: *)

Fixpoint split {X Y : Type} (l : list (X*Y))
               : (list X) * (list Y) :=
  match l with
  | [] => ([], [])
  | (x, y) :: t =>
      match split t with
      | (lx, ly) => (x :: lx, y :: ly)
      end
  end.

(** Prove that [split] and [combine] are inverses in the following
    sense: *)

Lemma list_eq : forall X (x : X) (l1 l2 : list X),
    l1 = l2 -> x :: l1 = x :: l2.
Proof.
  intros X x l1 l2 eq.
  inversion eq.
  reflexivity.
Qed.
  
Theorem combine_split : forall X Y (l : list (X * Y)) l1 l2,
  split l = (l1, l2) ->
  combine l1 l2 = l.
Proof.
  intros X Y l. induction l.
  -intros l1 l2 eq. simpl in eq. inversion eq. simpl. reflexivity.
  -simpl. destruct x. destruct (split l). intros l2 l3 eq. induction l2.
   +inversion eq.
   +induction l3.
    *inversion eq.
    *inversion eq. rewrite <- H0. rewrite <- H1. rewrite <- H2. rewrite <- H3.
     simpl. apply list_eq. apply IHl. reflexivity.
Qed.
(** [] *)

(** **** Exercise: 2 stars (destruct_eqn_practice)  *)
Theorem bool_fn_applied_thrice:
  forall (f : bool -> bool) (b : bool),
  f (f (f b)) = f b.
Proof.
  intros f b. destruct (f b) eqn:H.
  -destruct (f true) eqn:H1.
   +rewrite H1. reflexivity.
   +destruct (f false) eqn:H2.
    *reflexivity.
    *destruct b. rewrite <- H. rewrite <- H1. reflexivity.
     rewrite <- H2. rewrite <- H. reflexivity.
  -destruct (f false) eqn:H1.
   +destruct b. rewrite H. reflexivity. inversion H. rewrite <- H2. rewrite <- H1.
    reflexivity.
   +apply H1.
Qed.
(** [] *)

(** **** Exercise: 3 stars (beq_nat_sym)  *)
Theorem beq_nat_sym : forall (n m : nat),
  beq_nat n m = beq_nat m n.
Proof.
  intros n. induction n.
  -intros m. destruct m.
   +reflexivity.
   +unfold beq_nat. reflexivity.
  -intros m. destruct m.
   +unfold beq_nat. reflexivity.
   +simpl. apply IHn.
Qed.
(** [] *)

(** **** Exercise: 3 stars, advanced, optional (beq_nat_sym_informal)  *)
(** Give an informal proof of this lemma that corresponds to your
    formal proof above:

   Theorem: For any [nat]s [n] [m], [beq_nat n m = beq_nat m n].

   Proof:
   Por indução, a prova sai fácil, já que o caso base (n ou m = 0) é bem simples.
   Assim, beq_nat 0 x é falso pra qualquer x que não seja 0 (caso base). E o único caso não base que precisa ser provado é beq_nat (S n) (S m) que é igual a beq_nat n m pela própria recursão na definição.
*)
(** [] *)

(** **** Exercise: 3 stars, optional (beq_nat_trans)  *)
Theorem beq_nat_trans : forall n m p,
  beq_nat n m = true ->
  beq_nat m p = true ->
  beq_nat n p = true.
Proof.
  intros n. induction n.
  -intros m. induction m.
   +intros p eq1 eq2. rewrite eq2. reflexivity.
   +intros p eq1 eq2. inversion eq1.
  -intros m. induction m.
   +intros p eq1 eq2. inversion eq1.
   +intros p eq1 eq2. inversion eq1. destruct p.
    *inversion eq2.
    *inversion eq2. simpl. rewrite H0. apply IHn with (m:=m).
     rewrite H0. reflexivity.
     rewrite H1. reflexivity.
Qed.
(** [] *)

