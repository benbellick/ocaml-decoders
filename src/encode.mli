module type S = sig
  type value

  type 'a encoder = 'a -> value

  val string : string encoder

  val int : int encoder

  val float : float encoder

  val bool : bool encoder

  val null : value

  val nullable : 'a encoder -> 'a option encoder

  val option : 'a encoder -> 'a option encoder
    [@@ocaml.deprecated "Use nullable instead."]

  val list : 'a encoder -> 'a list encoder

  val array : 'a encoder -> 'a array encoder

  val key_value_pairs' : 'k encoder -> 'v encoder -> ('k * 'v) list encoder

  val key_value_pairs : 'v encoder -> (string * 'v) list encoder

  val obj : (string * value) list encoder

  val obj' : (value * value) list encoder

  val value : value encoder

  val of_to_string : ('a -> string) -> 'a encoder

  val encode_value : 'a encoder -> 'a -> value

  val encode_string : 'a encoder -> 'a -> string
end

module type Encodeable = sig
  type value

  val to_string : value -> string

  val of_string : string -> value

  val of_int : int -> value

  val of_float : float -> value

  val of_bool : bool -> value

  val null : value

  val of_list : value list -> value

  val of_key_value_pairs : (value * value) list -> value
end

module Make (E : Encodeable) : S with type value = E.value
