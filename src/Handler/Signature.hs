{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Signature where

import Import
import Text.Lucius
import Text.Julius
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql


getListSignatureR :: Handler Html
getListSignatureR = do
    -- select * from signature order by signature.nome
    signatures <- runDB $ selectList [] [Asc SignatureName]
    defaultLayout $ do 
        toWidgetHead [hamlet|
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
        |]
        setTitle "Petição Verão | Assine"
        addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"
        toWidgetHead $(luciusFile "templates/css.lucius")
        toWidgetHead $(luciusFile "templates/mobile.lucius")
        toWidgetHead $(juliusFile "templates/js.julius")
        $(whamletFile "templates/assinaturas.hamlet")