xquery version "3.1";

declare namespace functx = "http://www.functx.com";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace util="http://exist-db.org/xquery/util";
import module namespace config="http://www.digital-archiv.at/ns/thun/config" at "../modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/thun/templates" at "../modules/app.xql";

for $x in collection($config:data-root)//tei:idno[@subtype='handle']
    let $type := update delete $x/@type
    let $subtype := update delete $x/@subtype
    let $newtype := update insert attribute type {'handle'} into $x
(:    let $p := $x/tei:p:)
(:    let $idno := $x/tei:idno:)
(:    let $add_subtype := update insert attribute subtype {'handle'} into $idno:)
(:    let $newp := update insert $idno into $p:)
(:    let $rm_idno := update delete $idno :)
    return $x