module Halogen.RenderDSL where

import Prelude
import Data.Lazy (Lazy)
import Data.Tuple (Tuple)

type SlotCreator h = forall a b. a -> h a b

class RenderDSL h where
  initialTree :: forall f. h Void (f Unit) -> Tree f Unit
  installChildren :: forall st p t i i'.
      (SlotCreator h -> p -> st -> Tuple (h t i') st)
      -> (i -> i')
      -> h p i
      -> st
      -> Tuple (h t i') st
  makeTree :: forall f p'. Eq p' => Lazy (h (Tree f p') (f Unit)) -> Tree f Unit
  graftTree :: forall f f' p p'. f ~> f' -> (p -> p') -> Tree f p -> Tree f' p'
  thunkTree :: forall f p. Tree f p -> Tree f p
  emptyTree :: forall f. Tree f Unit

foreign import data Tree :: (* -> *) -> * -> *
