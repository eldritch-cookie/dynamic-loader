{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module System.Plugins.Criteria.UnsafeCriterion (Criterion (..)) where

import System.Plugins.Criteria.LoadCriterion
import System.Plugins.DynamicLoader

instance LoadCriterion () t where
  data Criterion () t = UnsafeCriterion
  type Effective () t = IO t
  loadQualified UnsafeCriterion = loadQualifiedFunction
