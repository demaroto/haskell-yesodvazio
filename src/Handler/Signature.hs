{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Signature where

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
    <*> areq passwordField "Digite Novamente: " Nothing
    
--getUsuarioR :: Handler Html
{- getUsuarioR = do 
    (widget,_) <- generateFormPost formSig
    msg <- getMessage
    defaultLayout $ do
        sess <- lookupSession "_SIG"
        setTitle "PeticaoVerao"
        $(whamletFile "templates/header.hamlet")
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_main_css)
        $(whamletFile "templates/usuario.hamlet") -}
        
postSignatureR :: Handler Html
postSignatureR = do 
    ((result,_),_) <- runFormPost formSig
    case result of 
        FormSuccess (signature,verifica) -> do 
            if (signatureEmail signature == verifica) then do 
                runDB $ insert signature 
                setMessage [shamlet|
                    <div>
                        Assinatura cadastrada
                |]
                redirect HomeR
            else do 
                setMessage [shamlet|
                    <div>
                        Todos os campos são obrigatórios
                |]
                redirect HomeR
        _ -> redirect HomeR