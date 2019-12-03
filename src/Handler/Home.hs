{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Text.Lucius
import Text.Julius
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        toWidgetHead $(luciusFile "templates/css.lucius")
        toWidgetHead $(luciusFile "templates/mobile.lucius")
        toWidgetHead $(luciusFile "templates/home.julius")
        $(whamletFile "templates/home.hamlet")