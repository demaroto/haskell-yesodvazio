{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed(embedFile)
import Text.Lucius
import Text.Julius
import Database.Persist.Postgresql

formSig :: Form Signature 
formSig = renderBootstrap $ Signature
    <$> areq textField "Nome: " Nothing
    <*> areq emailField "Email: " Nothing
    <*> areq textField "Estado: " Nothing
  
getHomeR :: Handler Html
getHomeR = do
    (widget,_) <- generateFormPost formSig
    msg <- getMessage
    defaultLayout $ do
        toWidgetHead [hamlet|
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
        |]
        setTitle "Petição Verão | Assine"
        addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"
        toWidgetHead $(luciusFile "templates/css.lucius")
        toWidgetHead $(luciusFile "templates/mobile.lucius")
        toWidgetHead $(juliusFile "templates/js.julius")
        $(whamletFile "templates/home.hamlet")

postHomeR :: Handler Html
postHomeR = do 
    ((result,_),_) <- runFormPost formSig
    case result of 
        FormSuccess sig -> do 
            runDB $ insert sig 
            setMessage [shamlet|
                <div>
                    Peticao feita com sucesso.
            |]
            redirect HomeR
        _ -> redirect HomeR
    redirect HomeR