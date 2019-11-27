{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Text.Lucius -- css
import Text.Julius
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        addStylesheet (StaticR css_css_css)
        addStylesheet (StaticR css_mobile_css)
        --toWidgetHead $(luciusFile "templates/aaa.lucius")
        toWidgetHead $(luciusFile "templates/home.julius")
        $(whamletFile "templates/home.hamlet")