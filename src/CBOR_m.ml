
module Decoder = struct
  type len =
    | L_indefinite (** using indefinite length *)
    | L_int of int

  type token =
    | Int of int
    | Int64 of int64
    | Byte_str of bytes
    | Text_str of string (** utf-8 *)
    | Array_start of int (** num of elts *)
    | Map_start of int (** number of pairs *)
    | Tag of int (** tag for the next item *)
    | True
    | False
    | Float of float
    | Null
    | Undefined
    | Break (** for streaming values *)

  (*
  type t

  val of_string : string -> t

  val of_chan : in_channel -> t

  val of_manual_read :
    ?bufsize:int ->
    read:(bytes -> int -> int -> int) ->
    unit -> t

  type next_item =
    | Token of token
    | EOF
    | Await_more

  val next : t -> next_item
     *)
end

module Encoder = struct
  type t =
    | B of Buffer.t
    | C of out_channel
    | M of {
        mutable buf: bytes;
        mutable n: int;
        write: (bytes -> int -> int -> unit);
      }

  let to_buf b: t = B b
  let to_chan c : t = C c
  let to_manual_write ?(bufsize=4096) ~write () : t =
    M {buf=Bytes.make bufsize ' '; write; n=0; }

  (* TODO
  val int : t -> int -> unit
  val int64 : t -> int64 -> unit
  val bool : t -> bool -> unit
  val null : t -> unit
  val undefined : t -> unit
  val float : t -> float -> unit
  val break : t -> unit
  val array_start : t -> int -> unit
  val array_start_il : t -> unit
  val map_start : t -> int -> unit
  val map_start_il : t -> unit
     *)
end


