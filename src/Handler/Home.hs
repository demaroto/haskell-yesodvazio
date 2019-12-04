{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
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
       -- toWidgetHead([hamlet|<meta name=viewport content=#{width=device width, initial scale=1.0}>|])
        addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"
        toWidgetHead $(luciusFile "templates/css.lucius")
        toWidgetHead $(luciusFile "templates/mobile.lucius")
        toWidgetHead $(juliusFile "templates/js.julius")
        $(whamletFile "templates/home.hamlet")