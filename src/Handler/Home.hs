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

formSig :: Form (Signature, Text)
formSig = renderBootstrap $ (,)
    <$> (Signature
        <$> areq textField "Nome: " Nothing
        <*> areq emailField "E-mail: " Nothing
    <*> areq (selectField $ optionsPairs [(MsgValue1, "value1"),(MsgValue2, "value2")]) "Which value?" Nothing

getHomeR :: Handler Html
getHomeR = do
    (widget,_) <- generateFormPost formSig
    msg <- getMessage
    defaultLayout $ do
        addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"
        toWidgetHead $(luciusFile "templates/css.lucius")
        toWidgetHead $(luciusFile "templates/mobile.lucius")
        toWidgetHead $(juliusFile "templates/js.julius")
        $(whamletFile "templates/home.hamlet")

postHomeR :: Handler Html
postHomeR = do 
    ((result,_),_) <- runFormPost formSig
    case result of 
        FormSuccess (sig,veri) -> do 
            if (sigEmail sig == veri) then do 
                runDB $ insert sig 
                setMessage [shamlet|
                    <div>
                        Assinatura cadastrada
                |]
                redirect HomeR
            else do 
                setMessage [shamlet|
                    <div>
                        E-mail não é válido
                |]
                redirect HomeR
        _ -> redirect HomeR