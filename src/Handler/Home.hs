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
        addScriptRemote "https://code.jquery.com/jquery-3.4.1.js"
        toWidgetHead $(luciusFile "templates/css.lucius")
        toWidgetHead $(luciusFile "templates/mobile.lucius")
        toWidgetHead $(juliusFile "templates/js.julius")
        $(whamletFile "templates/home.hamlet")