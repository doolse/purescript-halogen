module Halogen.RenderDSL where

import Prelude
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

foreign import data Tree :: (* -> *) -> * -> *
