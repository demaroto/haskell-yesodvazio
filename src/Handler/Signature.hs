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
    signatures <- runDB $ selectList [] [Asc SignatureNome]
    defaultLayout $ do 
        $(whamletFile "templates/assinatures.hamlet")