{-# LANGUAGE TypeFamilies #-}

module Ind2_help where

import Data.Kind (Type)

class C a where
  data T a :: Type
  unT :: T a -> a
  mkT :: a -> T a

instance (C a, C b) => C (a,b) where
  data T (a,b) = TProd (T a) (T b)
  unT (TProd x y) = (unT x, unT y)
  mkT (x,y)       = TProd (mkT x) (mkT y)

