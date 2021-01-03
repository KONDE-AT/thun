xquery version "3.0";
import module namespace util   = "http://exist-db.org/xquery/util";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";

import module namespace config="http://www.digital-archiv.at/ns/config" at "modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/templates" at "modules/app.xql";
import module namespace enrich="http://www.digital-archiv.at/ns/enrich" at "modules/enrich.xql";


(: grant general execution rights to all scripts in analyze and modules collection :)
for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/analyze/"))
    return sm:chmod(xs:anyURI($config:app-root||'/analyze/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/modules/"))
    return sm:chmod(xs:anyURI($config:app-root||'/modules/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/ac/"))
    return sm:chmod(xs:anyURI($config:app-root||'/ac/'||$resource), "rwxrwxr-x"),

util:log("info", "#################################"),
util:log("info", "adding xml-ids"),
util:log("info", "#################################"),
enrich:add_base_and_xmlid('https://id.acdh.oeaw.ac.at/thun/', 'editions'),

util:log("info", "#################################"),
util:log("info", "deleting entities without xml:id"),
util:log("info", "#################################"),
for $x in ('person', 'place', 'org')
    return enrich:delete_entities_without_xmlid($x),

util:log("info", "#################################"),
util:log("info", "adding mentions to index-files"),
util:log("info", "#################################"),
enrich:mentions('editions', 'org'),
enrich:mentions('editions', 'person'),
enrich:mentions('editions', 'place'),

util:log("info", "#################################"),
util:log("info", "fixing order of place-child-nodes"),
util:log("info", "#################################"),
let $xml := doc($app:placeIndex)
let $xsl := doc($app:process||'/fix-order.xsl')
let $out := transform:transform($xml, $xsl, ())
let $collection-uri := $app:indices
let $resource-name := 'listplace.xml'
let $store := xmldb:store($collection-uri, $resource-name, $out)
return $store,

util:log("info", "#################################"),
util:log("info", "remove tei:list* elements in tei:back"),
util:log("info", "#################################"),
enrich:delete_lists_in_back('editions'),

util:log("info", "#################################"),
util:log("info", "denormalize indices"),
util:log("info", "#################################"),
for $x in ('person', 'place', 'org')
    return enrich:denormalize_index('editions', $x)